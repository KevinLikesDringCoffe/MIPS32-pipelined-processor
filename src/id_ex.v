`timescale 1ns / 1ps
`include "definations.vh"

module id_ex(
    input clk,
    input rst,
    input [31:0] id_rdata1,
    input [31:0] id_rdata2,
    input [31:0] id_ext_imm,
    input [4:0] id_sa,
    input id_sa_en,
    input [`aluop_bit] id_aluop,
    input id_mem_wr,
    input id_reg_wr,
    input [4:0] id_waddr,
    input [1:0] id_instr_type,
    input [`cond_bit] id_cond,
    
    output reg [31:0] ex_rdata1,
    output reg [31:0] ex_rdata2,
    output reg [31:0] ex_ext_imm,
    output reg [4:0] ex_sa,
    output reg ex_sa_en,
    output reg [`aluop_bit] ex_aluop,
    output reg ex_mem_wr,
    output reg ex_reg_wr,
    output reg [4:0] ex_waddr,
    output reg [1:0] ex_instr_type,
    output reg [`cond_bit] ex_cond
);

always @ (posedge clk) begin
    if(rst) begin
        ex_rdata1 <= 32'h00000000;
        ex_rdata2 <= 32'h00000000;
        ex_ext_imm <= 32'h00000000;
        ex_sa <= 5'h0;
        ex_sa_en <= 1'b0;
        ex_aluop <= 2'b00;
        ex_mem_wr <= 1'b0;
        ex_reg_wr <= 1'b0;
        ex_waddr <= 5'h0;
        ex_instr_type <= `type_i;
        ex_cond <= `no_cond;
    end
    else begin
        ex_rdata1 <= id_rdata1;
        ex_rdata2 <= id_rdata2;
        ex_ext_imm <= id_ext_imm;
        ex_sa <= id_sa;
        ex_sa_en <= id_sa_en;
        ex_aluop <= id_aluop;
        ex_mem_wr <= id_mem_wr;
        ex_reg_wr <= id_reg_wr;
        ex_waddr <= id_waddr;
        ex_instr_type <= id_instr_type;
        ex_cond <= id_cond;
    end
end
endmodule
