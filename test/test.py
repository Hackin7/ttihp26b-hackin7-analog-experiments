# SPDX-FileCopyrightText: © 2026 Hackin7
# SPDX-License-Identifier: Apache-2.0

"""Tiny Tapeout top-level cocotb tests for the 64-bit counter."""

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

# ui_in bit map (see info.yaml / docs/info.md)
# [0]    counter enable
# [1]    clock select: 0 = Tiny Tapeout clk, 1 = ring oscillator
# [4:2]  counter byte select


def ui_in_val(enable=0, clk_ring=0, byte_sel=0):
    return (enable & 1) | ((clk_ring & 1) << 1) | ((byte_sel & 7) << 2)


def read_u8(signal):
    value = signal.value
    assert value.is_resolvable, f"{signal._name} is {value}"
    return int(value)


async def start_clock(dut):
    # Slow period so the same tests can run against a gate-level netlist.
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())


async def wait_cycles(dut, n=1):
    """Wait n rising edges, then settle past the NBA update."""
    await ClockCycles(dut.clk, n)
    await Timer(1, unit="ns")


async def settle():
    await Timer(1, unit="ns")


async def reset(dut, *, enable=0, clk_ring=0, byte_sel=0):
    dut.ena.value = 1
    dut.uio_in.value = 0
    dut.ui_in.value = ui_in_val(enable=enable, clk_ring=clk_ring, byte_sel=byte_sel)
    dut.rst_n.value = 0
    await wait_cycles(dut, 4)
    dut.rst_n.value = 1
    await wait_cycles(dut, 1)


def assert_uio_tied_off(dut):
    assert read_u8(dut.uio_out) == 0, f"uio_out should be tied off, got {dut.uio_out.value}"
    assert read_u8(dut.uio_oe) == 0, f"uio_oe should be tied off, got {dut.uio_oe.value}"


@cocotb.test()
async def test_reset_clears_counter(dut):
    dut._log.info("reset clears the selected counter byte")
    await start_clock(dut)
    await reset(dut, enable=1, byte_sel=0)

    # enable=1 through reset-release means one increment already happened.
    await wait_cycles(dut, 7)
    assert read_u8(dut.uo_out) == 8

    dut.rst_n.value = 0
    await wait_cycles(dut, 2)
    assert read_u8(dut.uo_out) == 0
    assert_uio_tied_off(dut)

    dut.rst_n.value = 1
    await wait_cycles(dut, 1)
    assert read_u8(dut.uo_out) == 1


@cocotb.test()
async def test_enable_and_freeze(dut):
    dut._log.info("ui_in[0] gates counting; freeze holds the value")
    await start_clock(dut)
    await reset(dut, enable=0, byte_sel=0)
    assert read_u8(dut.uo_out) == 0

    await wait_cycles(dut, 5)
    assert read_u8(dut.uo_out) == 0, "counter must not increment while disabled"

    dut.ui_in.value = ui_in_val(enable=1, byte_sel=0)
    await wait_cycles(dut, 5)
    assert read_u8(dut.uo_out) == 5

    dut.ui_in.value = ui_in_val(enable=0, byte_sel=0)
    await wait_cycles(dut, 8)
    assert read_u8(dut.uo_out) == 5, "counter must freeze while ui_in[0] is low"
    assert_uio_tied_off(dut)


@cocotb.test()
async def test_chip_ena_freeze(dut):
    dut._log.info("Tiny Tapeout ena also gates counting")
    await start_clock(dut)
    await reset(dut, enable=1, byte_sel=0)
    await wait_cycles(dut, 3)
    assert read_u8(dut.uo_out) == 4

    dut.ena.value = 0
    await wait_cycles(dut, 6)
    assert read_u8(dut.uo_out) == 4, "counter must freeze while ena is low"

    dut.ena.value = 1
    await wait_cycles(dut, 2)
    assert read_u8(dut.uo_out) == 6


@cocotb.test()
async def test_increments_and_byte0_rollover(dut):
    dut._log.info("byte 0 counts 0..255 then rolls over; byte 1 becomes 1")
    await start_clock(dut)
    await reset(dut, enable=0, byte_sel=0)

    dut.ui_in.value = ui_in_val(enable=1, byte_sel=0)
    for expected in range(1, 256):
        await wait_cycles(dut, 1)
        got = read_u8(dut.uo_out)
        assert got == expected, f"byte 0: expected {expected}, got {got}"

    await wait_cycles(dut, 1)
    assert read_u8(dut.uo_out) == 0, "byte 0 should wrap to 0 after 256 counts"

    dut.ui_in.value = ui_in_val(enable=0, byte_sel=1)
    await settle()
    assert read_u8(dut.uo_out) == 1, "byte 1 should be 1 after 256 counts"


@cocotb.test()
async def test_byte_select(dut):
    dut._log.info("ui_in[4:2] selects which counter byte is driven on uo_out")
    await start_clock(dut)
    await reset(dut, enable=0, byte_sel=0)

    # Count to 0x0105: byte0=5, byte1=1, others=0.
    dut.ui_in.value = ui_in_val(enable=1, byte_sel=0)
    await wait_cycles(dut, 0x105)

    expected = [0x05, 0x01, 0, 0, 0, 0, 0, 0]
    for byte_sel, want in enumerate(expected):
        dut.ui_in.value = ui_in_val(enable=0, byte_sel=byte_sel)
        await settle()
        got = read_u8(dut.uo_out)
        assert got == want, f"byte {byte_sel}: expected {want:#04x}, got {got:#04x}"

    assert_uio_tied_off(dut)


@cocotb.test()
async def test_clock_select_ring_idle(dut):
    dut._log.info("selecting the undriven ring clock freezes the counter")
    await start_clock(dut)
    # Change ui_in[1] only while reset is asserted.
    await reset(dut, enable=1, clk_ring=1, byte_sel=0)

    await wait_cycles(dut, 8)
    assert read_u8(dut.uo_out) == 0, "idle ring stub must not clock the counter"
    assert_uio_tied_off(dut)


@cocotb.test()
async def test_clock_select_ring_toggles(dut):
    dut._log.info("a toggling ring stub clocks the counter through the mux")
    await start_clock(dut)
    await reset(dut, enable=1, clk_ring=1, byte_sel=0)

    try:
        osc = dut.user_project.u_ring_oscillator.osc
        osc.value = 0
    except AttributeError:
        dut._log.info("ring osc stub is not accessible; skipping toggle check")
        return

    cocotb.start_soon(Clock(osc, 100, unit="ns").start())
    await Timer(2, unit="us")
    count = read_u8(dut.uo_out)
    assert count > 0, "counter should increment on the ring stub clock"

    dut.ui_in.value = ui_in_val(enable=0, clk_ring=1, byte_sel=0)
    await settle()
    frozen = read_u8(dut.uo_out)
    await Timer(1, unit="us")
    assert read_u8(dut.uo_out) == frozen, "enable must still freeze in ring-clock mode"
