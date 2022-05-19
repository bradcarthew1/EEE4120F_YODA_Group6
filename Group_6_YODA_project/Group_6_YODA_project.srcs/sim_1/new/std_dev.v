`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2022 02:13:08 PM
// Design Name: 
// Module Name: std_dev
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


module std_dev(
    input clk,
    input done,
    input wire [1:0] interval,
    input wire [31:0] min_1, max_1, min_2, max_2, min_3, max_3,
    output reg [31:0] std_min_1, std_max_1, std_min_2, std_max_2, std_min_3, std_max_3
    );
    
    reg [31:0] min_mean, max_mean, min_std_dev, max_std_dev;
    reg [31:0] min_sum, max_sum;
    
always @(negedge clk) begin
    if (done == 1'b1) begin
        if (interval == 1) begin
            std_min_1 = min_1;
            std_max_1 = max_1;
        end else if (interval == 2) begin
            min_mean = (min_1 + min_2)*0.5;
            max_mean = (max_1 + max_2)*0.5;
            min_sum = (min_1-min_mean)**2 + (min_2-min_mean)**2; 
            max_sum = (max_1-max_mean)**2 + (max_2-max_mean)**2;
            min_std_dev = (min_sum*0.5)**(0.5);
            max_std_dev = (max_sum*0.5)**(0.5);
//            $display("%d %d",min_sum, max_sum);
//            $display("%d %d",min_std_dev, max_std_dev);
            if ((min_1 <= min_mean+min_std_dev) && (min_1 >= min_mean-min_std_dev)) begin
                std_min_1 = min_1; 
            end
            if ((min_2 <= min_mean+min_std_dev) && (min_2 >= min_mean-min_std_dev)) begin
                std_min_2 = min_2; 
            end
            if ((max_1 <= max_mean+max_std_dev) && (max_1 >= max_mean-max_std_dev)) begin
                std_max_1 = max_1; 
            end
            if ((max_2 <= max_mean+max_std_dev) && (max_2 >= max_mean-max_std_dev)) begin
                std_max_2 = max_2; 
            end
        end else if (interval == 3) begin
            min_mean = (min_1 + min_2 + min_3)*(0.33333333);
            max_mean = (max_1 + max_2 + max_3)*(0.33333333);
//            $display("%d %d %d",min_1,min_2,min_3);
//            $display("%d %d %d",max_1,max_2,max_3);
            min_sum = (min_1-min_mean)**2 + (min_2-min_mean)**2+ (min_3-min_mean)**2; 
            max_sum = (max_1-max_mean)**2 + (max_2-max_mean)**2+ (max_3-max_mean)**2;
            min_std_dev = (min_sum*0.33333333)**(0.5);
            max_std_dev = (max_sum*0.33333333)**(0.5);
            $display("%d %d",min_mean, max_mean);
            $display("%d %d",min_std_dev, max_std_dev);
            if ((min_1 <= min_mean+min_std_dev) && (min_1 >= min_mean-min_std_dev)) begin
                std_min_1 = min_1; 
            end
            if ((min_2 <= min_mean+min_std_dev) && (min_2 >= min_mean-min_std_dev)) begin
                std_min_2 = min_2; 
            end
            if ((min_3 <= min_mean+min_std_dev) && (min_3 >= min_mean-min_std_dev)) begin
                std_min_3 = min_3; 
            end
            if ((max_1 <= max_mean+max_std_dev) && (max_1 >= max_mean-max_std_dev)) begin
                std_max_1 = max_1; 
            end
            if ((max_2 <= max_mean+max_std_dev) && (max_2 >= max_mean-max_std_dev)) begin
                std_max_2 = max_2; 
            end
            if ((max_3 <= max_mean+max_std_dev) && (max_3 >= max_mean-max_std_dev)) begin
                std_max_3 = max_3; 
            end
            
        end
    end
end
endmodule