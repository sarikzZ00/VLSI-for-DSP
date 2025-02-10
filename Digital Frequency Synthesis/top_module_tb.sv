module top_module_tb;
    // Testbench signals
    logic clk;
    logic reset;
    logic [7:0] period;
    logic signed [7:0] my_sine_out;
    logic signed [7:0] my_cosine_out;

    // File handles
    int sin_file, cos_file;

    top_module DUT (
        .clk(clk),
        .reset(reset),
        .period(period),
        .my_sine_out(my_sine_out),
        .my_cosine_out(my_cosine_out)
    );

    always #5 clk = ~clk; 

    initial begin
        clk = 0;
        reset = 0;
        period = 16;

        // Open the files for writing
        sin_file = $fopen("out_sin.txt", "w");
        cos_file = $fopen("out_cos.txt", "w");

        reset = 1;
        #10 reset = 0;
        $fmonitor(sin_file, "%d\n", my_sine_out);    
        $fmonitor(cos_file, "%d\n", my_cosine_out); 

        #30000;
           

        // Close the files after the simulation
        $fclose(sin_file);
        $fclose(cos_file);

        $finish;
    end

endmodule
