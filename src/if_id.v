`timescale 1ns / 1ps
`include "definations.vh"

module if_id(
    input clk,
    input rst,
    input [31:0] if_pc,
    input [31:0] if_instr,
    output reg [31:0] id_pc,
    output reg [31:0] id_instr
);

always @ (posedge clk) begin
    if(rst) begin
        id_pc <= 32'h00000000;
        id_instr <= 32'h00000000;
    end
    else begin
        id_pc <= if_pc;
        id_instr <= if_instr;
    end
end
    
endmodule
