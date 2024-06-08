`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2024 21:53:06
// Design Name: 
// Module Name: digits
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

module digits(
    input clk_10Hz,
    input rst_n,
    output reg [3:0] ones,
    output reg [3:0] tens,
    output reg [3:0] hundreds,
    output reg [3:0] thousands
    );
    
    //ones reg control
    always @(posedge clk_10Hz or posedge reset)
        if(reset)
            ones <= 0;
        else
            if(ones == 9)
                ones <= 0;
            else
                ones <= ones + 1;
                
     //tens reg control
     always @(posedge clk_10Hz or posedge reset)
        if(reset)
            tens <= 0;
        else
            if(ones == 9)
                if(tens == 9)
                    tens <= 0;
                else
                    tens <= tens + 1;
                    
       //hundreds reg control
       always @(posedge clk_10Hz or posedge reset)
        if(reset)
            hundreds <= 0;
        else
            if(tens == 9 && ones == 9)
                if(hundreds == 9)
                    hundreds <= 0;
                else
                    hundreds <= hundreds + 1;
                    
        //thousands reg control
        always @(posedge clk_10Hz or posedge reset)
            if(reset)
                thousands <= 0;
            else 
                if(hundreds == 9 && tens == 9 && ones == 9)
                    if(thousands == 9)
                        thousands <= 0;
                    else
                        thousands <= thousands + 1;
                        
endmodule
