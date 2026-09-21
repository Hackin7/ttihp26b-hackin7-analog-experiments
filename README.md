![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg)

# TinyAnalogExperiments — IHP26b mixed-signal project

This project targets one IHP SG13G2 1×1 Tiny Tapeout tile. The top cell is a
thin hierarchical assembler:

- analog leaves `ring_oscillator` (~100 MHz) and `ring_oscillator_500mhz` (~500 MHz)
- digital leaf `digital_counter` (synthesized RTL)
- clock mux glue in `src/project.v` (`ui_in[1]` / `ui_in[5]`)

LibreLane auto-routes all Verilog signal nets, including the ring outputs.
See [docs/hierarchy.md](docs/hierarchy.md) for how to add more leaves.
See [docs/transistor_ring_flow.md](docs/transistor_ring_flow.md) for the
analog ring schematic → layout → LVS → GDS flow.

Part 1 established the IHP26b LibreLane CI flow. Analog source layout lives
under `analog/transistor_ring_oscillator/` and
`analog/transistor_ring_oscillator_500mhz/`. The older stdcell ring under
`analog/inverter_ring_oscillator/` is kept as reference.

## Local hardening

Instead of pushing and waiting for CI, build the GDS locally (mirrors the
`gds` workflow — same `tt-support-tools` and `librelane==3.0.5`, same invoked
LibreLane flow):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/local/build.ps1
```

Requirements: Docker Desktop running (with WSL2 integration) and a default WSL
distro. The build runs inside WSL because LibreLane's `lln-libparse` dependency
ships prebuilt Linux wheels but no Windows wheels. The first run downloads the
IHP PDK into `~/ttsetup/pdk` in the WSL distro (a few GB) and creates a venv at
`~/ttsetup/venv`; later runs are fast. Artifacts appear under
`runs/wokwi/final/`. Re-runs can use `-SkipSetup`; use `-ForceSetup` to refresh
`tt-support-tools`/pip dependencies. The underlying flow is in
`tools/local/build.sh`.

- [Read the documentation for project](docs/info.md)

## What is Tiny Tapeout?

Tiny Tapeout is an educational project that aims to make it easier and cheaper than ever to get your digital designs manufactured on a real chip.

To learn more and get started, visit https://tinytapeout.com.

## Analog projects

For specifications and instructions, see the [analog specs page](https://tinytapeout.com/specs/analog/).

## Enable GitHub actions to build the results page

- [Enabling GitHub Pages](https://tinytapeout.com/faq/#my-github-action-is-failing-on-the-pages-part)

## Resources

- [FAQ](https://tinytapeout.com/faq/)
- [Digital design lessons](https://tinytapeout.com/digital_design/)
- [Learn how semiconductors work](https://tinytapeout.com/siliwiz/)
- [Join the community](https://tinytapeout.com/discord)

## What next?

- [Submit your design to the next shuttle](https://app.tinytapeout.com/).
- Edit [this README](README.md) and explain your design, how it works, and how to test it.
- Share your project on your social network of choice:
  - LinkedIn [#tinytapeout](https://www.linkedin.com/search/results/content/?keywords=%23tinytapeout) [@TinyTapeout](https://www.linkedin.com/company/100708654/)
  - Mastodon [#tinytapeout](https://chaos.social/tags/tinytapeout) [@matthewvenn](https://chaos.social/@matthewvenn)
  - X (formerly Twitter) [#tinytapeout](https://twitter.com/hashtag/tinytapeout) [@tinytapeout](https://twitter.com/tinytapeout)
  - Bluesky [@tinytapeout.com](https://bsky.app/profile/tinytapeout.com)
