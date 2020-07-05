`timescale 1ns / 1ps
`include "definations.vh"

module harzard(
    input ex_reg_wr,
    input mem_reg_wr,
    input [4:0] id_raddr1,
    input [4:0] id_raddr2,
    input [4:0] ex_waddr,
    input [4:0] mem_waddr,
    input [31:0] ex_alu_result,
    input [31:0] mem_alu_result,
    output reg match_1,
    output reg match_2,
    output reg [31:0] match_data1,
    output reg [31:0] match_data2
);

always @(*) begin
    if (ex_reg_wr==1 & ex_waddr==id_raddr1) begin
        match_1 <= 1;
        match_data1 <= ex_alu_result;
    end
    else if (mem_reg_wr==1 & mem_waddr==id_raddr1) begin
        match_1 <= 1;
        match_data1 <= mem_alu_result;
    end
    else begin
        match_1 <= 0;
        match_data1 <= 32'b0;
    end

    if (ex_reg_wr==1 & ex_waddr==id_raddr2) begin
        match_2 <= 1;
        match_data2 <= ex_alu_result;
    end
    else if (mem_reg_wr==1 & mem_waddr==id_raddr2) begin
        match_2 <= 1;
        match_data2 <= mem_alu_result;
    end
    else begin
        match_2 <= 0;
        match_data2 <= 32'b0;
    end

end

endmodule
