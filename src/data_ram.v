`timescale 1ns / 1ps
`include "definations.vh"

module data_ram(
    input clk,
    input ce,
    input we,
    input [31:0] addr,
    input [3:0] sel,
    input [31:0] wdata,
    
    output reg [31:0] rdata    
);

reg [7:0] data_mem_0 [255:0];
reg [7:0] data_mem_1 [255:0];
reg [7:0] data_mem_2 [255:0];
reg [7:0] data_mem_3 [255:0];

always @ (posedge clk) begin
    if(!ce) begin
        rdata <= 32'b0;
    end
    else if(we) begin
        if(sel[3]) data_mem_3[addr[9:2]] <= wdata[31:24];
        if(sel[2]) data_mem_2[addr[9:2]] <= wdata[23:16];
        if(sel[1]) data_mem_1[addr[9:2]] <= wdata[15:8];
        if(sel[0]) data_mem_0[addr[9:2]] <= wdata[7:0];
    end
end

always @ (*) begin
    if(!ce) begin
        rdata <= 32'b0;
    end
    else begin
        rdata <= {data_mem_3[addr[9:2]],
            data_mem_2[addr[9:2]],
            data_mem_1[addr[9:2]],
            data_mem_0[addr[9:2]]
        };
    end
end
endmodule
