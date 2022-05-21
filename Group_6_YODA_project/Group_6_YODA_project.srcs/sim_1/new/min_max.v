`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Cape Town
// Engineer: Thomas Stern (STRTHO008), Bradley Carthew (CRTBRA002)
// 
// Create Date: 10.05.2022 20:04:06
// Design Name: Ma
// Module Name: min_max
// Project Name: EEE4120F YODA Project
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


module min_max(
    input clk, //clock line
    input wire enable, //enable line
    input wire [31:0] sound_Value, //audio sample (from auido_gen module)
    output reg [31:0] min, //output line for minimum value 
    output reg [31:0] max //output line for maximum value 
    );

//at every negative edge of the clock, find the minimum and maximum value
always@(negedge clk) begin
    if (enable == 1'b1) begin //if the enable line is a logic hogh
        if (sound_Value < min) begin //is the audio sample less than the minimum value
            min = sound_Value; //set the minimum value to the audio sample 
        end
        if (sound_Value > max) begin //is the audio sample greater than the maximum value
            max = sound_Value; //set the maximum value to the audio sample
        end 
    end else begin //for the case when enable is a logic low
        min = sound_Value; //set the minimum value to an arbitrary audio sample 
        max = sound_Value; //set the maximum value to an arbitrary audio sample
    end
end

endmodule
