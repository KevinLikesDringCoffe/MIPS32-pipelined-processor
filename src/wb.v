`timescale 1ns / 1ps
`include "definations.vh"

module wb(
    input [1:0] reg_wb_src,
    input [31:0] mem_data,
    input [31:0] alu_result,
    
    output reg [31:0] wb_data    
);

always @ (*) begin
    case(reg_wb_src) 
        `wb_src_alu_result: wb_data <= alu_result;
        `wb_src_mem : wb_data <= mem_data;
        default: wb_data <= alu_result;
    endcase
end

endmodule
