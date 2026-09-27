`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2025 12:17:08
// Design Name: 
// Module Name: fifo_project
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_fifo(output reg[15:0]data_out,
output empty,full,input wr,rd,rst,clk,input[15:0]data_in);
integer fifo_count=0;
reg [5:0]wrptr;
reg [5:0]rdptr;
reg [15:0]fifo_mem[0:31];
// Write operration
    always@(posedge clk,posedge rst)
    begin 
        if(rst)
            begin
                   wrptr<=0;
            end
        else if(wr==1 && fifo_count!=31)
            begin 
                fifo_mem[wrptr]<=data_in;
                wrptr<=wrptr+1;
                fifo_count<=fifo_count+1;
            end
        else
            wrptr<=wrptr;
    end
    // rread condition
    always@(posedge clk,posedge rst)
    begin 
        if(rst)
            begin
                   rdptr<=0;
                   data_out<=16'hz;
            end
        else if(rd==1 && fifo_count!=0)
            begin 
                data_out<=fifo_mem[rdptr];
                rdptr<=rdptr+1;
                fifo_count<=fifo_count-1;
            end
        else
            rdptr<=rdptr;
    end
    assign full=(fifo_count==31)?1:0;
    assign empty=(fifo_count==0)?1:0;
endmodule
