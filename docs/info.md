<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

El proyecto consiste en la comunicación serial SPI utilizando la Basys 3 y el integrado MCP3208. El MCP3208 es un convertidor analógico a digital (ADC) de 12 bits con 8 canales, el cual se comunica con otros dispositivos por medio de la interfaz serial con protocolo SPI. El proyecto en sí, se basa en que el MCP3208 comparará distintos voltajes que se le ingresen, y, dependiendo el valor, en este caso si es menor a 2.5 V encenderá el LED de la placa E19, y se el voltaje es mayor a 2.5 V, se encenderá el LED de la placa U19.

A esto, se le agregó la funcionalidad adicional de un contador en el display de 7 segmentos que ya se encuentra en la placa Basys 3. 

## How to test

Se deberá asignar un voltaje diferente a la línea del canal 0 (CH0) del MCP3208, para que así este pueda comparar los voltajes y realizar la acción especificada en el código.

## External hardware

- Integrado MCP320
- Fuente de poder de 5 a 12 V
- Protoboards
- Placa Basys 3
