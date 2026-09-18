#!/usr/bin/env bash
#
# Hardens a Tiny Tapeout IHP26b project locally with LibreLane, run inside WSL2.
# Mirrors the CI gds workflow (TinyTapeout/tt-gds-action@ttihp26b):
#   python tt/t_tool.py --create-user-config --ihp
#   python tt/t_tool.py --harden --ihp
#   python tt/t_tool.py --print-warnings --ihp
#
# Usage:
#   tools/local/build.sh [--skip-setup] [--force-setup] [REPO]
#
# REPO defaults to the repo containing this script (as seen from Linux).
# On the first run pip builds nothing from source when wheels exist
# (lln-libparse ships manylinux wheels), so no compiler toolchain is needed.
#
# Prerequisites inside WSL: a running dockerd. The Windows wrapper
# (build.ps1) starts it automatically; if running build.sh standalone,
# start dockerd first (e.g. `wsl -u root -e dockerd --iptables=false &`).

set -euo pipefail

# ---- locate repo ----
REPO=""
SKIP_SETUP=""
FORCE_SETUP=""
for arg in "$@"; do
  case "$arg" in
    --skip-setup) SKIP_SETUP=1 ;;
    --force-setup) FORCE_SETUP=1 ;;
    -*) : ;;
    *) REPO="$arg" ;;
  esac
done
if [ -z "$REPO" ]; then
  REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
fi

TTSETUP="${HOME}/ttsetup"
VENV="${TTSETUP}/venv"
PDK_ROOT="${TTSETUP}/pdk"
TT_DIR="${REPO}/tt"
SETUP_MARKER="${TTSETUP}/.setup-ok"
LIBRELANE_TAG="${LIBRELANE_TAG:-3.0.5}"   # must match tt-gds-action default
TT_SUPPORT_TOOLS_REF=main

log() { printf '[%s] %s\n' "$(basename "$0")" "$*"; }

mkdir -p "$TTSETUP"

# ---- docker reachable from WSL? ----
# Uses the native dockerd running inside this WSL distro (started by
# build.ps1 before this script). /var/run/docker.sock is root:docker and
# the user belongs to the docker group.
if ! docker info >/dev/null 2>&1; then
  echo "[build] docker engine not reachable inside WSL." >&2
  echo "        Ensure dockerd is running: wsl -u root -e dockerd --iptables=false &" >&2
  exit 2
fi
log "docker engine OK (native dockerd in WSL)"

# ---- WSL drvfs git compatibility, scoped via env (no global git config) ----
export GIT_CONFIG_COUNT=1
export GIT_CONFIG_KEY_0=safe.directory
export GIT_CONFIG_VALUE_0="${REPO//\\//}"

export PDK_ROOT PDK=ihp-sg13g2
export PATH="$VENV/bin:$PATH"   # yowasp-yosys etc. live in the venv bin

# ---- setup (idempotent) ----
setup() {
  if [ -n "$SKIP_SETUP" ]; then
    return
  fi
  if [ -f "$SETUP_MARKER" ] && [ -z "$FORCE_SETUP" ]; then
    log "setup marker exists - skipping venv/tt/pip (use --force-setup to redo)"
    return
  fi
  if [ -f "$SETUP_MARKER" ]; then rm -f "$SETUP_MARKER"; fi

  if [ ! -x "$VENV/bin/python" ]; then
    log "creating venv at $VENV"
    python3 -m venv "$VENV"
  fi

  if [ ! -f "$TT_DIR/tt_tool.py" ]; then
    log "cloning tt-support-tools -> $TT_DIR"
    git clone --branch "$TT_SUPPORT_TOOLS_REF" \
      https://github.com/TinyTapeout/tt-support-tools "$TT_DIR"
  fi

  log "installing tt-support-tools requirements + librelane==$LIBRELANE_TAG"
  "$VENV/bin/python" -m pip install --quiet --upgrade pip
  "$VENV/bin/python" -m pip install --quiet -r "$TT_DIR/requirements.txt"
  "$VENV/bin/python" -m pip install --quiet "librelane==$LIBRELANE_TAG"

  touch "$SETUP_MARKER"
  log "setup done"
}

run_tt() {
  log "tt_tool.py $*"
  "$VENV/bin/python" "$TT_DIR/tt_tool.py" "$@"
}

# ---- main ----
setup

cd "$REPO"
run_tt --create-user-config --ihp
run_tt --harden --ihp
run_tt --print-warnings --ihp

log "artifacts:"
for f in "${REPO}"/runs/wokwi/final/gds/*.gds "${REPO}"/runs/wokwi/final/lef/*.lef; do
  [ -e "$f" ] && log "  $f"
done
log "done"