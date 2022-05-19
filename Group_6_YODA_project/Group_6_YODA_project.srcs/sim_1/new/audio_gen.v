`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 09:55:57 AM
// Design Name: 
// Module Name: audio_gen
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


module audio_gen(
    input clk ,
    input wire [1:0] interval,
    output reg enable,
    output reg done,
    output reg [31:0] sine_1, sine_2, sine_3
    );
    
parameter SIZE = 441000;  
reg [31:0] rom_memory [SIZE-1:0];
integer i,j,k,l;

initial begin
    $readmemh("ImperialMarch.mem", rom_memory);
    i = 0;
    j = 0;
    l = 0;
    k = 0;
    
    if (interval == 2) begin
        k = (SIZE/2);
    end else if (interval == 3) begin       
        l = (SIZE/3)*2;
        k = (SIZE/3);
    end
    
    enable = 1'b0;
    done = 1'b0;
end
    
//At every positive edge of the clock, output a sine wave sample.
always@(posedge clk) begin
    if (interval == 1) begin
        sine_1 = rom_memory[i];
    end else if (interval == 2) begin
        sine_1 = rom_memory[i];
        sine_2 = rom_memory[k];
    end else if (interval == 3) begin
        sine_1 = rom_memory[i];
        sine_2 = rom_memory[k];
        sine_3 = rom_memory[l];
    end
    
    if (j == 1) begin
        enable = 1'b1;
    end
    
    i = i + 1;
    j = j + 1;
    
    if (interval == 1) begin
        if (i == SIZE) begin
            done = 1'b1;
            i = 0;
        end
    end else if (interval == 2) begin
        k = k + 1;
        if(k == SIZE) begin
            done = 1'b1;
            k = SIZE/2;
        end if(i == SIZE/2) begin
            done = 1'b1;
            i = 0;
            end
    end else if (interval == 3) begin
        k = k+ 1;
        l = l+ 1;
        if(k == 2*SIZE/3) begin
            k = SIZE/3;
            done = 1'b1;
        end if (l == SIZE) begin
            l = 2*(SIZE/3);
            done = 1'b1;
        end if(i == SIZE/3) begin
            i = 0;
            done = 1'b1;
            end
    end
end

endmodule


