
module complex_mult (
    input clk, 
    input reset,
    input logic signed [10:0] sig_modulated_fixed_real,
    input logic signed [10:0] sig_modulated_fixed_imag,
    input logic signed [10:0] demod_Lo_real,
    input logic signed [10:0] demod_Lo_imag,
    output logic signed [21:0] sig_baseband_real,
    output logic signed [21:0] sig_baseband_imag
);

logic signed [21:0] sig_baseband_next_real;
logic signed [21:0] sig_baseband_next_imag;


logic signed [21:0] real_first;
logic signed [21:0] real_second;

logic signed [21:0] imag_first;
logic signed [21:0] imag_second;

always_comb begin
    real_first = sig_modulated_fixed_real * demod_Lo_real;
    real_second = sig_modulated_fixed_imag * demod_Lo_imag;

    imag_first = sig_modulated_fixed_real * demod_Lo_imag;
    imag_second = sig_modulated_fixed_imag * demod_Lo_real;

    sig_baseband_next_real = real_first - real_second;
    sig_baseband_next_imag = imag_first + imag_second; 
    
end

always_ff @(posedge clk) begin
    if (reset) begin
        sig_baseband_real <= 0;
        sig_baseband_imag <= 0;
    end
    else begin
        sig_baseband_real <= sig_baseband_next_real;
        sig_baseband_imag <= sig_baseband_next_imag;
    end
end
endmodule
