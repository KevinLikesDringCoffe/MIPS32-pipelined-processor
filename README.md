# MIPS32-pipelined-processor
A MIPS32 pipelined processor impelmented by Verilog HDL
## Version 1.0.200701
### Current functional unit
- Program counter
- Instruction ROM
- Instruction decoder
- Harzard resolve unit(partly)
- Execution unit
- Register file
### Current implemented instructions
- ori
- and
- or
- xor
- nor
- andi
- xori
- lui
- sll
- srl
- sra
- sllv
- srlv
- srav
- nop
- ssnop
- movn
- movz
## Version 1.1.200704
### Newly added functional unit
- Condition resolve unit
- Branch resolve unit
### Newly added instructions
- jr
- jalr
- j
- jal
- beq
- bgtz
- blez
- bne
- bltz
- bltzal
- bgez
- bgezal
- b instruction can be operated as beq r0,offset
- bal instruction can be operated as bgezal r0,offset
## Version 1.2.200708
### Newly added functional unit
- Data ram
- Memory stage ram interface
### Newly added instructions
- addu
- subu
- lb
- lbu
- lh
- lhu
- lw
- lwl
- lwr
- sb
- sh
- sw
- swl
- swr
# Features
A five stage pipeline which contains fetch, decode, execution, memory and writeback stages. The branch delay slot is removed in this implementation. The branch is detected at decode stage. Data hazard is resolve by forwarding register value from EX and MEM stage to the ID stage.