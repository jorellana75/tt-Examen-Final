`timescale 1ns / 1ps

module clck_psc (
    input wire CLK100MHZ,
    output reg LED0
);
    reg [13:0] contador;  // Contador de 14 bits

    // Siempre aumenta el contador en cada flanco de subida del reloj
    always @(posedge CLK100MHZ) begin
        contador <= contador + 1;
        LED0 <= contador[13];  // Asignación de LED0 dentro del bloque always
    end

endmodule
