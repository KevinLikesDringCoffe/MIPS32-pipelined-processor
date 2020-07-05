`timescale 1ns / 1ps
`include "definations.vh"

module mem_wb(
    input clk,
    input rst,
    
    input [31:0] mem_mem_data,
    input [31:0] mem_alu_result,
    input mem_reg_wr,
    input [4:0] mem_waddr,
    input mem_to_pc,
//    input mem_to_hi,
//    input mem_to_lo,
    input [31:0] mem_alu_result_low,
    
    output reg [31:0] wb_mem_data,
    output reg [31:0] wb_alu_result,
    output reg wb_reg_wr,
    output reg [4:0] wb_waddr,
    output reg wb_to_pc,
//    output reg wb_to_hi,
//    output reg wb_to_lo,
    output reg [31:0] wb_alu_result_low
);
always @(posedge clk) begin
    if(rst) begin
        wb_mem_data <= 32'h00000000;
        wb_alu_result <= 32'h00000000;
        wb_reg_wr <= 1'b0;
        wb_waddr <= 5'h0;
        wb_to_pc <= 1'b0;
//        wb_to_hi <= 1'b0;
//        wb_to_lo <= 1'b0;
        wb_alu_result_low <= 32'h0;
    end
    else begin
        wb_mem_data <= mem_mem_data;
        wb_alu_result <= mem_alu_result;
        wb_reg_wr <= mem_reg_wr;
        wb_waddr <= mem_waddr;
        wb_to_pc <= mem_to_pc;
//        wb_to_hi <= mem_to_hi;
//        wb_to_lo <= mem_to_lo;
        wb_alu_result_low <= mem_alu_result_low;
    end
end
endmodule
