`timescale 1ns / 1ps
`include "definations.vh"

module decode(
    //input rst,
    //input [31:0] pc,
    input [31:0] instr,
    
    output reg [1:0] instr_type,
    output reg [1:0] aluop,
    output reg [31:0] ext_imm,
    output reg [4:0] raddr1,
    output reg [4:0] raddr2,
    output reg [4:0] waddr,
    output reg reg_wr,
    output reg mem_wr
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
           aluop <= `aluop_or;
           instr_type <= `type_i;
        end
        
        default: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            waddr <= 5'h0;
            raddr1 <= 5'h0;
            raddr2 <= 5'h0;
            ext_imm <= 32'h00000000;
            aluop <= `aluop_or;
            instr_type <= `type_i;
        end
    endcase
end
endmodule
