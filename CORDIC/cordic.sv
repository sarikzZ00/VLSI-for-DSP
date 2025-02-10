module cordic #(parameter MODE = 1) (

    input logic clk,
    input logic reset,
    input logic signed [15:0] x_in,
    input logic signed [15:0] y_in,
    input logic signed [17:0] z_in,
    input logic [2:0] quadrant_in,

    output logic signed [15:0] x_out,
    output logic signed [15:0] y_out,
    output logic signed [17:0] z_out,
    output logic [2:0] quadrant_out

);

    logic signed [17:0] arctan_LUT [14:0];

      assign arctan_LUT[0] = 12867;  
      assign arctan_LUT[1] = 7596;
      assign arctan_LUT[2] = 4013;   
      assign arctan_LUT[3] = 2037;   
      assign arctan_LUT[4] = 1022;  
      assign arctan_LUT[5] = 511;    
      assign arctan_LUT[6] = 255;   
      assign arctan_LUT[7] = 127;   
      assign arctan_LUT[8] = 63;    
      assign arctan_LUT[9] = 31;     
      assign arctan_LUT[10] = 15;   
      assign arctan_LUT[11] = 7;  
      assign arctan_LUT[12] = 3;     
      assign arctan_LUT[13] = 1;    
      assign arctan_LUT[14] = 0;    

    //Main logic

    logic signed [17:0] x_comb [14:0];
    logic signed [17:0] y_comb [14:0];
    logic signed [17:0] z_comb [14:0];
    logic [2:0] quadrant_comb [14:0];

    logic signed [15:0] x_next [14:0];
    logic signed [15:0] y_next [14:0]; 
    logic signed [17:0] z_next [14:0];
    logic [2:0] quadrant_next [14:0];

    logic signed [1:0] sigma [14:0];

    logic signed [15:0] x_shift[14:0];
    logic signed [15:0] y_shift[14:0];

    

    
    always_comb begin  //Main logic
        x_comb[0] = x_in;
        y_comb[0] = y_in;
        z_comb[0] = z_in;
        quadrant_comb[0] = quadrant_in;

        for (int i = 0; i < 15; i++) begin
            if (MODE == 0) begin //for rotation
                if (z_next[i] >= 0) begin 
                    sigma[i] = 1;
                end
                else sigma[i] = -1;
            end
            else begin //for vectoring
                if (y_next[i] < 0) begin
                    sigma[i] = 1;
                end
                else sigma[i] = -1;
            end
            x_shift[i] = x_next[i] >>> i;
            y_shift[i] = y_next[i] >>> i;
            x_comb[i+1] = x_next[i] - sigma[i] * (y_shift[i]);
            y_comb[i+1] = y_next[i] + sigma[i] * (x_shift[i]);
            z_comb[i+1] = z_next[i] - sigma[i] * arctan_LUT[i];
            quadrant_comb[i+1] = quadrant_next[i];
        end

    end

    //Output assignment
    assign x_out = x_next[14];
    assign y_out = y_next[14];
    assign z_out = z_next[14];
    assign quadrant_out = quadrant_next[14];

    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 15; i++) begin
                x_next[i] <= 0;
                y_next[i] <= 0;
                z_next[i] <= 0;
            end
        end 
        
        else begin
            for (int i = 0; i < 15; i++) begin
                x_next[i] <= x_comb[i];
                y_next[i] <= y_comb[i];
                z_next[i] <= z_comb[i];
                quadrant_next[i] <= quadrant_comb[i];
            end
        end
    end



endmodule
