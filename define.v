`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/20 09:18:35
// Design Name: 
// Module Name: define
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
//*******total definition********
`define RstEnable 1'b1
`define RstDisable 1'b0
`define ZeroWord 32'h00000000
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define ReadEnable 1'b1
`define ReadDisable 1'b0
`define AluOpBus 7:0
`define AluSelBus 2:0
`define InstValid 1'b0
`define InstInValid 1'b1
`define True_v 1'b1
`define False_v 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0
//********instruct related**************
`define EXE_ORI 6'b001101
`define EXE_NOP 6'b000000

`define EXE_OR_OP 8'b00100101
`define EXE_NOP_OP 8'b00000000

`define EXE_RES_LOGIC 3'b001
`define EXE_RES_NOP 3'b000

`define InstAddrBus 31:0
`define InstBus 31:0
`define InstMemNum 131071
`define InstMemNumlog2 17
//*********Regfile***********
`define RegAddrBus 4:0
`define RegBus 31:0
`define RegWidth 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0
`define RegNum 32
`define RegNumLog2 5
`define NOPRegAddr 5'b00000




