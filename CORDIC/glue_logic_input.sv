module glue_logic_input  ( 
    input logic signed [15:0] x_re, //x + jy, 
    input logic signed [15:0] x_im,
    input logic signed [17:0] z_in, 
    output logic signed [15:0] x_out_cordic, 
    output logic signed [15:0] y_out_cordic, 
    output logic signed [17:0] z_out_cordic, 
    output logic [2:0] quadrant_out
);
always_comb begin
    z_out_cordic = z_in;
    case ({x_re[15], x_im[15]}) //checking the sign
        2'b00: begin //first quadrant, all good
            x_out_cordic = x_re;
            y_out_cordic = x_im;
            quadrant_out = 3'd1;
        end
        2'b01: begin //fourth quadrant, rotate by 90 degrees
            x_out_cordic = -x_im;
            y_out_cordic = x_re;
            quadrant_out = 3'd4;
        end
        2'b10: begin //second quadrant, rotate by -90 degrees
            x_out_cordic = x_im;
            y_out_cordic = -x_re;
            quadrant_out = 3'd2;
        end
        2'b11: begin //third quadrant, rotate by 180 degrees
            x_out_cordic = -x_re;
            y_out_cordic = -x_im;
            quadrant_out = 3'd3;
        end
  
    endcase
end


endmodule
