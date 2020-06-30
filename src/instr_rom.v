`timescale 1ns / 1ps

module instr_rom(
    input ce,
    input [31:0] addr,
    output reg [31:0] instr 
);

reg [31:0] instr_mem [255:0];

initial begin
    instr_mem[0] = 32'b001101_00001_00010_1001_1100_1001_1000;
    instr_mem[1] = 32'b001101_00010_00011_0000_0000_0000_0011;
    instr_mem[2] = 32'b001101_00011_00100_0110_0000_0000_0000;
    instr_mem[3] = 32'b001101_00100_00101_0000_0000_0000_0000;
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
