`timescale 1ns / 1ps
`include "definations.vh"

module decode(
    //input rst,
    //input [31:0] pc,
    input [31:0] instr,
    
    output reg [1:0] instr_type,
    output reg [`aluop_bit] aluop,
    output reg [4:0] sa,
    output reg sa_en,
    output reg [31:0] ext_imm,
    output reg [4:0] raddr1,
    output reg [4:0] raddr2,
    output reg [4:0] waddr,
    output reg reg_wr,
    output reg mem_wr,
    output reg [`cond_bit] cond
);


always @ (*) begin
    case(instr[`opcode])
        `op_ori: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= 5'h0;
           ext_imm <= {16'h0000,instr[`i_immediate]};
           sa <= 5'h0;
           sa_en <= 1'b0;
           aluop <= `aluop_or;
           instr_type <= `type_i;
           cond <= `no_cond;
        end
        
        `op_special: begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            waddr <= instr[`r_rd];
            raddr1 <= instr[`r_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'h00000000;
            instr_type <= `type_r;
            case(instr[`r_funct]) 
                `funct_and: begin
                    aluop <= `aluop_and;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_or: begin
                    aluop <= `aluop_or;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_xor: begin
                    aluop <= `aluop_xor;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_nor: begin
                    aluop <= `aluop_nor;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                end
                `funct_sll: begin
                    aluop <= `aluop_sll;
                    sa <= instr[`r_sa];
                    sa_en <= 1'b1;
                    cond <= `no_cond;
                end
                `funct_srl: begin
                    aluop <= `aluop_srl;
                    sa <= instr[`r_sa];
                    sa_en <= 1'b1;
                    cond <= `no_cond;
                end
                `funct_sra: begin
                    aluop <= `aluop_sra;
                    sa <= instr[`r_sa];
                    sa_en <=1'b1;
                    cond <= `no_cond;
                end
                `funct_sllv: begin
                    aluop <= `aluop_sll;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_srlv: begin
                    aluop <= `aluop_srl;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_srav: begin
                    aluop <= `aluop_sra;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
                `funct_movn: begin
                    aluop <= `aluop_mv;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `cond_src2_nz;
                end
                `funct_movz: begin
                    aluop <= `aluop_mv;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `cond_src2_z;
                end
                default: begin
                    aluop <= `aluop_or;
                    sa <= 5'h0;
                    sa_en <= 1'b0;
                    cond <= `no_cond;
                end
            endcase
        end
        
        `op_andi: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= 5'h0;
           sa <= 5'h0;
           sa_en <= 1'b0;
           ext_imm <= {16'h0000,instr[`i_immediate]};
           aluop <= `aluop_and;
           instr_type <= `type_i;
           cond <= `no_cond;
        end
        
        `op_xori: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= 5'h0;
           sa <= 5'h0;
           sa_en <= 1'b0;
           ext_imm <= {16'h0000,instr[`i_immediate]};
           aluop <= `aluop_xor;
           instr_type <= `type_i;
           cond <= `no_cond;
        end
        
        `op_lui: begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            waddr <= instr[`i_rt];
            raddr1 <= 5'h0;
            raddr2 <= 5'b0;
            sa <= 5'h0;
            sa_en <= 1'b0;
            ext_imm <= {instr[`i_immediate],16'h0000};
            aluop <= `aluop_or;
            instr_type <= `type_i;
            cond <= `no_cond;
        end
        
        default: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            waddr <= 5'h0;
            raddr1 <= 5'h0;
            raddr2 <= 5'h0;
            sa <= 5'h0;
            sa_en <= 1'b0;
            ext_imm <= 32'h00000000;
            aluop <= `aluop_or;
            instr_type <= `type_i;
            cond <= `no_cond;
        end
        
        
    endcase
end
endmodule
