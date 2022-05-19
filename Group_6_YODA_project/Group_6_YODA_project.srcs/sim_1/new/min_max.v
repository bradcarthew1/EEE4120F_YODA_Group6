`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Galactic Republic
// Engineer: Thomas Stern (STRTHO008), Bradley Carthew (CRTBRA002)
// 
// Create Date: 10.05.2022 20:04:06
// Design Name: Signal Processing
// Module Name: min_max
// Project Name: YODA Digital Accelerator
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
    input clk,
    input wire enable,
    input wire [31:0] sound_Value,
    output reg [31:0] min,
    output reg [31:0] max
    );


always@(negedge clk) begin
    if (enable == 1'b1) begin
        if (sound_Value < min) begin
            min = sound_Value;
        end
        if (sound_Value > max) begin
            max = sound_Value;
        end 
    end else begin
        min = sound_Value;
        max = sound_Value;
    end
end

endmodule
