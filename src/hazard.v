`timescale 1ns / 1ps
`include "definations.vh"

module hazard(
    input [4:0] raddr1,
    input [4:0] raddr2,
    input [31:0] rdata1,
    input [31:0] rdata2,
    
    input [31:0] ex_alu_result,
    input [4:0] ex_waddr,
    input ex_reg_wr,
    
    input [31:0] mem_alu_result,
    input [4:0] mem_waddr,
    input mem_reg_wr,
    
    output reg [31:0] id_rdata1,
    output reg [31:0] id_rdata2
);
wire ex_match1;
wire ex_match2;
wire mem_match1;
wire mem_match2;

assign ex_match1 = ex_reg_wr & (raddr1 == ex_waddr);
assign ex_match2 = ex_reg_wr & (raddr2 == ex_waddr);
assign mem_match1 = mem_reg_wr & (raddr1 == mem_waddr);
assign mem_match2 = mem_reg_wr & (raddr2 == mem_waddr);

always @ (*) begin
    if(ex_match1) begin
        id_rdata1 <= ex_alu_result;
    end
    else if(mem_match1) begin
        id_rdata1 <= mem_alu_result;
    end
    else begin
        id_rdata1 <= rdata1;
    end
end

always @ (*) begin
    if(ex_match2) begin
        id_rdata2 <= ex_alu_result;
    end
    else if(mem_match2) begin
        id_rdata2 <= mem_alu_result;
    end
    else begin
        id_rdata2 <= rdata2;
    end
end

endmodule
