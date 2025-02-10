module Top (
    input clk, reset,
    input logic signed [15:0] x_re,
    input logic signed [15:0] x_im,
    output logic signed [17:0] f_inst
);
//input glue logic instantiation
logic signed [15:0] x_into_cordic;
logic signed [15:0] y_into_cordic;
logic signed [17:0] z_into_cordic;
logic [2:0] quadrant_into_cordic;
glue_logic_input glue_in (
    .x_re(x_re),
    .x_im(x_im),
    .z_in(0),
    .x_out_cordic(x_into_cordic),
    .y_out_cordic(y_into_cordic),
    .z_out_cordic(z_into_cordic),
    .quadrant_out(quadrant_into_cordic)
);
//////////////////////////////////////////

//CORDIC Vectoring instantiation
logic signed [15:0] x_out_cordic;
logic signed [15:0] y_out_cordic;
logic signed [17:0] z_out_cordic;
logic signed [2:0] quadrant_out_cordic;
cordic #(.MODE(1)) cordic_vectoring (
    .clk(clk),
    .reset(reset),
    .x_in(x_into_cordic),
    .y_in(y_into_cordic),
    .z_in(z_into_cordic),
    .quadrant_in(quadrant_into_cordic),
    .x_out(x_out_cordic),
    .y_out(y_out_cordic),
    .z_out(z_out_cordic),
    .quadrant_out(quadrant_out_cordic)
);
//////////////////////////////////////////

//output glue logic instantiation
logic signed [17:0] theta;
logic signed [17:0] amplitude;
glue_logic_output glue_out (
    .clk(clk),
    .reset(reset),
    .x_in_cordic(x_out_cordic),
    .z_in_cordic(z_out_cordic),
    .quadrant_in(quadrant_out_cordic),
    .theta(theta),
    .amplitude(amplitude)
);
///////////////////////////////////////////

//delta phase instantiation 
logic signed [17:0] delta_theta;
delta_phase delta_phase_inst (
    .clk(clk),
    .reset(reset),
    .theta(theta),
    .delta_theta(delta_theta)
);
////////////////////////////////////////////

//wrap delta phase instantiation

wrap_delta_phase wrap_inst (
    //.clk(clk),
    //.reset(reset),
    .delta_theta(delta_theta),
    .f_inst(f_inst)
);

endmodule
