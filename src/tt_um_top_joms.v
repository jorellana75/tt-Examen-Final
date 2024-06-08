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

module tt_um_top_joms(
    input wire clk,
    //input wire CLK100MHZ,
    //input wire MISO,
    //input reset,
    input wire rst_n,
    input wire ena,
    input wire [7:0] ui_in,
    input wire [7:0] uio_in,
    output wire [7:0] uo_out,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    //output wire MOSI,
    //output wire SCK,
    //output wire CS,
    //output wire led_b,
    //output wire led_g,
    //output wire led_clk,
    //output clk,
    //output wire [0:6] seg,
    //output wire [3:0] digit
    );

    //reg [7:0] ui_in;
    //reg [7:0] uio_in;
    //wire [7:0] uo_out;
    //wire [7:0] uio_out;
    //wire [7:0] uio_oe;

    wire [11:0]w_DATA;
    wire w_DATA_VALID;
    wire internal_psc_clock;
    wire w_10Hz;
    wire [3:0] w_1s, w_10s, w_100s, w_1000s;
    
    clck_psc contador((CLK100MHZ), (internal_psc_clock));
    
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
    .reset(rst_n),  
    .clk_10Hz(w_10Hz)
    );
    
    digits digs(
    .clk_10Hz(w_10Hz), 
    .reset(rst_n),  
    .ones(w_1s), 
    .tens(w_10s), 
    .hundreds(w_100s), 
    .thousands(w_1000s));
    
    seg7_control seg7(
    .clk_100MHz(CLK100MHZ), 
    .reset(rst_n), 
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
