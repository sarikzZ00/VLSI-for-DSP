module LPF (
    input clk, reset,
    input logic signed [21:0] sig_baseband_real,
    input logic signed [21:0] sig_baseband_imag,
    output logic signed [61:0] filter_sig_real,
    output logic signed [61:0] filter_sig_imag 
);

logic signed [9:0] Filter_tap_LUT [0:31]; 
// these values were obtained from float to fixed func developed in HW1
always_comb begin
    Filter_tap_LUT[0] = 2;
    Filter_tap_LUT[1] = 2;
    Filter_tap_LUT[2] = 3;
    Filter_tap_LUT[3] = 3;
    Filter_tap_LUT[4] = 3;
    Filter_tap_LUT[5] = 4;
    Filter_tap_LUT[6] = 4;
    Filter_tap_LUT[7] = 4;
    Filter_tap_LUT[8] = 4;
    Filter_tap_LUT[9] = 5;
    Filter_tap_LUT[10] = 5;
    Filter_tap_LUT[11] = 5;
    Filter_tap_LUT[12] = 5;
    Filter_tap_LUT[13] = 5;
    Filter_tap_LUT[14] = 5;
    Filter_tap_LUT[15] = 5;
    Filter_tap_LUT[16] = 5;
    Filter_tap_LUT[17] = 5;
    Filter_tap_LUT[18] = 5;
    Filter_tap_LUT[19] = 5;
    Filter_tap_LUT[20] = 5;
    Filter_tap_LUT[21] = 5;
    Filter_tap_LUT[22] = 5;
    Filter_tap_LUT[23] = 4;
    Filter_tap_LUT[24] = 4;
    Filter_tap_LUT[25] = 4;
    Filter_tap_LUT[26] = 4;
    Filter_tap_LUT[27] = 3;
    Filter_tap_LUT[28] = 3;
    Filter_tap_LUT[29] = 3;
    Filter_tap_LUT[30] = 2;
    Filter_tap_LUT[31] = 2;
end
//fir_real to out_real
//fir_imag to out_imag

//mult_acc_real to accum_real
//mult_acc_imag to accum_imag

logic signed [31:0] out_real [0:31];
logic signed [31:0] out_imag [0:31];



always_comb begin 
    for(int i = 0; i < 32; i++) begin
            out_real[i] = sig_baseband_real * Filter_tap_LUT[i];
            out_imag[i] = sig_baseband_imag * Filter_tap_LUT[i];
    end 
end

logic signed [61:0] accum_real [0:31];
logic signed [61:0] accum_imag [0:31];

logic signed [61:0] accum_real_next [0:31];
logic signed [61:0] accum_imag_next [0:31];

//if need to accumulate
always_comb begin
    for (int i = 0; i < 31; i++) begin
        accum_real_next[i] = accum_real[i+1]+out_real[i+1];
        accum_imag_next[i] = accum_imag[i+1]+out_imag[i+1];
    end
end

always_ff @(posedge clk) begin
    if(reset) begin
        for (int i =0; i<32; i++) begin
            accum_real[i] <= 0;
            accum_imag[i] <= 0;
        end
    end
    else begin
        for(int i = 0; i<31; i++) begin
            if(i != 30) begin
                accum_real[i] <= accum_real_next[i];
                accum_imag[i] <= accum_imag_next[i];
            end
            else begin
                accum_real[i] <= out_real[i+1]; //no need to accumulate on first
                accum_imag[i] <= out_imag[i+1];
            end
        end
    end

end
    //Output logic
    assign filter_sig_real = accum_real[0] + out_real[0];
    assign filter_sig_imag = accum_imag[0] + out_imag[0];



endmodule
