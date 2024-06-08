`timescale 1ns / 1ps

module clck_psc (
    input wire CLK100MHZ,
    output reg LED0
);
    reg [13:0] contador;  // Contador de 14 bits

    // Siempre aumenta el contador en cada flanco de subida del reloj
    always @(posedge CLK100MHZ) begin
        contador <= contador + 1;
    end

    // LED0 se activa cada 10 kHz (100 MHz / 10000)
    assign LED0 = contador[13];  // Divisor para obtener 10 kHz
endmodule

