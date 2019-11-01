`timescale 1ns / 1ps
`include "define.v"
module openmips_sopc(
module(
    input wire rst,
    input wire clk
);

wire rom_ce;
wire[`InstAddrBus] inst_addr;
wire[`InstBus] inst;

openmips s0(.rst(rst),.clk(clk),
            .rom_data_i(inst),.rom_ce_o(rom_ce),.rom_addr_o(inst_addr));

inst_rom s1(.ce(rom_ce),.addr(inst_addr),.inst(inst));
rom s1(.ce(rom_ce),.addr(inst_addr),.inst(inst));
endmodule