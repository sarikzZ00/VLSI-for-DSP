
module top_level_tb();

logic clk480;
logic clk16; //down sampled by 30x
logic reset;


logic signed [10:0] sig_modulated_fixed_real;
logic signed [10:0] sig_modulated_fixed_imag;

logic signed [10:0] demod_Lo_real;
logic signed [10:0] demod_Lo_imag;

logic signed [61:0] sig_demod_30_real;
logic signed [61:0] sig_demod_30_imag;

p1 dut(.*);

//read and write
integer read_file_1;
integer read_file_2;
integer write_file;


always begin
    #31250 clk16 = ~clk16;
end

always begin
    #1041.6667 clk480 = ~clk480;
end


always @(posedge clk16) begin
    if (sig_demod_30_real !== 'x && sig_demod_30_imag !== 'x) begin
        $fwrite(write_file, "%d, %d\n", sig_demod_30_real, sig_demod_30_imag);
    end
end

initial begin
    clk480 = 0;
    clk16 = 0;
    reset = 1;
    read_file_1 = $fopen("sig_modulated_fixed_output.txt", "r");
    read_file_2 = $fopen("demod_Lo_output.txt", "r");
    write_file = $fopen("result.txt", "w");

    @(negedge clk480);
    @(negedge clk480);
    reset = 0;
    while(!$feof(read_file_1) && !$feof(read_file_2)) begin
        @(negedge clk480);
        $fscanf(read_file_1, "%d, %d", sig_modulated_fixed_real, sig_modulated_fixed_imag);
        $fscanf(read_file_2, "%d, %d", demod_Lo_real, demod_Lo_imag);
    end
    $finish;
end
endmodule
