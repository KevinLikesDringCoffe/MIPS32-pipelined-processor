`timescale 1ns / 1ps
`include "definations.vh"

module regfile(
    input clk,
    input rst,
    
    input [4:0] waddr,
    input [31:0] wdata,
    input we,
    
    input [4:0] raddr1,
    output reg [31:0] rdata1,
    
    input  [4:0] raddr2,
    output reg [31:0] rdata2
);

reg [31:0] regs [31:0];
integer i;

always @ (negedge clk) begin
    if(rst) begin
        for(i = 0;i < 32;i = i+1) begin
            regs[i] <= 32'h00000000;
        end
    end 
    else begin
        if(we && (waddr !=5'h0)) begin
            regs[waddr] <= wdata;
        end
    end
end

always @ (*) begin
    if(raddr1 == 5'h0) begin
        rdata1 <= 32'h00000000;
    end
    else begin
        rdata1 <= regs[raddr1];
    end
end

always @ (*) begin
    if(raddr2 == 5'h0) begin
        rdata2 <= 32'h00000000;
    end
    else begin
        rdata2 <= regs[raddr2];
    end
end

endmodule
