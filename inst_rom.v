`timescale 1ns / 1ps
`include "define.v"
module inst_rom(
    input wire ce,
    input wire[`InstAddrBus] addr,
    output reg[`InstBus] inst
);

reg[`InstBus] inst_mem[0:`InstMemNum-1];
initial $readmemh ("D:/Xilinx/ori/ori.srcs/sources_1/new/inst_rom.data",inst_mem);

always@(*) begin
    if (ce == `ChipDisable) begin
        inst <= `ZeroWord;
    end else begin
        inst <= inst_mem[addr[`InstMemNumlog2+1:2]];
    end
end

endmodule