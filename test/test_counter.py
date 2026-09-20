# SPDX-FileCopyrightText: © 2026 Hackin7
# SPDX-License-Identifier: Apache-2.0

"""Direct cocotb tests for the digital_counter leaf."""

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer


def read_u8(signal):
    value = signal.value
    assert value.is_resolvable, f"{signal._name} is {value}"
    return int(value)


async def start_clock(dut):
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())


async def wait_cycles(dut, n=1):
    await ClockCycles(dut.clk, n)
    await Timer(1, unit="ps")


async def settle():
    await Timer(1, unit="ps")


async def reset(dut, *, ena=0, byte_sel=0):
    dut.ena.value = ena
    dut.byte_sel.value = byte_sel
    dut.rst_n.value = 0
    await wait_cycles(dut, 4)
    dut.rst_n.value = 1
    await wait_cycles(dut, 1)


@cocotb.test()
async def test_reset(dut):
    await start_clock(dut)
    await reset(dut, ena=1, byte_sel=0)
    await wait_cycles(dut, 7)
    assert read_u8(dut.uo_out) == 8

    dut.rst_n.value = 0
    await wait_cycles(dut, 1)
    assert read_u8(dut.uo_out) == 0

    dut.rst_n.value = 1
    await wait_cycles(dut, 1)
    assert read_u8(dut.uo_out) == 1


@cocotb.test()
async def test_enable_freeze(dut):
    await start_clock(dut)
    await reset(dut, ena=0, byte_sel=0)
    await wait_cycles(dut, 4)
    assert read_u8(dut.uo_out) == 0

    dut.ena.value = 1
    await wait_cycles(dut, 9)
    assert read_u8(dut.uo_out) == 9

    dut.ena.value = 0
    await wait_cycles(dut, 5)
    assert read_u8(dut.uo_out) == 9


@cocotb.test()
async def test_count_and_byte_select(dut):
    await start_clock(dut)
    await reset(dut, ena=0, byte_sel=0)

    dut.ena.value = 1
    await wait_cycles(dut, 0x0203)

    expected = {0: 0x03, 1: 0x02}
    for byte_sel in range(8):
        dut.byte_sel.value = byte_sel
        await settle()
        got = read_u8(dut.uo_out)
        want = expected.get(byte_sel, 0)
        assert got == want, f"byte {byte_sel}: expected {want:#04x}, got {got:#04x}"


@cocotb.test()
async def test_byte0_wraps(dut):
    await start_clock(dut)
    await reset(dut, ena=0, byte_sel=0)

    dut.ena.value = 1
    await wait_cycles(dut, 256)
    assert read_u8(dut.uo_out) == 0

    dut.byte_sel.value = 1
    await settle()
    assert read_u8(dut.uo_out) == 1
    dut.byte_sel.value = 0
    await settle()

    await wait_cycles(dut, 1)
    assert read_u8(dut.uo_out) == 1
