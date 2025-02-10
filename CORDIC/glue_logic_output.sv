module glue_logic_output (
    input clk, reset,
    input logic signed [15:0] x_in_cordic, //should be A due to vectoring, dont even need it tbh
    input logic signed [17:0] z_in_cordic, //should be theta due to vectoring
    input logic [2:0] quadrant_in,
    output logic signed [17:0] theta, //should be in (18,14) representation
    output logic signed [15:0] amplitude
);

logic signed [17:0] theta_comb;
//localparam signed PI = 32767; //needs to be in (16,14) representation
localparam signed PI = 51472; //in (18,14) representation

always_ff @(posedge clk) begin
    if (reset) begin
        theta <= 0;
        amplitude <= 0;
    end
    else begin
        theta <= theta_comb;
        amplitude <= x_in_cordic;
    end
end
 
always_comb begin
    case (quadrant_in)
        3'd1: begin //first quadrant, same
            theta_comb = z_in_cordic;
        end
        3'd2: begin //second quadrant, need to apply +pi/2
            theta_comb = z_in_cordic + PI/2;
        end
        3'd3: begin //third quadrant, need to apply -pi
            theta_comb = z_in_cordic - PI; //add PI maybe? was - PI before
        end
        3'd4: begin //fourth quadrant, need to apply -pi/2
            theta_comb = z_in_cordic - PI/2; //add 3pi/2 maybe?, was -PI/2 before
        end

    endcase
end

endmodule
