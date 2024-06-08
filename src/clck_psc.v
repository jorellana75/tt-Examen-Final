`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2024 15:42:02
// Design Name: 
// Module Name: clck_psc
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


//module clck_psc( 
//    input CLK100MHZ,
//    output LED0
//    );

//    reg [31:0] myreg;
    
//    always @(posedge CLK100MHZ)
//        myreg <= myreg + 1;
       
//    assign LED0 = myreg[26];
    
//endmodule
import chardet
module clck_psc(
    input CLK100MHZ,
    output LED0
    );

    reg [13:0] myreg;  // Contador de 14 bits
    
    always @(posedge CLK100MHZ) begin
        myreg <= myreg + 1;
    end
    
    assign LED0 = myreg[13];  // Divisor para obtener 10 kHz
    
endmodule








