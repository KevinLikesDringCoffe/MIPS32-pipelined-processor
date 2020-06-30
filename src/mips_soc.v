`timescale 1ns / 1ps


module mips_soc(
    input clk,
    input rst
);
wire [31:0] addr;
wire [31:0] instr;
wire ce;

instr_rom system_rom(
    .addr(addr),
    .ce(ce),
    .instr(instr)
);

mips_top core(
    .clk(clk),
    .rst(rst),
    
    .rom_data(instr),
    .rom_addr(addr),
    .rom_ce(ce)
);
endmodule
