`timescale 1ns / 1ps
`include "definations.vh"

module hilo(
    input clk,
    input rst,
    
    input hi_wr,
    input lo_wr,
    input [31:0] hi_wdata,
    input [31:0] lo_wdata,
    
    output reg [31:0] hi_rdata,
    output reg [31:0] lo_rdata
);
reg [31:0] hi;
reg [31:0] lo;

always @ (posedge clk) begin
    if(rst) begin
        hi <= 32'b0;
        lo <= 32'b0;
    end
    else begin
        if(hi_wr) hi <= hi_wdata;
        if(lo_wr) lo <= lo_wdata;
    end
end

always @ (*) begin
    hi_rdata <= hi;
    lo_rdata <= lo;
end
endmodule
