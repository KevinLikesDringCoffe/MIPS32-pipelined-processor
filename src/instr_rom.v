`timescale 1ns / 1ps

module instr_rom(
    input ce,
    input [31:0] addr,
    output reg [31:0] instr 
);

reg [31:0] instr_mem [255:0];

initial begin
    // ori instruction and data dependence resolve
    instr_mem[0] = 32'b001101_00001_00010_1001_1100_1001_1000;//ori r2,r1,0x9c98
    instr_mem[1] = 32'b001101_00010_00011_0000_0000_0000_0011;//ori r3,r2,0x0003
    instr_mem[2] = 32'b001101_00010_00100_0110_0000_0000_0000;//ori r4,r2,0x3000
    instr_mem[3] = 32'b001101_00100_00101_0000_0000_0000_0000;//ori r5,r4,0x0000
    instr_mem[4] = 32'b000000_00010_00011_00110_00000_100100;//and r6,r2,r3
    instr_mem[5] = 32'b000000_00010_00011_00111_00000_100101;//or r7,r2,r3
    instr_mem[6] = 32'b000000_00010_00011_00111_00000_100110;//xor r7,r2,r3
    instr_mem[7] = 32'b000000_00010_00011_00111_00000_100111;//nor r7,r2,r3
    instr_mem[8] = 32'b001100_00111_01000_1010_1010_1010_1111;//andi r8,r7,0xaaaf
    instr_mem[9] = 32'b001110_01000_01001_1111_1111_1111_1111;//xori r9,r8,0xffff
    instr_mem[10] = 32'b001111_00000_01001_1000_1000_1000_1000;//lui r9,0x8888
    instr_mem[11] = 32'b000000_00000_01001_01010_00010_000000;//sll r10,r9,2
    instr_mem[12] = 32'b000000_00000_01001_01010_00010_000010;//srl r10,r9,2
    instr_mem[13] = 32'b000000_00000_01001_01010_00010_000011;//sra r10,r9,2
    instr_mem[14] = 32'b000000_00100_01001_01010_00000_000100;//sllv r10,r9,r3
    instr_mem[15] = 32'b000000_00100_01001_01010_00000_000110;//srlv r10,r9,r3
    instr_mem[16] = 32'b000000_00100_01001_01010_00000_000111;//srav r10,r9,r3
    instr_mem[17] = 32'b000000_01010_00000_01011_00000_001011;//movn r11,r10,r0
    instr_mem[18] = 32'b000000_01010_00000_01011_00000_001010;//movn r11,r10,r0
end

always @ (*) begin
    if(!ce) begin
        instr <= 32'h00000000;
    end
    else begin
        instr <= instr_mem[addr[9:2]];
    end
end
endmodule
