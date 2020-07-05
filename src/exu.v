`timescale 1ns / 1ps
`include "definations.vh"

module exu(
    input [1:0] instr_type,
    input [3:0] aluop,
    input [31:0] rdata1,
    input [31:0] rdata2,
    input [31:0] ext_imm,
    input [31:0] hi_data,
    input [31:0] lo_data,
    
    output reg [31:0] result,
    output reg [31:0] result_low
);

reg [31:0] alu_src1;
reg [31:0] alu_src2;

always @ (*) begin
    case(instr_type) 
        `type_i: begin
            alu_src1 <= rdata1;
            alu_src2 <= ext_imm;
        end

        `type_r: begin
            alu_src1 <= rdata1;
            alu_src2 <= rdata2;
        end
        
        `type_s: begin
            alu_src1 <= rdata1;
            alu_src2 <= {rdata2[31:28],28'b0};
        end

        default: begin
        end
    endcase
    
    case(aluop) 
        `aluop_or: result <= alu_src1 | alu_src2;
        `aluop_and: result <= alu_src1 & alu_src2;
        `aluop_xor: result <= alu_src1 ^ alu_src2;
        `aluop_nor: result <= ~(alu_src1 | alu_src2);
        `aluop_add: result <= alu_src1 + alu_src2;
        `aluop_sub: result <= alu_src1 - alu_src2;
        `aluop_sll: result <= alu_src1<<alu_src2[4:0];
        `aluop_srl: result <= alu_src1>>alu_src2[4:0];
        `aluop_sra: result <= ({32{alu_src1[31]}}<<(6'd32-{1'b0,alu_src2[4:0]})) | (alu_src1>>alu_src2[4:0]);
        `aluop_mfhi: result <= hi_data;
        `aluop_mflo: result <= lo_data;
        
        default: begin
        end
    endcase
end
endmodule
