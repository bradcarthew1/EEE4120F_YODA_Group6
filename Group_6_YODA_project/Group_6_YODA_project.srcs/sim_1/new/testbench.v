`timescale 1ns / 1ps

module testbench;
    reg clk;
    wire [31:0] sine_1, sine_2, sine_3, min_1, max_1, min_2, max_2, min_3, max_3;
    wire enable, done;
    wire [31:0] std_min_1, std_min_2, std_min_3, std_max_1, std_max_2, std_max_3;
    reg [2:0] interval = 1;
    
    //initates and connects the sine generator to the testBench
    audio_gen baseAudioGen(
        .clk(clk),
        .interval(interval),
        .enable(enable),
        .done(done),
        .sine_1(sine_1),
        .sine_2(sine_2),
        .sine_3(sine_3)
    );
    
    min_max min_max_1(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_1),
    .min(min_1),
    .max(max_1)
    );
    
    min_max min_max_2(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_2),
    .min(min_2),
    .max(max_2)
    );
    
     min_max min_max_3(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_3),
    .min(min_3),
    .max(max_3)
    );
    
    std_dev std_dev_1(
    .clk(clk),
    .done(done),
    .interval(interval),
    .min_1(min_1),
    .max_1(max_1),
    .min_2(min_2),
    .max_2(max_2),
    .min_3(min_3),
    .max_3(max_3),
    .std_min_1(std_min_1),
    .std_max_1(std_max_1),
    .std_min_2(std_min_2),
    .std_max_2(std_max_2),
    .std_min_3(std_min_3),
    .std_max_3(std_max_3)
    );
    
    //frequency control
    parameter freq = 100000000; //100 MHz
    parameter SIZE = 441000; 
    parameter clockRate = 0.001; //clock time (make this an output from the sine modules)
    
    //Generate a clock with the above frequency control
    initial
    begin 
    //$display("------------------------------");
    //$display("sine     min        max");
    //$display("------------------------------");
    //$monitor("%d    %d      %d",sine,min,max);
    clk = 1'b0;
    end
    always #clockRate clk = ~clk; //#1 is one nano second delay (#x controlls the speed)
    
endmodule