module my_controller (
    input clk,             
    input reset,            
    input [7:0] period,     
    output logic signed [11:0] control  
);
    logic [7:0] half_period;      
    logic [9:0] counter;
    logic state;             

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 8'd0;
            state <= 0;
            half_period <= period >> 1; 
        end else begin
            if ((counter/100) < half_period) begin
                counter <= counter + 1;
            end else begin
                counter <= 8'd1;    
                state <= ~state;       
            end
        end
    end
   
    assign control = state ?  12'd94 : 12'd12; //2.3 MHz = 94, 0.3MHz = 12

endmodule
