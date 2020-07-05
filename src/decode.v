`include "definations.vh"

module decode(
    input [31:0] instr,
    input [31:0] rdata1,
    input [31:0] rdata2,
    
    output reg [1:0] instr_type,
    output reg [3:0] aluop,
    output reg [31:0] ext_imm,
    output reg [4:0] raddr1,
    output reg [4:0] raddr2,
    output reg [4:0] waddr,
    output reg reg_wr,
    output reg mem_wr,
    output reg from_pc,
    output reg to_pc,
    output reg to_hi,
    output reg to_lo
);


always @ (*) begin
    case(instr[`opcode])
        `op_ori: begin
          reg_wr <= 1'b1;
          mem_wr <= 1'b0;
          waddr <= instr[`rt];
          raddr1 <= instr[`rs];
          raddr2 <= 5'h0;
          ext_imm <= {16'h0000,instr[`imm]};
          aluop <= `aluop_or;
          instr_type <= `type_i;
          from_pc <= 1'b0;
          to_pc <= 1'b0;
          to_hi <= 1'b0;
          to_lo <= 1'b0;
        end

        `op_andi: begin
          reg_wr <= 1'b1;
          mem_wr <= 1'b0;
          waddr <= instr[`rt];
          raddr1 <= instr[`rs];
          raddr2 <= 5'h0;
          ext_imm <= {16'h0000,instr[`imm]};
          aluop <= `aluop_and;
          instr_type <= `type_i;
          from_pc <= 1'b0;
          to_pc <= 1'b0;
          to_hi <= 1'b0;
          to_lo <= 1'b0;
        end

        `op_xori: begin
          reg_wr <= 1'b1;
          mem_wr <= 1'b0;
          waddr <= instr[`rt];
          raddr1 <= instr[`rs];
          raddr2 <= 5'h0;
          ext_imm <= {16'h0000,instr[`imm]};
          aluop <= `aluop_xor;
          instr_type <= `type_i;
          from_pc <= 1'b0;
          to_pc <= 1'b0;
          to_hi <= 1'b0;
          to_lo <= 1'b0;
        end

        `op_lui: begin
          reg_wr <= 1'b1;
          mem_wr <= 1'b0;
          waddr <= instr[`rt];
          raddr1 <= 5'h0;
          raddr2 <= 5'h0;
          ext_imm <= {instr[`imm],16'h0000};
          aluop <= `aluop_or;
          instr_type <= `type_i;
          from_pc <= 1'b0;
          to_pc <= 1'b0;
          to_hi <= 1'b0;
          to_lo <= 1'b0;
        end

        `op_special: begin
          case(instr[`funcode])
            `func_and: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rs];
              raddr2 <= instr[`rt];
              ext_imm <= 32'h00000000;
              aluop <= `aluop_and;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_or: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rs];
              raddr2 <= instr[`rt];
              ext_imm <= 32'h00000000;
              aluop <= `aluop_or;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_xor: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rs];
              raddr2 <= instr[`rt];
              ext_imm <= 32'h00000000;
              aluop <= `aluop_xor;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_nor: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rs];
              raddr2 <= instr[`rt];
              ext_imm <= 32'h00000000;
              aluop <= `aluop_nor;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_sll: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= 5'h0;
              ext_imm <= {27'b0,instr[`sa]};
              aluop <= `aluop_sll;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_srl: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= 5'h0;
              ext_imm <= {27'b0,instr[`sa]};
              aluop <= `aluop_srl;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_sra: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= 5'h0;
              ext_imm <= {27'b0,instr[`sa]};
              aluop <= `aluop_sra;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_sllv: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= instr[`rs];
              ext_imm <= 32'h0;
              aluop <= `aluop_sll;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_srlv: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= instr[`rs];
              ext_imm <= 32'h0;
              aluop <= `aluop_srl;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_srav: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= instr[`rt];
              raddr2 <= instr[`rs];
              ext_imm <= 32'h0;
              aluop <= `aluop_sra;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_movn: begin
              raddr2 <= instr[`rt];
              if ( rdata2 == 32'b0) begin
                reg_wr <= 1'b0;
                mem_wr <= 1'b0;
                waddr <= 5'h0;
                raddr1 <= 5'h0;
//                raddr2 <= raddr2;
                ext_imm <= 32'h0;
                aluop <= `aluop_or;
                instr_type <= `type_i;
                from_pc <= 1'b0;
                to_pc <= 1'b0;
                to_hi <= 1'b0;
                to_lo <= 1'b0;
              end
              else begin
                reg_wr <= 1'b1;
                mem_wr <= 1'b0;
                waddr <= instr[`rd];
                raddr1 <= instr[`rs];
//                raddr2 <= raddr2;
                ext_imm <= 32'h0;
                aluop <= `aluop_or;
                instr_type <= `type_i;
                from_pc <= 1'b0;
                to_pc <= 1'b0;
                to_hi <= 1'b0;
                to_lo <= 1'b0;
              end
            end

            `func_movz: begin
              raddr2 <= instr[`rt];
              if (rdata2 == 32'b0) begin
                reg_wr <= 1'b1;
                mem_wr <= 1'b0;
                waddr <= instr[`rd];
                raddr1 <= instr[`rs];
//                raddr2 <= raddr2;
                ext_imm <= 32'h0;
                aluop <= `aluop_or;
                instr_type <= `type_i;
                from_pc <= 1'b0;
                to_pc <= 1'b0;
                to_hi <= 1'b0;
                to_lo <= 1'b0;
              end
              else begin
                reg_wr <= 1'b0;
                mem_wr <= 1'b0;
                waddr <= 5'h0;
                raddr1 <= 5'h0;
//                raddr2 <= raddr2;
                ext_imm <= 32'h0;
                aluop <= `aluop_or;
                instr_type <= `type_i;
                from_pc <= 1'b0;
                to_pc <= 1'b0;
                to_hi <= 1'b0;
                to_lo <= 1'b0;
              end
            end

            `func_mfhi: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= 5'h0;
              raddr2 <= 5'h0;
              ext_imm <= 32'h0;
              aluop <= `aluop_mfhi;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_mflo: begin
              reg_wr <= 1'b1;
              mem_wr <= 1'b0;
              waddr <= instr[`rd];
              raddr1 <= 5'h0;
              raddr2 <= 5'h0;
              ext_imm <= 32'h0;
              aluop <= `aluop_mflo;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end

            `func_mthi: begin
              reg_wr <= 1'b0;
              mem_wr <= 1'b0;
              waddr <= 5'h0;
              raddr1 <= instr[`rs];
              raddr2 <= 5'h0;
              ext_imm <= 32'h0;
              aluop <= `aluop_or;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b1;
              to_lo <= 1'b0;
            end

            `func_mtlo: begin
              reg_wr <= 1'b0;
              mem_wr <= 1'b0;
              waddr <= 5'h0;
              raddr1 <= instr[`rs];
              raddr2 <= 5'h0;
              ext_imm <= 32'h0;
              aluop <= `aluop_or;
              instr_type <= `type_i;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b1;
            end

            default: begin
              reg_wr <= 1'b0;
              mem_wr <= 1'b0;
              waddr <= 5'h0;
              raddr1 <= 5'h0;
              raddr2 <= 5'h0;
              ext_imm <= 32'h00000000;
              aluop <= `aluop_or;
              instr_type <= `type_r;
              from_pc <= 1'b0;
              to_pc <= 1'b0;
              to_hi <= 1'b0;
              to_lo <= 1'b0;
            end
          endcase
        end
        
        default: begin
            reg_wr <= 1'b0;
            mem_wr <= 1'b0;
            waddr <= 5'h0;
            raddr1 <= 5'h0;
            raddr2 <= 5'h0;
            ext_imm <= 32'h00000000;
            aluop <= `aluop_or;
            instr_type <= `type_i;
            from_pc <= 1'b0;
            to_pc <= 1'b0;
            to_hi <= 1'b0;
            to_lo <= 1'b0;
        end
    endcase
end
endmodule
