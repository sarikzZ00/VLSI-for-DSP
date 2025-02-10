module Top_test;
logic clk;
logic reset;
logic signed [15:0] x_re;
logic signed [15:0] x_im;
logic signed [17:0] f_inst;

Top DUT (.*);

always begin
    #689.65517 clk = ~clk; //750Khz
end


int x_re_file, x_im_file;
int scan_real, scan_imag;


initial begin
    x_re_file = $fopen("x_re.txt", "r");
    x_im_file = $fopen("x_im.txt", "r");

    if (x_re_file == 0 || x_im_file == 0) begin
        $display("Error opening input files");
        $finish;
    end
    clk = 0;
    reset = 1;
    @(negedge clk);
    reset = 0;

    while (!$feof(x_re_file) && !$feof(x_im_file)) begin
        @(negedge clk);
        scan_real = $fscanf(x_re_file, "%d\n", x_re);
        scan_imag = $fscanf(x_im_file, "%d\n", x_im);
    end

    $fclose(x_re_file);
    $fclose(x_im_file);

    $finish;

end
endmodule
