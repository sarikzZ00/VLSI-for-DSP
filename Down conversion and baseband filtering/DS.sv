//down sample by 30, done in the testbench
module DS (
    input clk, reset,
    input logic signed [61:0] filter_sig_real,
    input logic signed [61:0] filter_sig_imag,
    output logic signed [61:0] sig_demod_30_real,
    output logic signed [61:0] sig_demod_30_imag
);

    always_ff @(posedge clk) begin
        if (reset) begin
            sig_demod_30_real <=0;
            sig_demod_30_imag <= 0;
        end
        else begin
            sig_demod_30_real <= filter_sig_real;
            sig_demod_30_imag <= filter_sig_imag;
        end
    end


endmodule
