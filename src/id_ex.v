`timescale 1ns / 1ps
`include "definations.vh"

module id_ex(
    input clk,
    input rst,
    input [31:0] id_rdata1,
    input [31:0] id_rdata2,
    input [31:0] id_ext_imm,
    input [3:0] id_aluop,
    input id_mem_wr,
    input id_reg_wr,
    input [4:0] id_waddr,
    input [1:0] id_instr_type,
    input id_to_pc,
    input id_to_hi,
    input id_to_lo,
    
    output reg [31:0] ex_rdata1,
    output reg [31:0] ex_rdata2,
    output reg [31:0] ex_ext_imm,
    output reg [3:0] ex_aluop,
    output reg ex_mem_wr,
    output reg ex_reg_wr,
    output reg [4:0] ex_waddr,
    output reg [1:0] ex_instr_type,
    output reg ex_to_pc,
    output reg ex_to_hi,
    output reg ex_to_lo
);

always @ (posedge clk) begin
    if(rst) begin
        ex_rdata1 <= 32'h00000000;
        ex_rdata2 <= 32'h00000000;
        ex_ext_imm <= 32'h00000000;
        ex_aluop <= 2'b00;
        ex_mem_wr <= 1'b0;
        ex_reg_wr <= 1'b0;
        ex_waddr <= 5'h0;
        ex_instr_type <= `type_i;
        ex_to_pc <= 1'b0;
        ex_to_hi <= 1'b0;
        ex_to_lo <= 1'b0;
    end
    else begin
        ex_rdata1 <= id_rdata1;
        ex_rdata2 <= id_rdata2;
        ex_ext_imm <= id_ext_imm;
        ex_aluop <= id_aluop;
        ex_mem_wr <= id_mem_wr;
        ex_reg_wr <= id_reg_wr;
        ex_waddr <= id_waddr;
        ex_instr_type <= id_instr_type;
        ex_to_pc <= id_to_pc;
        ex_to_hi <= id_to_hi;
        ex_to_lo <= id_to_lo;
    end
end
endmodule
