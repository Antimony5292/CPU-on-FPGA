`include "define.v"
module inst_rom(
    input wire ce,
    input wire[`InstAddrBus] addr,
    output reg[`InstBus] inst
);

reg[`InstBus] inst_mem[0:`InstMemNum-1];
initial $readmemh ("inst_rom.data",isnt_rom);

always@(*) begin
    if (ce == `ChipDisable) begin
        inst <= `ZeroWord;
    end else begin
        inst <= inst_rom[addr[`InstMemNumLog2+1:2]];
    end
end

endmodule