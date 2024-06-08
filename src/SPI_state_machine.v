`timescale 1ns / 1ns

module SPI_state_machine(
	input clk,
	//input clk10,
	input MISO,                // data out of ADC (Dout pin)
	output MOSI,               // Data into ADC (Din pin)
	output SCK, 	           // SPI clock
	output [11:0] o_DATA,      // 12 bit word (for other modules)
	output CS,                 // Chip Select
	output led2,
	output DATA_VALID          // is high when there is a full 12 bit word. 
	);
	
	// set up bits for MOSI (DIN on datasheet) 
	localparam START = 1;      // start bit
	localparam SGL = 1;        // sets ADC to single ended mode 
	localparam ODD = 1;        // sets sample input to channel 1
	localparam MSBF = 1;       // sets ADC to transmit MSB first
	
	// states
	localparam INITIALIZE = 0;      // initialize the state machine
	localparam DISABLE = 1;         // CS is high
	localparam TRANSMITTING = 2;    // set the sample channel, sampling mode, etc...
	localparam RECEIVING = 3;       // convert the bitstream into parellel word
	
	reg d_led;
	reg [7:0] SCK_counter = 0;       // for the output SPI clock
	reg r_MOSI = 0; 
	reg [11:0] r_DATA;
	reg [1:0] r_STATE;               // state machine
	reg r_CS = 1;       	         // disable CS to start
	reg r_SCK_enable = 0;            // enable for SCK
	reg r_DV = 0;                    // DATA_VALID register
	reg [11:0] sample_counter = 1;   // this counter flips over after one sample period
	                                      // it starts at one so INITIALIZE waits one sampling period to begin DISABLE
	 
	// sample_counter
	always @ (posedge clk)                       
		begin 
			if (sample_counter <=3116)           // this number depends on sampling rate and mode. 
				begin 
					sample_counter <= sample_counter + 1;
				end 
			else 
				begin 
					sample_counter <= 0;
				end 
		end   // end sample_counter
		
	// SPI_CLK
	always @ (posedge clk)
		begin 
			if (r_SCK_enable ==1 && r_STATE !== INITIALIZE && SCK_counter <= 174)
				begin 
					SCK_counter <= SCK_counter + 1;
				end 
			else if (r_SCK_enable ==1 && r_STATE !== INITIALIZE)
				begin 
					SCK_counter <= 0;
				end 
			else 
				begin 
					SCK_counter <= 0;
				end 
		end 
	assign SCK = (SCK_counter <= 87) ? 0:1;      // 50% duty cycle PWM/SPI clock 
		
		
	// State machine	
	always @ (posedge clk)
		begin 
			case (r_STATE)
				
				INITIALIZE:                //this just makes the whole process wait a bit
					begin 
						r_CS <= 1;
						r_SCK_enable <= 0;
						r_MOSI <= 0;
						r_DV <= 0;
							if (sample_counter == 3116)    // makes INITIALIZE wait a whole sampling period for set up 
								begin 
									r_STATE <= DISABLE;
									r_DV <= 1;
								end
							else 
								begin 
									r_STATE <= INITIALIZE;
								end
					end   // end INITIALIZE
					
				
				
				DISABLE:              
					begin 
						r_CS <= 1;
						r_SCK_enable <= 0;
						r_MOSI <= 0;
						r_DV <= 0;
							if (sample_counter == 124)     // ensures that DISABLE waits 125 counts or 1000 ns (check tcsh in datasheet)
								begin 
									r_STATE <= TRANSMITTING;
									r_CS <= 0;                       // CS pulled low, activates sampling
						            r_SCK_enable <= 1;
						            r_MOSI <= START;
								end
							else
								begin 
									r_STATE <= DISABLE;
								end
					end     // end DISABLE 
					
					
				TRANSMITTING:
					begin 
						r_CS <= 0;                       // CS pulled low, activates sampling
						r_SCK_enable <= 1;
						r_MOSI <= START;
						r_DV <= 0;
							if (sample_counter == 300)
								begin 
									r_MOSI <= SGL;        // provides set up data to ADC depending on the timing
								end
							if (sample_counter == 476)
								begin 
									r_MOSI <= ODD;
								end
							if (sample_counter == 652)
								begin 
									r_MOSI <= MSBF;
								end
							if (sample_counter == 828 && r_MOSI == MSBF)
								begin 
									r_STATE <= RECEIVING;
								end
							else 
								begin 
									r_STATE <= TRANSMITTING;
								end
					end    // end TRANSMITTING
					
					
				RECEIVING: 
					begin 
						r_CS <= 0;                       
						r_SCK_enable <= 1;
						r_MOSI <= 1; 						// MOSI is "don't care" in this state
							if (sample_counter == 1092)     // waits 1.5 SCK cycle after MSBF bit because MISO transmitts null bit (MUST SAMPLE AT MIDPOINT OF BIT)
								begin 
									r_DATA[11] <= MISO;
									r_DV <= 0;
									d_led <= 1;
									
									
								end
							if (sample_counter == 1268)
								begin 
									r_DATA[10] <= MISO;
									r_DV <= 0;
									d_led <= 0;
								end 
							if (sample_counter == 1444)
								begin 
									r_DATA[9] <= MISO;
									r_DV <= 0;
									d_led <= 1;
								end 
							if (sample_counter == 1620)
								begin 
									r_DATA[8] <= MISO;
									r_DV <= 0;
									d_led <= 0;
								end 
							if (sample_counter == 1796)
								begin 
									r_DATA[7] <= MISO;									
									r_DV <= 0;
								end 
							if (sample_counter == 1972)
								begin 
									r_DATA[6] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 2148)
								begin 
									r_DATA[5] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 2326)
								begin 
									r_DATA[4] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 2500)
								begin 
									r_DATA[3] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 2676)
								begin 
									r_DATA[2] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 2852)
								begin 
									r_DATA[1] <= MISO;
									r_DV <= 0;
								end 
							if (sample_counter == 3028)
								begin 
									r_DATA[0] <= MISO;
									r_DV <= 1;                     // Data is now valid
								end 
							if (sample_counter == 3116)
								begin 
									r_STATE <= DISABLE;
								end 
							else 
								begin 
									r_STATE <= RECEIVING;
								end 
					end // end RECEIVING	
								
						
					
					
				default: 
					begin 
						r_STATE <= INITIALIZE;
					end 
					
					
			endcase
		end	
	
	assign CS = r_CS;                  // output signals
	assign MOSI = r_MOSI;
	assign o_DATA = r_DATA;  
	assign DATA_VALID = r_DV; 
	assign led2 = d_led;

		
endmodule
 
 		





