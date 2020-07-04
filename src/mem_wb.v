`timescale 1ns / 1ps
`include "definations.vh"

module mem_wb(
    input clk,
    input rst,
    
    input [31:0] mem_mem_data,
    input [31:0] mem_alu_result,
    input mem_reg_wr,
    input [4:0] mem_waddr,
    input [1:0] mem_reg_wb_src,
    
    output reg [31:0] wb_mem_data,
    output reg [31:0] wb_alu_result,
    output reg wb_reg_wr,
    output reg [4:0] wb_waddr,
    output reg [1:0] wb_reg_wb_src
);
always @(posedge clk) begin
    if(rst) begin
        wb_mem_data <= 32'h00000000;
        wb_alu_result <= 32'h00000000;
        wb_reg_wr <= 1'b0;
        wb_waddr <= 5'h0;
        wb_reg_wb_src <= `wb_src_alu_result;
    end
    else begin
        wb_mem_data <= mem_mem_data;
        wb_alu_result <= mem_alu_result;
        wb_reg_wr <= mem_reg_wr;
        wb_waddr <= mem_waddr;
        wb_reg_wb_src <= mem_reg_wb_src;
    end
end
endmodule
