

module top_level (
    input clk480, clk16, reset,
    input logic signed [10:0] sig_modulated_fixed_real,
    input logic signed [10:0] sig_modulated_fixed_imag,
    
    input logic signed [10:0] demod_Lo_real,
    input logic signed [10:0] demod_Lo_imag,

    output logic signed [61:0] sig_demod_30_real,
    output logic signed [61:0] sig_demod_30_imag
);

//signals for complex_mult
logic signed [21:0] sig_baseband_real;
logic signed [21:0] sig_baseband_imag;
//complex mult inst
complex_mult mult (.*, .clk(clk480));

//signal for LPF
logic signed [61:0] filter_sig_real;
logic signed [61:0] filter_sig_imag;
//LPF inst
LPF lpf (.*, .clk(clk480));

//down_sample inst
DS down_sample (.*, .clk(clk16));

endmodule
