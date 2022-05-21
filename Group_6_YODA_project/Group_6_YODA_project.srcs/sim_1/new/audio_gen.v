`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Cape Tonw
// Engineer: Bradley Carthew, Nathanael Thomas, Thomas Stern, Mohammed-Bilaal Sheik Hoosen
// 
// Create Date: 05/19/2022 09:55:57 AM
// Design Name: Audio Generator
// Module Name: audio_gen
// Project Name: EEE4121F YODA Project
// Target Devices: 
// Tool Versions: 
// Description: A module used to generate individual audio samples from an audio file.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module audio_gen(
    input clk , //clock line
    input wire [1:0] interval, //number of intervals
    output reg enable, //enable line for min_max module
    output reg done, //done line for std_dev module
    output reg [31:0] sine_1, sine_2, sine_3 //output line providing audio samples to min_max module
    );

parameter SIZE = 441000;  //initialises the size of the audio file
reg [31:0] rom_memory [SIZE-1:0]; //defines the register to store audio file samples
integer i,j,k,l; //defines the rom position variables

//initial block 
initial begin
    $readmemh("ImperialMarch.mem", rom_memory); //initialises the rom memory with an audio file
    //initialising the rom position variables
    i = 0;  
    j = 0; //used for the enable line
    l = 0;
    k = 0;
    
    if (interval == 2) begin //if there are two interval segments
        k = (SIZE/2); //initialises the starting position of the second rom iteration
    end else if (interval == 3) begin  //if there are three interval segments      
        l = (SIZE/3)*2; //initialises the starting position of the third rom iteration
        k = (SIZE/3); //initialises the starting position of the second rom iteration
    end
    
    enable = 1'b0; //set the enable line to a logic low
    done = 1'b0; //set the done line to a logic low
end
    
//at every positive edge of the clock, output a sample from the audio file
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


