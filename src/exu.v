`timescale 1ns / 1ps
`include "definations.vh"

module exu(
    input [1:0] instr_type,
    input [`aluop_bit] aluop,
    input [31:0] rdata1,
    input [31:0] rdata2,
    input [31:0] ext_imm,
    input [4:0] sa,
    input sa_en,
    input [`cond_bit] cond,
    input reg_wr,
    
    output reg [31:0] result,
    output reg reg_wr_en
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
            alu_src2 <= rdata2;
            if(sa_en) begin
                alu_src1 <= {27'h0,sa};
            end
            else begin
                alu_src1 <= rdata1;
            end
        end
        default: begin
        end
    endcase
    case(cond)
        `no_cond: begin
            reg_wr_en <= reg_wr;
        end
        `cond_src2_nz: begin
            reg_wr_en <= reg_wr & (rdata2 != 32'h00000000);
        end
        `cond_src2_z: begin
            reg_wr_en <= reg_wr &(rdata2 == 32'h00000000);
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
        `aluop_mv: result <= rdata1;
    endcase
end
endmodule
