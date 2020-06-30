`timescale 1ns / 1ps

module mips_soc_tb(
    
);
reg clk;
reg rst;

initial begin
    clk = 1'b0;
    forever #50 clk = ~clk;
end

initial begin
    rst = 1'b1;
    #195 rst = 1'b0;
    #1000 $stop;
end
mips_soc mips_soc_for_test(
    .clk(clk),
    .rst(rst)
);

endmodule
