`timescale 1ns / 1ps
`include "definations.vh"

module pc(
    input clk,
    input rst,
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
        pc_addr <= pc_addr + 32'h4;
    end
end

endmodule
