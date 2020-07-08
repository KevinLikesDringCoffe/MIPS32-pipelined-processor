`timescale 1ns / 1ps
`include "definations.vh"

module ex_mem(
    input clk,
    input rst,
    input ex_reg_wr,
    input ex_mem_wr,
    input ex_mem_rd,
    input [31:0] ex_rdata2,
    input [2:0] ex_mem_opcode,
    input [31:0] ex_alu_result,
    input [4:0] ex_waddr,
    input [1:0] ex_reg_wb_src,
    
    
    output reg mem_reg_wr,
    output reg mem_mem_wr,
    output reg mem_mem_rd,
    output reg [31:0] mem_rdata2,
    output reg [2:0] mem_mem_opcode,
    output reg [31:0] mem_alu_result,
    output reg [4:0] mem_waddr ,
    output reg [1:0] mem_reg_wb_src
);

always @ (posedge clk) begin
    if(rst) begin
        mem_reg_wr <= 1'b0;
        mem_mem_wr <= 1'b0;
        mem_mem_rd <= 1'b0;
        mem_rdata2 <= 32'b0;
        mem_mem_opcode <= `mem_op_b;
        mem_alu_result <= 32'h00000000;
        mem_waddr <= 5'h0;
        mem_reg_wb_src <= `wb_src_alu_result;
    end
    else begin
        mem_reg_wr <= ex_reg_wr;
        mem_mem_wr <= ex_mem_wr;
        mem_mem_rd <= ex_mem_rd;
        mem_rdata2 <= ex_rdata2;
        mem_mem_opcode <= ex_mem_opcode;
        mem_alu_result <= ex_alu_result;
        mem_waddr <= ex_waddr;
        mem_reg_wb_src <= ex_reg_wb_src;
    end
end
endmodule
