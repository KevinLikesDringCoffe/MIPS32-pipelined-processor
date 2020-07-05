//definations for codes
`define opcode 31:26
`define funcode 5:0

`define rs 25:21
`define rt 20:16
`define rd 15:11
`define imm 15:0
`define sa 10:6

//definations for instruction type (r/imm)
`define type_i 2'b00 // r + imm
`define type_r 2'b01 // r + r
`define type_s 2'b10 // r + pc[31:28]


//definations for the J type instrction format
`define j_address 25:0

//definations for the opcode
`define op_special 6'b000000
`define op_ori 6'b001101
`define op_andi 6'b001100
`define op_xori 6'b001110
`define op_lui 6'b001111

//definations for the funcode
`define func_and 6'b100100
`define func_or 6'b100101
`define func_xor 6'b100110
`define func_nor 6'b100111
`define func_sll 6'b000000
`define func_srl 6'b000010
`define func_sra 6'b000011
`define func_sllv 6'b000100
`define func_srlv 6'b000110
`define func_srav 6'b000111
`define func_movn 6'b001011
`define func_movz 6'b001010
`define func_mfhi 6'b010000
`define func_mflo 6'b010010
`define func_mthi 6'b010001
`define func_mtlo 6'b010011

//definations for the aluop
`define aluop_and 4'b0000
`define aluop_or 4'b0001
`define aluop_xor 4'b0010
`define aluop_nor 4'b0011
`define aluop_sll 4'b0100
`define aluop_srl 4'b0101
`define aluop_sra 4'b0110
`define aluop_mfhi 4'b0111
`define aluop_mflo 4'b1000

`define aluop_add 4'b1111
`define aluop_sub 4'b1111