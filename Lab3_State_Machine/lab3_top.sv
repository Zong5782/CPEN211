
//State Machine
`define state_0  4'b0000
`define state_1  4'b0001
`define state_2  4'b0010
`define state_3  4'b0011
`define state_4  4'b0100
`define state_5  4'b0101
`define state_6  4'b0110
`define state_7  4'b0111
`define state_8  4'b1000
`define state_9  4'b1001
`define state_10 4'b1010
`define state_11 4'b1011
`define state_12 4'b1100
	
//Binary inputs
`define bin_0  10'b0000000000
`define bin_1  10'b0000000001
`define bin_2  10'b0000000010
`define bin_3  10'b0000000011
`define bin_4  10'b0000000100
`define bin_5  10'b0000000101
`define bin_6  10'b0000000110
`define bin_7  10'b0000000111
`define bin_8  10'b0000001000
`define bin_9  10'b0000001001
`define bin_10 10'b0000001010
`define bin_11 10'b0000001011
`define bin_12 10'b0000001100



//7-seg display for decimal number
`define display_0 7'b1000000
`define display_1 7'b1111001
`define display_2 7'b0100100
`define display_3 7'b0110000
`define display_4 7'b0011001
`define display_5 7'b0010010
`define display_6 7'b0000010
`define display_7 7'b1111000
`define display_8 7'b0000000
`define display_9 7'b0010000


//7-seg display for letters
`define letter_E 7'b0000110
`define letter_r 7'b0101111
`define letter_O 7'b1000000
`define letter_C 7'b1000110
`define letter_L 7'b1000111
`define letter_S 7'b0010010
`define letter_D 7'b1000000
`define letter_P 7'b0001100
`define letter_n 7'b0101011
//blank display
`define blank 7'b1111111

module vDFF(clk, in, out); // D filp-flop code
	parameter n = 1; //width
	input clk;
	input [n-1:0] in;
	output [n-1:0] out;
	reg [n-1:0] out;
  
	always_ff @(posedge clk) // clock
		out = in;
endmodule

module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;   // optional: use these outputs for debugging on your DE1-SoC

	wire clk = ~KEY[0];  // this is your clock
	wire rst_n = KEY[3]; // this is your reset; your reset should be synchronous and active-low

	wire [3:0] present_state, next_state_reset;
	reg [3:0] next_state;
	reg [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	reg [9:0] LEDR;


	vDFF #(4) STATE(clk, next_state_reset, present_state); // Use D filp-flop to output the present state.

	assign next_state_reset = rst_n ? next_state : `state_0; // If reset is 1 goes to the next state (rst here is a negative logic), else stays at the same state.


	always @(*)begin
		case(SW) //for showing the number, while using different combinations of switches on the board.
 			`bin_0:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_0};
 			`bin_1:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_1};
 			`bin_2:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_2};
 			`bin_3:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_3};
 			`bin_4:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_4};
 			`bin_5:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_5};
 			`bin_6:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_6};
 			`bin_7:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_7};
 			`bin_8:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_8};
 			`bin_9:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`blank,`blank,`blank,`display_9};

		default:{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`letter_E,`letter_r,`letter_r,`letter_O,`letter_r}; // the defalt case is error, when number > 9.
		endcase

		
		case (present_state) // this case show the sequential logic of a 12 states machine following the requirements.
		`state_0: begin
			
			if (SW == `bin_8)
				next_state = `state_1; // transition between states, if the condition is satisfied
			else
				next_state = `state_7; // transition between states, otherwise
		     end

		`state_1: begin
		       	
		      	if (SW == `bin_2)
		        next_state = `state_2; 
		       	else
		      	next_state = `state_8;  
		     end

		`state_2: begin
		       
		       if (SW == `bin_5)
		       next_state = `state_3;  
		       else
		       next_state = `state_9;  
		     end

		`state_3: begin
		 
		       if (SW == `bin_4)
		       next_state = `state_4;
		       else
		       next_state = `state_10;
		     end

		`state_4: begin
		   	
	    	  	if (SW == `bin_3)
	   	    	next_state = `state_5;
   		  	else
   		    	next_state = `state_11; 
		     end

		`state_5: begin
   		    	
   		    	if (SW == `bin_2)
			next_state = `state_6;
			else
		        next_state = `state_12;
		     end

		`state_6: begin
			next_state = `state_6;
			{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`blank,`blank,`letter_O,`letter_P,`letter_E,`letter_n}; // output open
			end

		`state_7: next_state = `state_8;

		`state_8: next_state = `state_9;

		`state_9: next_state = `state_10;

		`state_10: next_state = `state_11;

		`state_11: next_state = `state_12;

		`state_12: begin
			next_state = `state_12;
			{HEX5,HEX4,HEX3,HEX2,HEX1,HEX0} = {`letter_C,`letter_L,`letter_O,`letter_S,`letter_E,`letter_D}; // output closed
			end

		default: next_state = `state_0; // default state at state 0
		endcase

	case(present_state) // used for showing the present state on the board and test bench for gate level or rtl

		`state_0:  LEDR = 10'b0000000000;
		`state_1:  LEDR = 10'b0000000001;
		`state_2:  LEDR = 10'b0000000010;
		`state_3:  LEDR = 10'b0000000011;
		`state_4:  LEDR = 10'b0000000100;
		`state_5:  LEDR = 10'b0000000101;
		`state_6:  LEDR = 10'b0000000110;
		`state_7:  LEDR = 10'b0000000111;
		`state_8:  LEDR = 10'b0000001000;
		`state_9:  LEDR = 10'b0000001001;
		`state_10: LEDR = 10'b0000001010;
		`state_11: LEDR = 10'b0000001011;
		`state_12: LEDR = 10'b0000001100;

		default: LEDR = {10*{1'bx}};
	endcase
end
endmodule
