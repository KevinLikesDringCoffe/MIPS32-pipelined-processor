`define opcode 31:26

//definations of instruction type
`define type_i 2'b00
`define type_r 2'b01
`define type_j 2'b10

// definarions for the R type instruction format
`define r_rs 25:21
`define r_rt 20:16
`define r_rd 15:11
`define r_shamt 10:6
`define r_funct 5:0

//definations for the I type instruction format
`define i_rs 25:21
`define i_rt 20:16
`define i_immediate 15:0

//definations for the J type instrction format
`define j_address 25:0

//definations for the R type instruction

//definations for the I type instruction
`define op_ori 6'b001101

//definations for the J type instruction

//definations for the aluop
`define aluop_or 2'b00
`define aluop_and 2'b01
`define aluop_add 2'b10
`define aluop_sub 2'b11