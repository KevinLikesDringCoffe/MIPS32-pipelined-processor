`timescale 1ns / 1ps
`include "definations.vh"

module decode(
    //input rst,
    //input [31:0] pc,
    input [31:0] instr,
    input [31:0] rdata1,
    input [31:0] rdata2,
    input [31:0] pc,
    
    output reg [3:0] aluop,
    output reg [31:0] ext_imm,
    output reg [4:0] sa,
    output reg [4:0] raddr1,
    output reg [4:0] raddr2,
    output reg [4:0] waddr,
    output reg reg_wr,
    output reg mem_wr,
    output reg mem_rd,
    output reg [2:0] mem_opcode,
    output reg [1:0] reg_wb_src,
    output reg [2:0] alu_src,
    
    output reg branch_taken,
    output reg [31:0] branch_addr,
    output reg flush
);


always @ (*) begin
    
    case(instr[`opcode])
        `op_ori: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           mem_rd <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= instr[`i_rt];
           ext_imm <= {16'h0000,instr[`i_immediate]};
           sa <= 5'b0;
           aluop <= `aluop_or;
           reg_wb_src <= `wb_src_alu_result;
           alu_src <= `alu_src_imm;
           branch_taken <= 1'b0;
           flush <= 1'b0;
        end
        `op_andi: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           mem_rd <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= instr[`i_rt];
           ext_imm <= {16'h0000,instr[`i_immediate]};
           sa <= 5'b0;
           aluop <= `aluop_and;
           reg_wb_src <= `wb_src_alu_result;
           alu_src <= `alu_src_imm;
           branch_taken <= 1'b0;
           flush <= 1'b0;
        end
        `op_xori: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           mem_rd <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= instr[`i_rt];
           ext_imm <= {16'h0000,instr[`i_immediate]};
           sa <= 5'b0;
           aluop <= `aluop_xor;
           reg_wb_src <= `wb_src_alu_result;
           alu_src <= `alu_src_imm;
           branch_taken <= 1'b0;
           flush <= 1'b0;
        end
        `op_lui: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           mem_rd <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= 5'b0;
           raddr2 <= instr[`i_rt];
           ext_imm <= {instr[`i_immediate],16'h0000};
           sa <= 5'b0;
           aluop <= `aluop_or;
           reg_wb_src <= `wb_src_alu_result;
           alu_src <= `alu_src_imm;
           branch_taken <= 1'b0;
           flush <= 1'b0;
        end
        `op_addiu: begin
           reg_wr <= 1'b1;
           mem_wr <= 1'b0;
           mem_rd <= 1'b0;
           waddr <= instr[`i_rt];
           raddr1 <= instr[`i_rs];
           raddr2 <= instr[`i_rt];
           ext_imm <= {{16{instr[15]}},instr[`i_immediate]};
           sa <= 5'b0;
           aluop <= `aluop_add;
           reg_wb_src <= `wb_src_alu_result;
           alu_src <= `alu_src_imm;
           branch_taken <= 1'b0;
           flush <= 1'b0;
        end
        `op_j : begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`r_rd];
            raddr1 <= instr[`r_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b1;
            branch_addr <= {pc[31:28],instr[`j_address],2'b00};
            flush <= 1'b1;
        end
        `op_jal : begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`r_rd];
            raddr1 <= instr[`r_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_add;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_pc;
            branch_taken <= 1'b1;
            branch_addr <= {pc[31:28],instr[`j_address],2'b00};
            flush <= 1'b1;
        end
        `op_beq: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= (rdata1 == rdata2);
            branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
            flush <= (rdata1 == rdata2);
        end
        `op_bne : begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= (rdata1 != rdata2);
            branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
            flush <= (rdata1 != rdata2);
        end
        `op_bgtz: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= (!rdata1[31]) & (rdata1 != 32'b0);
            branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
            flush <= (!rdata1[31]) & (rdata1 != 32'b0);
        end
        `op_bgtz: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rt];
            ext_imm <= 32'b0;
            sa <= instr[`r_sa];
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= rdata1[31] | (rdata1 == 32'b0);
            branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
            flush <= rdata1[31] | (rdata1 == 32'b0);
        end
        `op_regimm: begin
            case(instr[`i_rt])
                `rt_bltz: begin
                    reg_wr <= 1'b0;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_imm;
                    branch_taken <= !rdata1[31];
                    branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
                    flush <= !rdata1[31];
                end
                `rt_bltzal: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= 5'b11111;
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_pc;
                    branch_taken <= !rdata1[31];
                    branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
                    flush <= !rdata1[31];
                end
                `rt_bgez: begin
                    reg_wr <= 1'b0;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_imm;
                    branch_taken <= rdata1[31];
                    branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
                    flush <= rdata1[31];
                end
                `rt_bgezal: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= 5'b11111;
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_pc;
                    branch_taken <= rdata1[31];
                    branch_addr <= pc + {{14{instr[15]}},instr[15:0],2'b00};
                    flush <= rdata1[31];
                end 
            endcase
 
        end
        `op_lb: begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            mem_rd <= 1'b1;
            mem_opcode <= `mem_op_b;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rd];
            ext_imm <= {{16{instr[15]}},instr[`i_immediate]};
            sa <= instr[`r_sa];
            aluop <= `aluop_add;
            reg_wb_src <= `wb_src_mem;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b0;
            flush <= 1'b0; 
         end
         `op_lbu: begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            mem_rd <= 1'b1;
            mem_opcode <= `mem_op_bu;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rd];
            ext_imm <= {{16{instr[15]}},instr[`i_immediate]};
            sa <= instr[`r_sa];
            aluop <= `aluop_add;
            reg_wb_src <= `wb_src_mem;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b0;
            flush <= 1'b0; 
         end
         `op_lw: begin
            reg_wr <= 1'b1;
            mem_wr <= 1'b0;
            mem_rd <= 1'b1;
            mem_opcode <= `mem_op_w;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`r_rd];
            ext_imm <= {{16{instr[15]}},instr[`i_immediate]};
            sa <= instr[`r_sa];
            aluop <= `aluop_add;
            reg_wb_src <= `wb_src_mem;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b0;
            flush <= 1'b0; 
         end
         `op_sw: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b1;
            mem_rd <= 1'b0;
            mem_opcode <= `mem_op_w;
            waddr <= instr[`i_rt];
            raddr1 <= instr[`i_rs];
            raddr2 <= instr[`i_rt];
            ext_imm <= {{16{instr[15]}},instr[`i_immediate]};
            sa <= instr[`r_sa];
            aluop <= `aluop_add;
            reg_wb_src <= `wb_src_mem;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b0;
            flush <= 1'b0; 
         end
        `op_special: begin
            case(instr[`r_funct])
                `funct_and: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_and;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_or: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_xor: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_xor;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_nor: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_nor;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_sll: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_sll;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_sa;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_srl: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_srl;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_sa;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_sra: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_sra;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_sa;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_sllv: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_sll;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_srlv: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_srl;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_srav: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_sra;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_movn: begin
                    reg_wr <= (rdata2 != 32'b0);
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_imm;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_movz: begin
                    reg_wr <= (rdata2 == 32'b0);
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_imm;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_jr: begin
                    reg_wr <= 1'b0;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_or;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_imm;
                    branch_taken <= 1'b1;
                    branch_addr <= rdata1;
                    flush <= 1'b1;
                    
                end
                `funct_jalr: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= instr[`r_sa];
                    aluop <= `aluop_add;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_pc;
                    branch_taken <= 1'b1;
                    branch_addr <= rdata1;
                    flush <= 1'b1;
                end
                `funct_addu: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_add;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
                `funct_subu: begin
                    reg_wr <= 1'b1;
                    mem_wr <= 1'b0;
                    mem_rd <= 1'b0;
                    waddr <= instr[`r_rd];
                    raddr1 <= instr[`r_rs];
                    raddr2 <= instr[`r_rt];
                    ext_imm <= 32'b0;
                    sa <= 5'b0;
                    aluop <= `aluop_sub;
                    reg_wb_src <= `wb_src_alu_result;
                    alu_src <= `alu_src_rt;
                    branch_taken <= 1'b0;
                    flush <= 1'b0;
                end
            endcase 
        end
        default: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            mem_rd <= 1'b0;
            waddr <= 5'h0;
            raddr1 <= 5'h0;
            raddr2 <= 5'h0;
            ext_imm <= 32'h00000000;
            sa <= 5'b0;
            aluop <= `aluop_or;
            reg_wb_src <= `wb_src_alu_result;
            alu_src <= `alu_src_imm;
            branch_taken <= 1'b0;
        end
    endcase
end
endmodule
