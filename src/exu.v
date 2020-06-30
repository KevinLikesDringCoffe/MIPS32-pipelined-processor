`timescale 1ns / 1ps
`include "definations.vh"

module exu(
    input [1:0] instr_type,
    input [1:0] aluop,
    input [31:0] rdata1,
    input [31:0] rdata2,
    input [31:0] ext_imm,
    
    output reg [31:0] result
);

reg [31:0] alu_src1;
reg [31:0] alu_src2;

always @ (*) begin
    case(instr_type) 
        `type_i: begin
            alu_src1 <= rdata1;
            alu_src2 <= ext_imm;
        end
        
        default: begin
        end
    endcase
    
    case(aluop) 
        `aluop_or: result <= alu_src1 | alu_src2;
        `aluop_and: result <= alu_src1 & alu_src2;
        `aluop_add: result <= alu_src1 + alu_src2;
        `aluop_sub: result <= alu_src1 - alu_src2;
    endcase
end
endmodule
