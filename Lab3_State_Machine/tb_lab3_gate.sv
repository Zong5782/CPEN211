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
`define blank    7'b1111111



`timescale 1 ps/ 1 ps

module tb_lab3_gate(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
	input reg [9:0] SW;
	input reg [3:0] KEY;
	output wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output wire [9:0] LEDR;
	
	lab3_top DUT(SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);

	initial begin  // set up the clock
			KEY[0] = 1; #5;
		forever begin
			KEY[0] = 0; #5;
			KEY[0] = 1; #5;
		end
	end


	task my_checker;  // set up the task for checking the output of ledr
	input [9:0] expected_output;
		begin
			if( LEDR !== expected_output)begin
				$display("ERROR ** output is %b, expected %b", LEDR, expected_output);
			end
		end
	endtask

	initial begin
    		KEY[3] = 1'b0; // reset t0 state_0
		SW = `bin_0;  // set all SWs to off
		#10;
    		my_checker(`bin_0);
    		KEY[3] = 1'b1; // de-assert reset
		
		//Testing S1 to S6
     		$display("checking State_0->State_1");
    		SW = `bin_8; #10;
    		my_checker(`bin_1);

    		$display("checking State_1->State_2");
    		SW = `bin_2; #10; 
    		my_checker(`bin_2);

    		$display("checking State_2->State_3");
    		SW = `bin_5; #10; 
    		my_checker(`bin_3);

    		$display("checking State_3->State_4");
    		SW = `bin_4; #10; 
    		my_checker(`bin_4);

    		$display("checking State_4->State_5");
    		SW = `bin_3; #10; 
    		my_checker(`bin_5);

    		$display("checking State_5->State_6");
    		SW = `bin_2; #10; 
    		my_checker(`bin_6);

    		$display("checking State_6->State_6");
    		SW = `bin_0; #10; 
    		my_checker(`bin_6);


		// Testing S7 to S12
	    	KEY[3] = 1'b0; 
		SW = `bin_0; #10;
    		my_checker(`bin_0);
    		KEY[3] = 1'b1; // de-assert reset
			
    		$display("checking State_0->State_7");
    		SW = `bin_1; #10; 
    		my_checker(`bin_7);

    		$display("checking State_7->State_8");
    		SW = `bin_2; #10; 
    		my_checker(`bin_8);

    		$display("checking State_8->State_9");
    		SW = `bin_3; #10; 
    		my_checker(`bin_9);

    		$display("checking State_9->State_10");
    		SW = `bin_4; #10; 
    		my_checker(`bin_10);

    		$display("checking State_10->State_11");
    		SW = `bin_5; #10; 
    		my_checker(`bin_11);

    		$display("checking State_11->State_12");
    		SW = `bin_6; #10; 
    		my_checker(`bin_12);

    		$display("checking State_12->State_12");
    		SW = `bin_7; #10; 
    		my_checker(`bin_12);


		// Testing S1 to S8
    		KEY[3] = 1'b0; 
		SW = `bin_0; #10;
    		KEY[3] = 1'b1; // de-assert reset
		$display("checking State_1->State_8");
    		SW = `bin_8; #10;  // State_0->State_1
    		my_checker(`bin_1);
    		SW = `bin_0; #10;  // State_1->State_8
    		my_checker(`bin_8);


	
		// Testing S2 to S9
		KEY[3] = 1'b0; 
		SW = `bin_0; #10;
    		KEY[3] = 1'b1; // de-assert reset
     		$display("checking State_2->State_9");
    		SW = `bin_8; #10;
    		my_checker(`bin_1);  // State_0->State_1
    		SW = `bin_2; #10; 
    		my_checker(`bin_2);  // State_1->State_2
    		SW = `bin_0; #10; 
    		my_checker(`bin_9);  // State_2->State_9


		// Testing S3 to S10
		KEY[3] = 1'b0; 
		SW = `bin_0;  #10;
    		my_checker(`bin_0);
    		KEY[3] = 1'b1; // de-assert reset
		$display("checking State_3->State_10");
    		SW = `bin_8; #10; 
    		my_checker(`bin_1);    // State_0->State_1
    		SW = `bin_2; #10; 
    		my_checker(`bin_2);    // State_1->State_2
    		SW = `bin_5; #10; 
    		my_checker(`bin_3);    // State_2->State_3
    		SW = `bin_0; #10; 
    		my_checker(`bin_10);  // State_3->State_10

		
		// Tesing S4 to S11
		KEY[3] = 1'b0; 
		SW = `bin_0; #10;
    		my_checker(`bin_0);
    		KEY[3] = 1'b1; // de-assert reset
		$display("checking State_4->State_11");
    		SW = `bin_8;#10; 
    		my_checker(`bin_1);   // State_0->State_1
    		SW = `bin_2; #10; 
    		my_checker(`bin_2);   // State_1->State_2
    		SW = `bin_5; #10; 
    		my_checker(`bin_3);   // State_2->State_3
    		SW = `bin_4; #10; 
    		my_checker(`bin_4);   // State_3->State_4	
    		SW = `bin_0; #10; 
    		my_checker(`bin_11); // State_4->State_11


		// Testing S5 to S12
		KEY[3] = 1'b0; 
		SW = `bin_0; #10;
    		my_checker(`bin_0);
    		KEY[3] = 1'b1; // de-assert reset
		$display("checking State_5->State_12");
    		SW = `bin_8; #10; 
    		my_checker(`bin_1); //State_0->State_1 
    		SW = `bin_2; #10; 
    		my_checker(`bin_2); // State_1->State_2
    		SW = `bin_5; #10; 
    		my_checker(`bin_3); // State_2->State_3 
    		SW = `bin_4; #10; 
    		my_checker(`bin_4); // State_3->State_4
    		SW = `bin_3; #10;
    		my_checker(`bin_5);  // State_4->State_5
    		SW = `bin_0; #10;
    		my_checker(`bin_12);  // State_5->State_12
		

		$stop;
	end

endmodule: tb_lab3_gate

