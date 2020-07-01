`define opcode 31:26

//definations of instruction type
`define type_i 2'b00
`define type_r 2'b01
`define type_j 2'b10

// definarions for the R type instruction format
`define r_rs 25:21
`define r_rt 20:16
`define r_rd 15:11
`define r_sa 10:6
`define r_funct 5:0

//definations for the I type instruction format
`define i_rs 25:21
`define i_rt 20:16
`define i_immediate 15:0

//definations for the J type instrction format
`define j_address 25:0

//definations for the R type instruction
`define op_special 6'b000000
`define funct_and 6'b100100
`define funct_or 6'b100101
`define funct_xor 6'b100110
`define funct_nor 6'b100111
`define funct_sll 6'b000000
`define funct_srl 6'b000010
`define funct_sra 6'b000011
`define funct_sllv 6'b000100
`define funct_srlv 6'b000110
`define funct_srav 6'b000111
`define funct_sync 6'b001111
`define op_pref 6'b110011

`define funct_movn 6'b001011
`define funct_movz 6'b001010
`define funct_mfhi 6'b010000
`define funct_mflo 6'b010010
`define funct_mthi 6'b010001
`define funct_mtlo 6'b010011

//definations for the I type instruction
`define op_ori 6'b001101
`define op_andi 6'b001100
`define op_xori 6'b001110
`define op_lui 6'b001111

//definations for the J type instruction

//definations for the aluop
`define aluop_bit 3:0
`define aluop_or 4'h0
`define aluop_and 4'h1
`define aluop_add 4'h2
`define aluop_sub 4'h3
`define aluop_xor 4'h4
`define aluop_nor 4'h5
`define aluop_sll 4'h6
`define aluop_srl 4'h7
`define aluop_sra 4'h8
`define aluop_mv 4'h9


//definations for the conditional code
`define cond_bit 2:0
`define no_cond 3'b000
`define cond_src2_nz 3'b001
`define cond_src2_z 3'b010
