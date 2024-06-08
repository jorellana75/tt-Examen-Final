`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2024 21:01:05
// Design Name: 
// Module Name: LED_TEST
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


// module LED_TEST(
//    input clk,
//    input DATA_VALID,
//    input[11:0] DATA,
//    output led_b,
//    output led_g
//    );
     
//    reg r_green, r_blue;
    
//    always @(posedge clk)
//        begin
//            if (DATA <= 12'b100000000000)
//                begin
//                    r_blue <=1;
//                    r_green <= 0;
//                end
//            else
//                begin
//                    r_blue <=0;
//                    r_green <=1;
//                end
//       end
       
//    assign led_b = r_blue;
//    assign led_g = r_green;
    
// endmodule 
module LED_TEST(
    input clk,
    input DATA_VALID,
    input [11:0] DATA,
    output led_b,  // Cambiado a reg para ser conducido por un reg
    output led_g   // Cambiado a reg para ser conducido por un reg
    );
     
    reg r_green, r_blue;
    
    always @(posedge clk)
    begin
        if (DATA_VALID)  // Asegurarse de que los datos son válidos antes de procesar
        begin
            if (DATA <= 12'b100000000000)  // Comparar con 2048 (1.65V)
            begin
                r_blue <= 1;
                r_green <= 0;
            end
            else
            begin
                r_blue <= 0;
                r_green <= 1;
            end
        end
    end
    
    assign led_b = r_blue;
    assign led_g = r_green;
    
endmodule





