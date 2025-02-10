module top_module (
    input clk,
    input reset,
    input [7:0] period,
    output logic signed [7:0] my_sine_out,
    output logic signed [7:0] my_cosine_out
);
    logic [11:0] control;

    // Instantiate controller
    my_controller controller (
        .clk(clk),
        .reset(reset),
        .period(period),
        .control(control)
    );

    // Instantiate waveform generator
    my_waveform_gen waveform_gen (
        .clk(clk),
        .reset(reset),
        .control(control),
        .my_sine_out(my_sine_out),
        .my_cosine_out(my_cosine_out)
    );
endmodule
