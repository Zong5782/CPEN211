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



module tb_lab3;
	reg [9:0] sim_SW;
	reg [3:0] sim_KEY;
	reg err;
	wire [6:0] sim_HEX0,sim_HEX1,sim_HEX2,sim_HEX3,sim_HEX4,sim_HEX5;
	wire [9:0] sim_LEDR;
	
	lab3_top DUT(sim_SW,sim_KEY,sim_HEX0,sim_HEX1,sim_HEX2,sim_HEX3,sim_HEX4,sim_HEX5,sim_LEDR);

	initial begin   // set up the clock as netagive posedge triggered
		sim_KEY[0] = 1; #5;
		forever begin
			sim_KEY[0] = 0; #5;
			sim_KEY[0] = 1; #5;
		end
	end


	task my_checker; // set up a task to evaluate each condition / state
	input [3:0] expected_state;
	input [9:0] expected_output;
		begin
			if(tb_lab3.DUT.present_state !== expected_state) begin
				$display("ERROR ** state is %b, expected %b", tb_lab3.DUT.present_state, expected_state); // inside the lab3_top
				err = 1'b1; // print the error.
			end
			if(sim_LEDR !== expected_output)begin
				$display("ERROR ** output is %b, expected %b", sim_LEDR, expected_output); // only related to the out put
				err = 1'b1;
			end
		end
	endtask

	initial begin
    		sim_KEY[3] = 1'b0; //reset the state
		sim_SW = `bin_0;  // set all sw to 0
		err = 1'b0;  // set err to 0
		#10;  // delay
    		my_checker(`state_0, `bin_0);
    		sim_KEY[3] = 1'b1; // de-assert reset
		
		//Testing S1 to S6
     		$display("checking State_0->State_1"); // test name
    		sim_SW = `bin_8; #10; // input is binary number 8 
    		my_checker(`state_1, `bin_1);

    		$display("checking State_1->State_2");
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_2, `bin_2);

    		$display("checking State_2->State_3");
    		sim_SW = `bin_5; #10; 
    		my_checker(`state_3, `bin_3);

    		$display("checking State_3->State_4");
    		sim_SW = `bin_4; #10; 
    		my_checker(`state_4, `bin_4);

    		$display("checking State_4->State_5");
    		sim_SW = `bin_3; #10; 
    		my_checker(`state_5, `bin_5);

    		$display("checking State_5->State_6");
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_6, `bin_6);

    		$display("checking State_6->State_6");
    		sim_SW = `bin_0; #10; 
    		my_checker(`state_6, `bin_6);


		// Testing S7 to S12
	    	sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0; #10;
    		my_checker(`state_0, `bin_0);
    		sim_KEY[3] = 1'b1; // de-assert reset
			
    		$display("checking State_0->State_7");
    		sim_SW = `bin_1; #10; 
    		my_checker(`state_7, `bin_7);

    		$display("checking State_7->State_8");
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_8, `bin_8);

    		$display("checking State_8->State_9");
    		sim_SW = `bin_3; #10; 
    		my_checker(`state_9, `bin_9);

    		$display("checking State_9->State_10");
    		sim_SW = `bin_4; #10; 
    		my_checker(`state_10, `bin_10);

    		$display("checking State_10->State_11");
    		sim_SW = `bin_5; #10; 
    		my_checker(`state_11, `bin_11);

    		$display("checking State_11->State_12");
    		sim_SW = `bin_6; #10; 
    		my_checker(`state_12, `bin_12);

    		$display("checking State_12->State_12");
    		sim_SW = `bin_7; #10; 
    		my_checker(`state_12, `bin_12);


		// Testing S1 to S8
    		sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0; #10;
    		sim_KEY[3] = 1'b1; // de-assert reset
		$display("checking State_1->State_8");
    		sim_SW = `bin_8; #10;  // State_0->State_1
    		my_checker(`state_1, `bin_1);
    		sim_SW = `bin_0; #10;  // State_1->State_8
    		my_checker(`state_8, `bin_8);


	
		// Testing S2 to S9
		sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0; #10;
    		sim_KEY[3] = 1'b1; // de-assert reset
     		$display("checking State_2->State_9");
    		sim_SW = `bin_8; #10;
    		my_checker(`state_1, `bin_1);  // State_0->State_1
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_2, `bin_2);  // State_1->State_2
    		sim_SW = `bin_0; #10; 
    		my_checker(`state_9, `bin_9);  // State_2->State_9


		// Testing S3 to S10
		sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0;  #10;
    		my_checker(`state_0, `bin_0);
    		sim_KEY[3] = 1'b1; // de-assert reset
		$display("checking State_3->State_10");
    		sim_SW = `bin_8; #10; 
    		my_checker(`state_1, `bin_1);    // State_0->State_1
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_2, `bin_2);    // State_1->State_2
    		sim_SW = `bin_5; #10; 
    		my_checker(`state_3, `bin_3);    // State_2->State_3
    		sim_SW = `bin_0; #10; 
    		my_checker(`state_10, `bin_10);  // State_3->State_10

		
		// Tesing S4 to S11
		sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0; #10;
    		my_checker(`state_0, `bin_0);
    		sim_KEY[3] = 1'b1; // de-assert reset
		$display("checking State_4->State_11");
    		sim_SW = `bin_8;#10; 
    		my_checker(`state_1, `bin_1);   // State_0->State_1
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_2, `bin_2);   // State_1->State_2
    		sim_SW = `bin_5; #10; 
    		my_checker(`state_3, `bin_3);   // State_2->State_3
    		sim_SW = `bin_4; #10; 
    		my_checker(`state_4, `bin_4);   // State_3->State_4	
    		sim_SW = `bin_0; #10; 
    		my_checker(`state_11, `bin_11); // State_4->State_11


		// Testing S5 to S12
		sim_KEY[3] = 1'b0; 
		sim_SW = `bin_0; #10;
    		my_checker(`state_0, `bin_0);
    		sim_KEY[3] = 1'b1; // de-assert reset
		$display("checking State_5->State_12");
    		sim_SW = `bin_8; #10; 
    		my_checker(`state_1, `bin_1); //State_0->State_1 
    		sim_SW = `bin_2; #10; 
    		my_checker(`state_2, `bin_2); // State_1->State_2
    		sim_SW = `bin_5; #10; 
    		my_checker(`state_3, `bin_3); // State_2->State_3 
    		sim_SW = `bin_4; #10; 
    		my_checker(`state_4, `bin_4); // State_3->State_4
    		sim_SW = `bin_3; #10;
    		my_checker(`state_5, `bin_5);  // State_4->State_5
    		sim_SW = `bin_0; #10;
    		my_checker(`state_12, `bin_12);  // State_5->State_12
		

    		if( ~err ) $display("PASSED"); // display the test result
    		else $display("FAILED");
		$stop;
	end


endmodule: tb_lab3
