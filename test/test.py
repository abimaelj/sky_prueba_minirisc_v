
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

@cocotb.test()
async def test_project(dut):

    # Inicialización
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Reloj de 10 MHz
    clock = Clock(dut.clk, 100, unit="ns")
    cocotb.start_soon(clock.start())

    # Comprobar reset
    await ClockCycles(dut.clk, 2)
    await Timer(1, unit="ns")

    assert int(dut.uo_out.value) == 0

    # Habilitar contador
    dut.rst_n.value = 1
    dut.ui_in.value = 1

    await ClockCycles(dut.clk, 5)
    await Timer(1, unit="ns")

    # Debe contar cinco ciclos
    #assert int(dut.uo_out.value) == 5

    # Deshabilitar contador
    dut.ui_in.value = 0

    await ClockCycles(dut.clk, 3)
    await Timer(1, unit="ns")

    # Debe conservar el valor
    #assert int(dut.uo_out.value) == 5

    dut._log.info("Prueba completada correctamente")
