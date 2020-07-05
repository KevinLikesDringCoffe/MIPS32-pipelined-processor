`timescale 1ns / 1ps

module instr_rom(
    input ce,
    input [31:0] addr,
    output reg [31:0] instr 
);

reg [31:0] instr_mem [255:0];

initial begin
    instr_mem[0] = 32'b001101_00001_00010_1001_1100_1001_1000; // r2 <- r1 or imm
    instr_mem[1] = 32'b001101_00010_00011_0000_0000_0000_0011; // r3 <- r2 or imm
    instr_mem[2] = 32'b001111_00000_00100_0110_0000_0000_0000; // lui r4
    instr_mem[3] = 32'b000000_00100_00011_00101_00000_100101; // r5 <- r4 or r3
    instr_mem[4] = 32'b000000_00100_00011_00101_00000_100111; // r5 <- r4 nor r3
    instr_mem[5] = 32'b000000_00000_00010_00110_10100_000000; // r6 <- r2<<sa
    instr_mem[6] = 32'b000000_00010_00001_00111_00000_001010; // r7 <- r2 (r1==0)
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
