`define opcode 31:26

`define wb_src_alu_result 2'b00
`define wb_src_mem 2'b01

`define alu_src_rt 3'd0
`define alu_src_imm 3'd1
`define alu_src_sa 3'd2
`define alu_src_pc 3'd3

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
`define funct_movn 6'b001011
`define funct_movz 6'b001010
`define funct_add 6'b100000
`define funct_addu 6'b100001
`define funct_sub 6'b100010
`define funct_subu 6'b100011
`define funct_slt 6'b101010
`define funct_sltu 6'b101011
`define funct_jr 6'b001000
`define funct_jalr 6'b001001


//definations for the I type instruction
`define op_ori 6'b001101
`define op_andi 6'b001100
`define op_xori 6'b001110
`define op_lui 6'b001111

`define op_beq 6'b000100
`define op_bgtz 6'b000111
`define op_blez 6'b000110
`define op_bne 6'b000101

`define op_regimm 6'b000001
`define rt_bltz 5'b00000
`define rt_bltzal 5'b10000
`define rt_bgez 5'b00001
`define rt_bgezal 5'b10001

`define op_lb 6'b100000
`define op_lbu 6'b100100
`define op_lh 6'b100001
`define op_lhu 6'b100101
`define op_lw 6'b100011
`define op_sb 6'b101000
`define op_sh 6'b101001
`define op_sw 6'b101011
`define op_lwl 6'b100010
`define op_lwr 6'b100110
`define op_swl 6'b101010
`define op_swr 6'b101110
`define op_addi 6'b001000
`define op_addiu 6'b001001



//definations for the J type instruction
`define op_j 6'b000010
`define op_jal 6'b000011

//definations for the aluop
`define aluop_or 4'd0
`define aluop_and 4'd1
`define aluop_add 4'd2
`define aluop_sub 4'd3
`define aluop_xor 4'd4
`define aluop_nor 4'd5
`define aluop_sll 4'd6
`define aluop_srl 4'd7
`define aluop_sra 4'd8

//definations for mem op
`define mem_op_w 3'd0
`define mem_op_h 3'd1
`define mem_op_b 3'd2
`define mem_op_hu 3'd3
`define mem_op_bu 3'd4
`define mem_op_wl 3'd5
`define mem_op_wr 3'd6