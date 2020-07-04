`timescale 1ns / 1ps
`include "definations.vh"

module id_ex(
    input clk,
    input rst,
    input [31:0] id_rdata1,
    input [31:0] id_rdata2,
    input [31:0] id_ext_imm,
    input [4:0] id_sa,
    input [3:0] id_aluop,
    input id_mem_wr,
    input id_reg_wr,
    input [4:0] id_waddr,
    input [1:0] id_reg_wb_src,
    input [1:0] id_alu_src,
    input [31:0] id_pc,
    
    output reg [31:0] ex_rdata1,
    output reg [31:0] ex_rdata2,
    output reg [31:0] ex_ext_imm,
    output reg [4:0] ex_sa,
    output reg [3:0] ex_aluop,
    output reg ex_mem_wr,
    output reg ex_reg_wr,
    output reg [4:0] ex_waddr,
    output reg [1:0] ex_reg_wb_src,
    output reg [1:0] ex_alu_src,
    output reg [31:0] ex_pc
);

always @ (posedge clk) begin
    if(rst) begin
        ex_rdata1 <= 32'h00000000;
        ex_rdata2 <= 32'h00000000;
        ex_ext_imm <= 32'h00000000;
        ex_sa <= 4'b0;
        ex_aluop <= `aluop_or;
        ex_mem_wr <= 1'b0;
        ex_reg_wr <= 1'b0;
        ex_waddr <= 5'h0;
        ex_reg_wb_src <= `wb_src_alu_result;
        ex_alu_src <= `alu_src_rt;
        ex_pc <= 32'h00000000;
    end
    else begin
        ex_rdata1 <= id_rdata1;
        ex_rdata2 <= id_rdata2;
        ex_ext_imm <= id_ext_imm;
        ex_sa <= id_sa;
        ex_aluop <= id_aluop;
        ex_mem_wr <= id_mem_wr;
        ex_reg_wr <= id_reg_wr;
        ex_waddr <= id_waddr;
        ex_reg_wb_src <= id_reg_wb_src;
        ex_alu_src <= id_alu_src;
        ex_pc <= id_pc;
    end
end
endmodule
