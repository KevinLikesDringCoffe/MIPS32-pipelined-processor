`timescale 1ns / 1ps
`include "definations.vh"

module mips_top(
    input clk,
    input rst,
    
    input [31:0] rom_data,
    output [31:0] rom_addr,
    output rom_ce
);
//wire [31:0] pc;
wire [31:0] if_pc;
wire [31:0] if_instr;
assign rom_addr = if_pc;
assign if_instr = rom_data;


wire [31:0] id_pc;
wire [31:0] id_instr;
wire [1:0] id_aluop;
wire [31:0] id_ext_imm;
wire [4:0] id_raddr1;
wire [4:0] id_raddr2;
wire [4:0] id_waddr;
wire [31:0] id_rdata1;
wire [31:0] id_rdata2;
wire id_mem_wr;
wire id_reg_wr;
wire [1:0] id_instr_type;

wire [31:0] ex_rdata1;
wire [31:0] ex_rdata2;
wire [31:0] ex_ext_imm;
wire [1:0] ex_aluop;
wire ex_mem_wr;
wire ex_reg_wr;
wire [4:0] ex_waddr;
wire [1:0] ex_instr_type;
wire [31:0] ex_alu_result;

wire mem_reg_wr;
wire mem_mem_wr;
wire [31:0] mem_alu_result;
wire [4:0] mem_waddr;

wire [31:0] wb_mem_data;
wire [31:0] wb_alu_result;
wire wb_reg_wr;
wire [4:0] wb_waddr;

pc mips_pc(
    .clk(clk),
    .rst(rst),
    .ce(rom_ce),
    .pc_addr(if_pc)
);

if_id mips_if_id(
    .clk(clk),
    .rst(rst),
    .if_pc(if_pc),
    .if_instr(if_instr),
    .id_pc(id_pc),
    .id_instr(id_instr)
);

decode mips_decode(
    .instr(id_instr),
    .aluop(id_aluop),
    .ext_imm(id_ext_imm),
    .raddr1(id_raddr1),
    .raddr2(id_raddr2),
    .waddr(id_waddr),
    .reg_wr(id_reg_wr),
    .mem_wr(id_mem_wr),
    .instr_type(id_instr_type)
);

regfile mips_regfile(
    .clk(clk),
    .rst(rst),
    .waddr(wb_waddr),
    .wdata(wb_alu_result),
    .we(wb_reg_wr),
    .raddr1(id_raddr1),
    .raddr2(id_raddr2),
    .rdata1(id_rdata1),
    .rdata2(id_rdata2)
);

id_ex mips_id_ex(
    .clk(clk),
    .rst(rst),
    .id_rdata1(id_rdata1),
    .id_rdata2(id_rdata2),
    .id_ext_imm(id_ext_imm),
    .id_aluop(id_aluop),
    .id_mem_wr(id_mem_wr),
    .id_reg_wr(id_reg_wr),
    .id_waddr(id_waddr),
    .id_instr_type(id_instr_type),
    
    .ex_rdata1(ex_rdata1),
    .ex_rdata2(ex_rdata2),
    .ex_ext_imm(ex_ext_imm),
    .ex_aluop(ex_aluop),
    .ex_mem_wr(ex_mem_wr),
    .ex_reg_wr(ex_reg_wr),
    .ex_waddr(ex_waddr),
    .ex_instr_type(ex_instr_type)
    
);

exu mips_exu(
    .instr_type(ex_instr_type),
    .aluop(ex_aluop),
    .rdata1(ex_rdata1),
    .rdata2(ex_rdata2),
    .ext_imm(ex_ext_imm),
    .result(ex_alu_result)
);

ex_mem mips_ex_mem(
    .clk(clk),
    .rst(rst),
    .ex_reg_wr(ex_reg_wr),
    .ex_mem_wr(ex_mem_wr),
    .ex_alu_result(ex_alu_result),
    .ex_waddr(ex_waddr),
    
    .mem_reg_wr(mem_reg_wr),
    .mem_mem_wr(mem_mem_wr),
    .mem_alu_result(mem_alu_result),
    .mem_waddr(mem_waddr)
);

mem_wb mips_mem_wb(
    .clk(clk),
    .rst(rst),
    .mem_mem_data(),
    .mem_alu_result(mem_alu_result),
    .mem_reg_wr(mem_reg_wr),
    .mem_waddr(mem_waddr),
    
    .wb_mem_data(wb_mem_data),
    .wb_alu_result(wb_alu_result),
    .wb_reg_wr(wb_reg_wr),
    .wb_waddr(wb_waddr)
);

endmodule