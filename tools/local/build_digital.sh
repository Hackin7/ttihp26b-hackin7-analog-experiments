#!/usr/bin/env bash
#
# Harden digital_counter only via LibreLane. Does not call tt_tool, does not
# use tt_block_*.def, and does not include the analog ring oscillator.
#
# Usage:
#   tools/local/build_digital.sh [--skip-setup] [--force-setup] [REPO]

set -euo pipefail

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
LIBRELANE_TAG="${LIBRELANE_TAG:-3.0.5}"
TT_SUPPORT_TOOLS_REF=main
CONFIG="${REPO}/tools/local/digital_only/config.json"
RUN_DIR="${REPO}/runs/digital_counter"

log() { printf '[%s] %s\n' "$(basename "$0")" "$*"; }

mkdir -p "$TTSETUP"

if ! docker info >/dev/null 2>&1; then
  echo "[build_digital] docker engine not reachable inside WSL." >&2
  exit 2
fi
log "docker engine OK"

export GIT_CONFIG_COUNT=1
export GIT_CONFIG_KEY_0=safe.directory
export GIT_CONFIG_VALUE_0="${REPO//\\//}"
export PDK_ROOT PDK=ihp-sg13g2
export PATH="$VENV/bin:$PATH"

setup() {
  if [ -n "$SKIP_SETUP" ]; then
    return
  fi
  if [ -f "$SETUP_MARKER" ] && [ -z "$FORCE_SETUP" ]; then
    log "setup marker exists - skipping venv/tt/pip"
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

  log "installing librelane==$LIBRELANE_TAG"
  "$VENV/bin/python" -m pip install --quiet --upgrade pip
  "$VENV/bin/python" -m pip install --quiet -r "$TT_DIR/requirements.txt"
  "$VENV/bin/python" -m pip install --quiet "librelane==$LIBRELANE_TAG"
  touch "$SETUP_MARKER"
}

setup

cd "$REPO"
rm -rf "$RUN_DIR"
mkdir -p "$RUN_DIR"

log "LibreLane digital_counter (no tt_tool, no analog)"
"$VENV/bin/python" -m librelane \
  --pdk-root "$PDK_ROOT" \
  --docker-no-tty \
  --dockerized \
  --pdk ihp-sg13g2 \
  --run-tag digital_counter \
  --force-run-dir "$RUN_DIR" \
  --hide-progress-bar \
  "$CONFIG"

log "artifacts:"
for f in "${RUN_DIR}"/final/gds/*.gds "${RUN_DIR}"/final/lef/*.lef; do
  [ -e "$f" ] && log "  $f"
done
log "done"
