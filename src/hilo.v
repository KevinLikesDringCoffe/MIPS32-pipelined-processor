`timescale 1ns / 1ps
`include "definations.vh"

module hilo(
    input clk,
    input rst,
    input to_hi,
    input to_lo,
    input [31:0] to_hi_data,
    input [31:0] to_lo_data,

    output reg [31:0] hi_data,
    output reg [31:0] lo_data

);

reg [31:0] hi;
reg [31:0] lo;

always @ (negedge clk) begin
    if(rst) begin
        hi_data <= 32'b0;
        lo_data <= 32'b0;
    end 
    else begin
        if(to_hi) begin
            hi <= to_hi_data;
        end
        else hi <= hi;
        if(to_lo) begin
            lo <= to_lo_data;
        end
        else lo <= lo;
    end
end

always @ (*) begin
    hi_data <= hi;
    lo_data <= lo;
end


endmodule
