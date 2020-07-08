`timescale 1ns / 1ps
`include "definations.vh"

module pc(
    input clk,
    input rst,
    input stall,
    
    input branch_taken,
    input [31:0] branch_addr,
    
    output reg ce,
    output reg [31:0] pc_addr
);
always @ (posedge clk) begin
    if(rst) begin
        ce <= 1'b0;
    end
    else begin
        ce <= 1'b1;
    end
end

always @ (posedge clk) begin
    if(!ce) begin
        pc_addr <= 32'h00000000;
    end
    else begin
        if(stall) pc_addr <= pc_addr;
        else if(branch_taken) pc_addr <= branch_addr;
        else pc_addr <= pc_addr + 32'h4;
    end
end

endmodule
