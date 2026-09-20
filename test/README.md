# Testbenches for TinyAnalogExperiments

Cocotb tests for the 64-bit `digital_counter`, using the Tiny Tapeout IHP
flow ([docs](https://tinytapeout.com/hdl/testing/)).

| Command | What it runs |
| --- | --- |
| `make -B` | RTL sim of the Tiny Tapeout top (`project.v` + counter) |
| `make -B COUNTER=1` | Direct RTL sim of the `digital_counter` leaf |
| `make -B GATES=yes` | Gate-level sim of the hardened netlist |

The analog `ring_oscillator` macro is a GDS blackbox, so RTL/GL sim uses
`ring_oscillator_sim.v`. The stub idles at 0; tests may drive its `osc` reg
to exercise the clock mux.

## Setting up

On Ubuntu / WSL:

```sh
sudo apt-get install -y iverilog make python3 python3-venv
python3 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

## How to run

From this `test/` directory, with the venv active:

```sh
make -B
make -B COUNTER=1
```

To run gate-level simulation, harden the project and copy the GL netlist to
`gate_level_netlist.v`, then:

```sh
make -B GATES=yes
```

If you wish to save the waveform in VCD format instead of FST format, edit
`tb.v` to use `$dumpfile("tb.vcd");` and then run:

```sh
make -B FST=
```

## How to view the waveform file

Using GTKWave:

```sh
gtkwave tb.fst tb.gtkw
```

Using Surfer:

```sh
surfer tb.fst
```
