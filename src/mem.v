`timescale 1ns / 1ps
`include "definations.vh"

module mem(
    input mem_rd,
    input mem_wr,
    
    input [31:0] reg_data,
    input [31:0] raw_data,
    input [31:0] addr,
    input [2:0] mem_opcode,
    
    output reg [3:0] sel,
    output reg [31:0] rdata,
    output reg [31:0] wdata
);
reg [7:0] byte_sel;
reg [15:0] hw_sel;
always @ (*) begin
    if(mem_rd) begin
        case(mem_opcode)
            `mem_op_b: begin
                case(addr[1:0])
                    2'b00: rdata <= {{24{raw_data[31]}},raw_data[31:24]};
                    2'b01: rdata <= {{24{raw_data[23]}},raw_data[23:16]};
                    2'b10: rdata <= {{24{raw_data[15]}},raw_data[15:8]};
                    2'b11: rdata <= {{24{raw_data[7]}},raw_data[7:0]};
                endcase
            end
            `mem_op_bu: begin
                case(addr[1:0])
                    2'b00: rdata <= {24'b0,raw_data[31:24]};
                    2'b01: rdata <= {24'b0,raw_data[23:16]};
                    2'b10: rdata <= {24'b0,raw_data[15:8]};
                    2'b11: rdata <= {24'b0,raw_data[7:0]};
                endcase
            end
            `mem_op_h: begin
                case(addr[1])
                    1'b0: rdata <= {{16{raw_data[31]}},raw_data[31:16]};
                    1'b1: rdata <= {{16{raw_data[15]}},raw_data[15:0]};
                endcase
            end
            `mem_op_hu: begin
                case(addr[1])
                    1'b0: rdata <= {16'b0,raw_data[31:16]};
                    1'b1: rdata <= {16'b0,raw_data[15:0]};
                endcase
            end
            `mem_op_w: begin
                rdata <= raw_data;
            end
            `mem_op_wl: begin
                case(addr[1:0])
                    2'b00: rdata <= raw_data;
                    2'b01: rdata <= {raw_data[23:0],8'b0};
                    2'b10: rdata <= {raw_data[15:0],16'b0};
                    2'b11: rdata <= {raw_data[7:0],24'b0};
                endcase
            end
            `mem_op_wr: begin
                case(addr[1:0])
                    2'b00: rdata <= {24'b0,raw_data[7:0]};
                    2'b01: rdata <= {16'b0,raw_data[15:0]};
                    2'b10: rdata <= {8'b0,raw_data[23:0]};
                    2'b11: rdata <= raw_data;
                endcase
            end
        endcase
    end
    else if(mem_wr) begin
        case(mem_opcode)
            `mem_op_b: begin
                case(addr[1:0])
                    2'b00: begin
                        sel <= 4'b1000;
                        wdata <= {reg_data[7:0],24'b0};
                    end
                    2'b01: begin
                        sel <= 4'b0100;
                        wdata <= {8'b0,reg_data[7:0],16'b0};
                    end
                    2'b10: begin
                        sel <= 4'b0010;
                        wdata <= {16'b0,reg_data[7:0],8'b0};
                    end
                    2'b11: begin
                        sel <= 4'b0001;
                        wdata <= {24'b0,reg_data[7:0]};
                    end
                endcase
            end
            `mem_op_h: begin
                case(addr[1])
                    1'b0: begin
                        sel <= 4'b1100;
                        wdata <= {reg_data[15:0],16'b0};
                    end
                    1'b1: begin
                        sel <= 4'b0011;
                        wdata <= {16'b0,reg_data[15:0]};
                    end
                endcase
            end
            `mem_op_w: begin
                sel <= 4'b1111;
                wdata <= reg_data;
            end
            `mem_op_wl: begin
                case(addr[1:0])
                    2'b00: begin
                        sel <= 4'b1111;
                        wdata <= reg_data[31:0];
                    end
                    2'b01: begin
                        sel <= 4'b0111;
                        wdata <= {8'b0,reg_data[23:0]};
                    end
                    2'b10: begin
                        sel <= 4'b0011;
                        wdata <= {16'b0,reg_data[15:0]};
                    end
                    2'b11: begin
                        sel <= 4'b0001;
                        wdata <= {24'b0,reg_data[7:0]};
                    end
                endcase
            end
            `mem_op_wr: begin
                case(addr[1:0])
                    2'b00: begin
                        sel <= 4'b1000;
                        wdata <= {reg_data[7:0],23'b0};
                    end
                    2'b01: begin
                        sel <= 4'b1100;
                        wdata <= {reg_data[15:0],16'b0};
                    end
                    2'b10: begin
                        sel <= 4'b1110;
                        wdata <= {reg_data[7:0],8'b0};
                    end
                    2'b11: begin
                        sel <= 4'b1111;
                        wdata <= reg_data[31:0];
                    end
                endcase
            end
        endcase
    end
end
endmodule
