module delta_phase (
    input clk, reset,
    input logic signed [17:0] theta,
    output logic signed [17:0] delta_theta
);
//Register previous angle
logic signed [17:0] theta_prev;
always_ff @(posedge clk) begin
    if (reset) begin
        theta_prev <= 0;
        delta_theta <= 0;
    end
    else begin
        delta_theta <= theta - theta_prev;
        theta_prev <= theta;
        //delta_theta <= theta - theta_prev;
    end
end

//Output

//assign delta_theta = theta - theta_prev;

endmodule
