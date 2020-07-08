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
wire [31:0] branch_addr;
wire branch_taken;
wire [31:0] if_pc;
wire [31:0] if_instr;
assign rom_addr = if_pc;
assign if_instr = rom_data;

wire id_flush;
wire stall;

wire [31:0] id_pc;
wire [31:0] id_instr;
wire [3:0] id_aluop;
wire [31:0] id_ext_imm;
wire [4:0] id_sa;
wire [4:0] id_raddr1;
wire [4:0] id_raddr2;
wire [4:0] id_waddr;
wire [31:0] rdata1;
wire [31:0] rdata2;
wire [31:0] id_rdata1;
wire [31:0] id_rdata2;
wire id_mem_wr;
wire id_reg_wr;
wire [2:0] id_mem_opcode;
wire id_mem_rd;
wire [1:0] id_reg_wb_src;
wire [2:0] id_alu_src;

wire [31:0] ex_pc;
wire [31:0] ex_rdata1;
wire [31:0] ex_rdata2;
wire [31:0] ex_ext_imm;
wire [4:0] ex_sa;
wire [3:0] ex_aluop;
wire ex_mem_wr;
wire ex_reg_wr;
wire ex_mem_rd;
wire [2:0] ex_mem_opcode;
wire [4:0] ex_waddr;
wire [1:0] ex_reg_wb_src;
wire [2:0] ex_alu_src;
wire [31:0] ex_alu_result;

wire mem_reg_wr;
wire mem_mem_wr;
wire mem_mem_rd;
wire [31:0] mem_wdata;
wire [31:0] mem_rdata2;
wire [2:0] mem_mem_opcode;
wire [31:0] mem_alu_result;
wire [31:0] mem_mem_data;
wire [4:0] mem_waddr;
wire [1:0] mem_reg_wb_src;
wire [31:0] mem_ram_data;
wire [3:0] mem_sel;

wire [31:0] wb_mem_data;
wire [31:0] wb_alu_result;
wire wb_reg_wr;
wire [4:0] wb_waddr;
wire [1:0] wb_reg_wb_src;
wire [31:0] wb_data;

pc mips_pc(
    .clk(clk),
    .rst(rst),
    .stall(stall),
    
    .branch_taken(branch_taken),
    .branch_addr(branch_addr),
    .ce(rom_ce),
    .pc_addr(if_pc)
);

if_id mips_if_id(
    .clk(clk),
    .rst(rst | id_flush),
    .stall(stall),
    .if_pc(if_pc),
    .if_instr(if_instr),
    .id_pc(id_pc),
    .id_instr(id_instr)
);

decode mips_decode(
    .pc(id_pc),
    .instr(id_instr),
    .rdata1(id_rdata1),
    .rdata2(id_rdata2),
    .aluop(id_aluop),
    .ext_imm(id_ext_imm),
    .sa(id_sa),
    .raddr1(id_raddr1),
    .raddr2(id_raddr2),
    .waddr(id_waddr),
    .reg_wr(id_reg_wr),
    .mem_wr(id_mem_wr),
    .mem_rd(id_mem_rd),
    .mem_opcode(id_mem_opcode),
    .alu_src(id_alu_src),
    .reg_wb_src(id_reg_wb_src),
    .branch_taken(branch_taken),
    .branch_addr(branch_addr),
    .flush(id_flush)
);

regfile mips_regfile(
    .clk(clk),
    .rst(rst),
    .waddr(wb_waddr),
    .wdata(wb_data),
    .we(wb_reg_wr),
    .raddr1(id_raddr1),
    .raddr2(id_raddr2),
    .rdata1(rdata1),
    .rdata2(rdata2)
);
hazard mips_hazard(
    .raddr1(id_raddr1),
    .raddr2(id_raddr2),
    .rdata1(rdata1),
    .rdata2(rdata2),
   
    .ex_alu_result(ex_alu_result),
    .ex_waddr(ex_waddr),
    .ex_reg_wr(ex_reg_wr),
   
    .mem_alu_result(mem_alu_result),
    .mem_waddr(mem_waddr),
    .mem_reg_wr(mem_reg_wr),
    
    .ex_mem_rd(ex_mem_rd),
    .mem_mem_rd(mem_mem_rd),
    .mem_mem_data(mem_mem_data),
    
    .id_rdata1(id_rdata1),
    .id_rdata2(id_rdata2),
    .stall(stall)
);
id_ex mips_id_ex(
    .clk(clk),
    .rst(rst | stall),
    .id_rdata1(id_rdata1),
    .id_rdata2(id_rdata2),
    .id_ext_imm(id_ext_imm),
    .id_sa(id_sa),
    .id_aluop(id_aluop),
    .id_mem_wr(id_mem_wr),
    .id_reg_wr(id_reg_wr),
    .id_mem_rd(id_mem_rd),
    .id_mem_opcode(id_mem_opcode),
    .id_waddr(id_waddr),
    .id_reg_wb_src(id_reg_wb_src),
    .id_alu_src(id_alu_src),
    .id_pc(id_pc),
    
    .ex_rdata1(ex_rdata1),
    .ex_rdata2(ex_rdata2),
    .ex_ext_imm(ex_ext_imm),
    .ex_sa(ex_sa),
    .ex_aluop(ex_aluop),
    .ex_mem_wr(ex_mem_wr),
    .ex_reg_wr(ex_reg_wr),
    .ex_mem_rd(ex_mem_rd),
    .ex_mem_opcode(ex_mem_opcode),
    .ex_waddr(ex_waddr),
    .ex_reg_wb_src(ex_reg_wb_src),
    .ex_alu_src(ex_alu_src),
    .ex_pc(ex_pc)
    
);

exu mips_exu(
    .pc(ex_pc),
    .alu_src(ex_alu_src),
    .aluop(ex_aluop),
    .rdata1(ex_rdata1),
    .rdata2(ex_rdata2),
    .ext_imm(ex_ext_imm),
    .sa(ex_sa),
    .result(ex_alu_result)
);

ex_mem mips_ex_mem(
    .clk(clk),
    .rst(rst),
    .ex_reg_wr(ex_reg_wr),
    .ex_mem_wr(ex_mem_wr),
    .ex_mem_rd(ex_mem_rd),
    .ex_rdata2(ex_rdata2),
    .ex_mem_opcode(ex_mem_opcode),
    .ex_alu_result(ex_alu_result),
    .ex_waddr(ex_waddr),
    .ex_reg_wb_src(ex_reg_wb_src),
    
    .mem_reg_wr(mem_reg_wr),
    .mem_mem_wr(mem_mem_wr),
    .mem_mem_rd(mem_mem_rd),
    .mem_rdata2(mem_rdata2),
    .mem_mem_opcode(mem_mem_opcode),
    .mem_alu_result(mem_alu_result),
    .mem_waddr(mem_waddr),
    .mem_reg_wb_src(mem_reg_wb_src)
);

mem mips_mem(
    .mem_rd(mem_mem_rd),
    .mem_wr(mem_mem_wr),
    .raw_data(mem_ram_data),
    .reg_data(mem_rdata2),
    .addr(mem_alu_result),
    .mem_opcode(mem_mem_opcode),
    
    .sel(mem_sel),
    .rdata(mem_mem_data),
    .wdata(mem_wdata)
);

data_ram mips_data_ram(
    .clk(clk),
    .ce(mem_mem_rd | mem_mem_wr),
    .we(mem_mem_wr),
    .addr(mem_alu_result),
    .sel(mem_sel),
    .wdata(mem_wdata),
    
    .rdata(mem_ram_data)
);

mem_wb mips_mem_wb(
    .clk(clk),
    .rst(rst),
    .mem_mem_data(mem_mem_data),
    .mem_alu_result(mem_alu_result),
    .mem_reg_wr(mem_reg_wr),
    .mem_waddr(mem_waddr),
    .mem_reg_wb_src(mem_reg_wb_src),
    
    .wb_mem_data(wb_mem_data),
    .wb_alu_result(wb_alu_result),
    .wb_reg_wr(wb_reg_wr),
    .wb_waddr(wb_waddr),
    .wb_reg_wb_src(wb_reg_wb_src)
);
wb mips_wb(
    .reg_wb_src(wb_reg_wb_src),
    .mem_data(wb_mem_data),
    .alu_result(wb_alu_result),
    
    .wb_data(wb_data)
);

endmodule
