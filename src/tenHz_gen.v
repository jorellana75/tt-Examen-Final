`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2024 21:43:23
// Design Name: 
// Module Name: tenHz_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tenHz_gen(
    input clk,
    input rst_n,
    output clk_10Hz
    );
    
    reg [22:0] ctr_reg = 0; //23 bits to cover 5,000,000
    reg clk_out_reg = 0;
    
    always @(posedge clk or posedge rst_n)
        if(rst_n) begin
            ctr_reg <= 0;
            clk_out_reg <= 0;
        end
        else
            if(ctr_reg == 4_999_999) begin  //100MHz /10Hz / 2 = 5,000,000
                ctr_reg <= 0;
                clk_out_reg <= ~clk_out_reg;
            end
            else    
                ctr_reg <= ctr_reg + 1;
                
                
      assign clk_10Hz = clk_out_reg;
      
endmodule
