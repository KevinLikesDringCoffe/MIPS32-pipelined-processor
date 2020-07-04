`timescale 1ns / 1ps
`include "definations.vh"

module ex_mem(
    input clk,
    input rst,
    input ex_reg_wr,
    input ex_mem_wr,
    input [31:0] ex_alu_result,
    input [4:0] ex_waddr,
    input [1:0] ex_reg_wb_src,
    
    output reg mem_reg_wr,
    output reg mem_mem_wr,
    output reg [31:0] mem_alu_result,
    output reg [4:0] mem_waddr ,
    output reg [1:0] mem_reg_wb_src
);

always @ (posedge clk) begin
    if(rst) begin
        mem_reg_wr <= 1'b0;
        mem_mem_wr <= 1'b0;
        mem_alu_result <= 32'h00000000;
        mem_waddr <= 5'h0;
        mem_reg_wb_src <= `wb_src_alu_result;
    end
    else begin
        mem_reg_wr <= ex_reg_wr;
        mem_mem_wr <= ex_mem_wr;
        mem_alu_result <= ex_alu_result;
        mem_waddr <= ex_waddr;
        mem_reg_wb_src <= ex_reg_wb_src;
    end
end
endmodule
