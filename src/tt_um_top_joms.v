`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2024 19:23:53
// Design Name: 
// Module Name: top
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

//import chardet
module tt_um_top_joms(
    //input clk,
    input CLK100MHZ,
    input MISO,
    input reset,
    output MOSI,
    output SCK,
    output CS,
    output led_b,
    output led_g,
    output led_clk,
    output clk,
    output [0:6] seg,
    output [3:0] digit
    );
    
    wire [11:0]w_DATA;
    wire w_DATA_VALID;
    wire internal_psc_clock;
    wire w_10Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    
    clck_psc my_clk((CLK100MHZ), (internal_psc_clock));
    
    SPI_state_machine s1(
    .clk(internal_psc_clock),
    .MISO(MISO),
    .MOSI(MOSI),
    .SCK(SCK),
    .o_DATA(w_DATA),
    .CS(CS),
    .DATA_VALID(w_DATA_VALID) 
    );
    
    LED_TEST l1(
    .clk(internal_psc_clock),
    .DATA_VALID(w_DATA_VALID),
    .DATA(w_DATA),
    .led_b(led_b),
    .led_g(led_g)
    );
    
 
    tenHz_gen hz10(
    .clk_100MHz(CLK100MHZ), 
    .reset(reset), 
    .clk_10Hz(w_10Hz)
    );
    
    digits digs(
    .clk_10Hz(w_10Hz), 
    .reset(reset), 
    .ones(w_1s), 
    .tens(w_10s), 
    .hundreds(w_100s), 
    .thousands(w_1000s));
    
    seg7_control seg7(
    .clk_100MHz(CLK100MHZ), 
    .reset(reset), 
    .ones(w_1s), 
    .tens(w_10s),
    .hundreds(w_100s), 
    .thousands(w_1000s), 
    .seg(seg), 
    .digit(digit)
    );
    
   assign led_clk = internal_psc_clock;
   assign clk = internal_psc_clock;
    
endmodule
