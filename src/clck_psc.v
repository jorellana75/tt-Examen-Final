`timescale 1ns / 1ps
    
//endmodule

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
