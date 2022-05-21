`timescale 1ns / 1ps

//testbench module used to initialise and connect the modules
module testbench;
    reg clk; //defines the clock line
    wire [31:0] sine_1, sine_2, sine_3, min_1, max_1, min_2, max_2, min_3, max_3; //defines the audio_gen output wires, and min_max output wires
    wire enable, done; //defines the enable and done wires
    wire [31:0] std_min_1, std_min_2, std_min_3, std_max_1, std_max_2, std_max_3; //defines the std_dev output wires
    reg [2:0] interval = 1; // set the number of intervals (with a maximum of three intervals)
    
    //initates and connects the audio generator to the testbench
    audio_gen baseAudioGen(
        .clk(clk),
        .interval(interval),
        .enable(enable),
        .done(done),
        .sine_1(sine_1),
        .sine_2(sine_2),
        .sine_3(sine_3)
    );
    
    //initiates and connects the first instance of the min_max module to the testbench and audio_gen
    min_max min_max_1(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_1),
    .min(min_1),
    .max(max_1)
    );
    
    //initiates and connects the second instance of the min_max module to the testbench and audio_gen
    min_max min_max_2(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_2),
    .min(min_2),
    .max(max_2)
    );
    
    //initiates and connects the third instance of the min_max module to the testbench and audio_gen
     min_max min_max_3(
    .clk(clk),
    .enable(enable),
    .sound_Value(sine_3),
    .min(min_3),
    .max(max_3)
    );
    
    //initiates and connects the std_dev module to the testbench, audio_gen and min_max modules
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
    
    parameter SIZE = 441000; //sets the size of the audio file
    parameter clockRate = 0.001; //initialises the clock rate
    
    //Generate the clock using an initial block
    initial
    begin
    clk = 1'b0; //set the clock to a logic low initially
    end
    always #clockRate clk = ~clk; //controls the speed at which the clock will operate
    
endmodule
