
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer

@cocotb.test()
async def test_project(dut):

    dut._log.info("Iniciando simulacion")

    # Inicializar entradas
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Reloj con periodo de 100 ns
    clock = Clock(dut.clk, 100, unit="ns")
    cocotb.start_soon(clock.start())

    # Mantener reset durante dos ciclos
    for _ in range(2):
        await RisingEdge(dut.clk)
        await Timer(1, unit="ns")

    assert int(dut.uo_out.value) == 0, \
        "Error: el contador no se reinicio"

    # Liberar reset y habilitar en flanco negativo
    await FallingEdge(dut.clk)
    dut.rst_n.value = 1
    dut.ui_in.value = 1

    # Verificar cinco incrementos
    for esperado in range(1, 6):

        await RisingEdge(dut.clk)
        await Timer(1, unit="ns")

        obtenido = int(dut.uo_out.value)

        dut._log.info(
            f"Esperado={esperado}, Obtenido={obtenido}"
        )

        assert obtenido == esperado, (
            f"Error: esperado {esperado}, "
            f"obtenido {obtenido}"
        )

    # Deshabilitar contador
    await FallingEdge(dut.clk)
    dut.ui_in.value = 0

    # Verificar que mantiene su valor
    for _ in range(3):

        await RisingEdge(dut.clk)
        await Timer(1, unit="ns")

        assert int(dut.uo_out.value) == 5, \
            "Error: contador cambio con enable=0"

    dut._log.info("Todas las pruebas superadas")
