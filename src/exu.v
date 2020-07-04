`timescale 1ns / 1ps
`include "definations.vh"

module exu(
    input [3:0] aluop,
    input [31:0] rdata1,
    input [31:0] rdata2,
    input [31:0] ext_imm,
    input [4:0] sa,
    input [1:0] alu_src,
    input [31:0] pc,
    
    output reg [31:0] result
);

reg [31:0] alu_src1;
reg [31:0] alu_src2;

always @ (*) begin
    
    case(alu_src) 
        `alu_src_rt: begin
            alu_src1 <= rdata1;
            alu_src2 <= rdata2;
        end
        `alu_src_imm: begin
            alu_src1 <= rdata1;
            alu_src2 <= ext_imm;
        end
        `alu_src_sa : begin
            alu_src1 <= {27'b0,sa};
            alu_src2 <= rdata2;
        end 
        `alu_src_pc : begin
            alu_src1 <= pc;
            alu_src2 <= 32'h00000004;
        end
    endcase
    case(aluop) 
        `aluop_or: result <= alu_src1 | alu_src2;
        `aluop_and: result <= alu_src1 & alu_src2;
        `aluop_add: result <= alu_src1 + alu_src2;
        `aluop_sub: result <= alu_src1 - alu_src2;
        `aluop_xor: result <= alu_src1 ^ alu_src2;
        `aluop_nor: result <= ~(alu_src1 | alu_src2);
        `aluop_sll: result <= alu_src2 << alu_src1[4:0];
        `aluop_srl: result <= alu_src2 >> alu_src1[4:0];
        `aluop_sra: result <= (alu_src2 >> alu_src1[4:0]) | ({32{alu_src2[31]}} << (6'd32 - {1'b0,alu_src1[4:0]}));
    endcase
end
endmodule
