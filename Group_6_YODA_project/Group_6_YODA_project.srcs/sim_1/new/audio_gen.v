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
    
    if (interval == 2) begin //if there are 2 interval segments
        k = (SIZE/2); //initialises the starting position of the second rom iteration
    end else if (interval == 3) begin  //if there are 3 interval segments      
        l = (SIZE/3)*2; //initialises the starting position of the third rom iteration
        k = (SIZE/3); //initialises the starting position of the second rom iteration
    end
    
    enable = 1'b0; //set the enable line to a logic low
    done = 1'b0; //set the done line to a logic low
end
    
//at every positive edge of the clock, output a sample from the audio file
always@(posedge clk) begin
    if (interval == 1) begin //if there is only 1 segment (i.e. the audio file is to be analysed as one segment)
        sine_1 = rom_memory[i]; //set the first and only output line to a value from rom memory
    end else if (interval == 2) begin //if there are 2 interval segments
        sine_1 = rom_memory[i]; //set the first output line to a value from rom memory
        sine_2 = rom_memory[k]; //set the second output line to a value from rom memory
    end else if (interval == 3) begin //if there are 3 interval segments
        sine_1 = rom_memory[i]; //set the first output line to a value from rom memory
        sine_2 = rom_memory[k]; //set the second output line to a value from rom memory
        sine_3 = rom_memory[l]; //set the third output line to a value from rom memory
    end
    
    //initialises the output lines before sending the output to other modules
    if (j == 1) begin
        enable = 1'b1; //set the enable line to a logic high
    end
    
    i = i + 1; //increases the rom position variable
    j = j + 1; //increases the enable position variable
    
    if (interval == 1) begin //if there is 1 interval segment
        if (i == SIZE) begin //if the rom position variable is at its maximum value
            done = 1'b1; //set the done line to a logic high
            i = 0; //set the rom position variable to its initial value
        end
    end else if (interval == 2) begin //if there are 2 interval segments
        k = k + 1; //increases the rom position variable
        if(k == SIZE) begin //if the rom position variable is at its maximum value
            done = 1'b1; //set the done line to a logic high
            k = SIZE/2; //set the rom position variable to its initial value
        end if(i == SIZE/2) begin //if the rom position variable is at its maximum value
            done = 1'b1; //set the done line to a logic high
            i = 0; //set the rom position variable to its initial value
            end
    end else if (interval == 3) begin //if there are 3 interval segments
        k = k+ 1; //increases the rom position variable
        l = l+ 1; //increases the rom position variable
        if(k == 2*SIZE/3) begin //if the rom position variable is at its maximum value
            k = SIZE/3; //set the rom position variable to its initial value
            done = 1'b1; //set the done line to a logic high
        end if (l == SIZE) begin //if the rom position variable is at its maximum value
            l = 2*(SIZE/3); //set the rom position variable to its initial value
            done = 1'b1; //set the done line to a logic high
        end if(i == SIZE/3) begin //if the rom position variable is at its maximum value
            i = 0; //set the rom position variable to its initial value
            done = 1'b1; //set the done line to a logic high
            end
    end
end

endmodule


