`timescale 1ns / 1ps
`include "definations.vh"

module ex_mem(
    input clk,
    input rst,
    input ex_reg_wr,
    input ex_mem_wr,
    input [31:0] ex_alu_result,
    input [4:0] ex_waddr,
    input ex_to_pc,
    input [31:0] ex_alu_result_low,
    
    output reg mem_reg_wr,
    output reg mem_mem_wr,
    output reg [31:0] mem_alu_result,
    output reg [4:0] mem_waddr,
    output reg mem_to_pc,
    output reg [31:0] mem_alu_result_low
);

always @ (posedge clk) begin
    if(rst) begin
        mem_reg_wr <= 1'b0;
        mem_mem_wr <= 1'b0;
        mem_alu_result <= 32'h00000000;
        mem_waddr <= 5'h0;
        mem_to_pc <= 1'b0;
        mem_alu_result_low <= 32'h0;
    end
    else begin
        mem_reg_wr <= ex_reg_wr;
        mem_mem_wr <= ex_mem_wr;
        mem_alu_result <= ex_alu_result;
        mem_waddr <= ex_waddr;
        mem_to_pc <= ex_to_pc;
        mem_alu_result_low <= ex_alu_result_low;
    end
end
endmodule
