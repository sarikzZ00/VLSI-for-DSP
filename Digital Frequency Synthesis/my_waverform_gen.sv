module my_waveform_gen (
    input clk,
    input reset,
    input [11:0] control,      
    output logic signed [7:0] my_sine_out,   
    output logic signed [7:0] my_cosine_out  
);
 
    logic [11:0] control_next; 
    logic [7:0] cos_index;
    logic [7:0] sin_index;
    
    // cosine LUT
    cosine_LUT cos_lut (
        .phase(cos_index),
        .cosine_value(my_cosine_out)
    );

    // 90 phase = 64
    assign sin_index = cos_index + 8'd64;
    cosine_LUT sin_lut (
        .phase(sin_index),
        .cosine_value(my_sine_out)
    );

    always_ff @(posedge clk or posedge reset) begin
        if (!reset) begin
            control_next <= control_next + control;
            cos_index <= control_next[11:4]; 
        end
        else begin
            control_next <= 0;
            cos_index <= 0;
        end
    end
endmodule
