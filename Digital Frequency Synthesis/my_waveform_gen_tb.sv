module my_waveform_gen_tb;

    logic clk;
    logic reset;
    logic signed [11:0] control; 
    logic signed [7:0] my_sine_out;
    logic signed [7:0] my_cosine_out;

    // Instantiate the waveform generator
    my_waveform_gen DUT (.*);

    // Clock generation
    always #5 clk = ~clk;  

    initial begin
        //From Simvision
        // Initialize the signals
        //$dumpfile("filename.dump");
	    //$dumpfile("dump.vcd");
	    //$dumpvars( 0, my_waveform_gen_tb);
        clk = 0;
        reset = 0;
        //control = 135; //for 3.29 MHz
        //control = -55; // for -1.35 MHz
        control = 18; //for 0.43 MHz
        reset = 1;
        #10 reset = 0;

        #1000000;
        $finish;
    end

endmodule
