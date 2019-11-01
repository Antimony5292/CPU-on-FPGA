`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/22 22:16:51
// Design Name: 
// Module Name: openmips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "define.v"

module openmips(
    input wire clk,
    input wire rst,
    input wire[`RegBus] rom_data_i,
    output wire[`RegBus] rom_addr_o,
    output wire rom_ce_o
    );
    
    wire [`InstAddrBus] pc;
    wire [`InstAddrBus] id_pc_i;
    wire [`InstBus] id_inst_i;
    
    wire [`AluOpBus] id_aluop_o;
    wire [`AluSelBus] id_alusel_o;
    wire [`RegBus] id_reg1_o;
    wire [`RegBus] id_reg2_o;
    wire [`RegAddrBus] id_wd_o;
    wire id_wreg_o;
    
    wire [`AluOpBus] ex_aluop_i;
    wire [`AluSelBus] ex_alusel_i;
    wire [`RegBus] ex_reg1_i;
    wire [`RegBus] ex_reg2_i;
    wire [`RegAddrBus] ex_wd_i;
    wire ex_wreg_i;
    
    wire ex_wreg_o;
    wire [`RegAddrBus] ex_wd_o;
    wire [`RegBus] ex_wdata_o;
    
    wire [`RegBus] mem_wdata_i;
    wire [`RegAddrBus] mem_wd_i;
    wire mem_wreg_i;
    
    wire mem_wreg_o;
    wire [`RegAddrBus] mem_wd_o;
    wire [`RegBus] mem_wdata_o;
    
    wire [`RegAddrBus] wb_wd_i;
    wire [`RegBus] wb_wdata_i;
    wire wb_wreg_i;
    
    wire reg1_read;
    wire reg2_read;
    wire [`RegBus] reg1_data;
    wire [`RegBus] reg2_data;
    wire [`RegAddrBus] reg1_addr;
    wire [`RegAddrBus] reg2_addr;
    
    pc_reg u1(.rst(rst),.clk(clk),.pc(pc),.ce(rom_ce_o));
    assign rom_addr_o = pc;
    
    if_id u2(.if_pc(pc),.if_inst(rom_data_i),.rst(rst),.clk(clk),
    .id_pc(id_pc_i),.id_inst(id_inst_i));
    
    id u3(.pc_i(id_pc_i),.inst_i(id_inst_i),.rst(rst),.reg1_data_i(reg1_data),.reg2_data_i(reg2_data),
    .aluop_o(id_aluop_o),.alusel_o(id_alusel_o),.reg1_o(id_reg1_o),.reg2_o(id_reg2_o),
    .wd_o(id_wd_o),.wreg_o(id_wreg_o),.reg2_addr_o(reg2_addr),.reg2_read_o(reg2_read),
    .reg1_addr_o(reg1_addr),.reg1_read_o(reg1_read));
    
    regfile u4(.re1(reg1_read),.raddr1(reg1_addr),.re2(reg2_read),.raddr2(reg2_addr),
    .we(wb_wreg_i),.waddr(wb_wd_i),.wdata(wb_wdata_i),
    .rdata2(reg2_data),.rdata1(reg1_data));
    
    id_ex u5(.id_aluop(id_aluop_o),.id_alusel(id_alusel_o),
    .id_reg1(id_reg1_o),.id_reg2(id_reg2_o),.id_wd(id_wd_o),.id_wreg(id_wreg_o),
    .rst(rst),.clk(clk),.ex_aluop(ex_aluop_i),.ex_alusel(ex_alusel_i),
    .ex_reg1(ex_reg1_i),.ex_reg2(ex_reg2_i),.ex_wd(ex_wd_i),.ex_wreg(ex_wreg_i));

    ex u6(.rst(rst),
          .aluop_i(ex_aluop_i),.alusel_i(ex_alusel_i),.reg1_i(ex_reg1_i),
          .reg2_i(ex_reg2_i),.wd_i(ex_wd_i),.wreg_i(ex_wreg_i),
          .wdata_o(ex_wdata_o),.wd_o(ex_wd_o),.wreg_o(ex_wreg_o));
    
    ex_mem u7(.rst(rst),.clk(clk),
            .ex_wdata(ex_wdata_o),.ex_wd(ex_wd_o),.ex_wreg(ex_wreg_o),
            .mem_wdata(mem_wdata_i),.mem_wd(mem_wd_i),.mem_wreg(mem_wreg_i));

    mem u8(.rst(rst),
            .wdata_i(mem_wdata_i),.wd_i(mem_wd_i),.wreg_i(mem_wreg_i),
            .wdata_o(mem_wdata_o),.wd_o(mem_wd_o),.wreg_o(mem_wreg_o));
    
    mem_wb u9(.rst(rst),.clk(clk),
            .mem_wdata(mem_wdata_o),.mem_wd(mem_wd_o),.mem_wreg(mem_wreg_o),
            .wb_wdata(wb_wdata_i),.wb_wd(wb_wd_i),.wb_wreg(wb_wreg_i));

endmodule
