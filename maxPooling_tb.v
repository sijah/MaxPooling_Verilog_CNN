`timescale 1ns / 1ps

module maxPooling_tb;

	// Inputs
	reg [21:0] input1_layer1;
	reg [21:0] input2_layer1;
	reg [21:0] input3_layer1;
	reg [21:0] input4_layer1;

	reg [21:0] input1_layer2;
	reg [21:0] input2_layer2;
	reg [21:0] input3_layer2;
	reg [21:0] input4_layer2;
	reg [21:0] output_final;
	reg clk;
	reg layer1_en;
	reg layer2_en;
    reg layer1_done;
	reg layer2_done;
	// Outputs
	wire [21:0] output_layer1;
	wire [21:0] output_layer2;
	wire maxPoolingDone_layer1;
	wire maxPoolingDone_layer2;
	
	reg [21:0] array_image [0:63];
	reg [21:0] matrix_layer_2 [0:15] ;
	integer i = 0;
	integer j = 0;
	integer k = 0;
    integer l = 4;
	integer sum =0;

	// Instantiate the Unit Under Test (UUT)
	maxPooling uut1 (
		.input1(input1_layer1), 
		.input2(input2_layer1), 
		.input3(input3_layer1), 
		.input4(input4_layer1), 
		.clk(clk), 
		.enable(layer1_en), 
		.output1(output_layer1), 
		.maxPoolingDone(maxPoolingDone_layer1)
	);
	maxPooling uut2 (
		.input1(input1_layer2), 
		.input2(input2_layer2), 
		.input3(input3_layer2), 
		.input4(input4_layer2), 
		.clk(clk), 
		.enable(layer2_en), 
		.output1(output_layer2), 
		.maxPoolingDone(maxPoolingDone_layer2)
	);
	
	initial begin
		clk = 0;
		sum = 0;
		layer1_en = 0;
		layer2_en = 0;
		input1_layer1 = 0;
		input2_layer1 = 0;
		input3_layer1 = 0;
		input4_layer1 = 0;

		input1_layer2 = 0;
		input2_layer2 = 0;
		input3_layer2 = 0;
		input4_layer2 = 0;
		//set 1
		array_image[ 0 ] =  66 ;
        array_image[ 1 ] =  43 ;
        array_image[ 2 ] =  0 ;
        array_image[ 3 ] =  23 ;
		//set 2     
        array_image[ 4 ] =  112 ;
        array_image[ 5 ] =  43;
        array_image[ 6 ] =  45 ;
        array_image[ 7 ] =  23 ;
 		//set 3     
        array_image[ 8 ] =  44 ;
        array_image[ 9 ] =  55 ;
        array_image[ 10 ] =  51 ;
        array_image[ 11 ] =  22 ;
		//set 4
        array_image[ 12 ] =  32 ;
        array_image[ 13 ] =  44 ;
        array_image[ 14 ] =  112 ;
        array_image[ 15 ] =  56;
		//set 5
        array_image[ 16 ] =  87 ;
        array_image[ 17 ] =  11 ;
        array_image[ 18 ] =  56 ;
        array_image[ 19 ] =  32 ;
		//set 6
        array_image[ 20 ] =  29 ;
        array_image[ 21 ] =  11 ;
        array_image[ 22 ] =  0 ;
        array_image[ 23 ] =  32 ;
		//set 7      
        array_image[ 24 ] =  32 ;
        array_image[ 25 ] =  33 ;
        array_image[ 26 ] =  112 ;
        array_image[ 27 ] =  44;
		//set 8      
        array_image[ 28 ] =  43 ;
        array_image[ 29 ] =  66 ;
        array_image[ 30 ] =  21 ;
        array_image[ 31 ] =  88 ;
 		//set 9     
        array_image[ 32 ] =  123 ;
        array_image[ 33 ] =  45;
        array_image[ 34 ] =  11 ;
        array_image[ 35 ] =  67 ;
 		//set 10     
        array_image[ 36 ] =  54 ;
        array_image[ 37 ] =  332 ;
        array_image[ 38 ] =  32 ;
        array_image[ 39 ] =  112 ;
 		//set 11      
        array_image[ 40 ] =  43;
        array_image[ 41 ] =  11 ;
        array_image[ 42 ] =  214 ;
        array_image[ 43 ] =  31;
 		//set 12     
        array_image[ 44 ] =  80 ;
        array_image[ 45 ] =  97 ;
        array_image[ 46 ] =  98 ;
        array_image[ 47 ] =  112 ;
 		//set 13     
        array_image[ 48 ] =  55 ;
        array_image[ 49 ] =  32 ;
        array_image[ 50 ] =  11 ;
        array_image[ 51 ] =  11 ;
 		//set 14     
        array_image[ 52 ] =  56 ;
        array_image[ 53 ] =  99 ;
        array_image[ 54 ] =  77;
        array_image[ 55 ] =  88 ;
 		//set 15     
        array_image[ 56 ] =  0 ;
        array_image[ 57 ] =  55 ;
        array_image[ 58 ] =  112 ;
        array_image[ 59 ] =  44;
 		//set 16     
        array_image[ 60 ] =  39 ;
        array_image[ 61 ] =  11 ;
        array_image[ 62 ] =  0 ;
        array_image[ 63 ] =  88 ;

	end
	
	always #5 clk = ~clk;	
	
	always @ (posedge clk) begin
		if(i < 64) begin
			layer1_en = 1;
			input1_layer1 = array_image[i];
			input2_layer1 = array_image[i+1];
			input3_layer1 = array_image[i+2];
			input4_layer1 = array_image[i+3];
			i = i + 4;
			 #10;
			// sum = sum + output_layer1;
			// #2;
            matrix_layer_2[j]=output_layer1;
			// #10;
            j=j+1; 
	         #2;
		 end
		else 
		 begin
		  layer1_en = 0;
          layer1_done = 1;
		 end
	end

	always @(posedge clk) begin
		if(l <= 14 && k <= 10 && layer1_done==1 )
		 begin
			layer2_en=1;
			#10;
			input1_layer2 = matrix_layer_2[k];
			input2_layer2 = matrix_layer_2[k+1];
			input3_layer2 = matrix_layer_2[l];
			input4_layer2 = matrix_layer_2[l+1];
			#10;
			sum = sum + output_layer2;
			#10;
			if ( k ==2 )
			begin
			k = 8;
			l =12;
			end
			else 
			begin
			k= k+2;
			l = l+2;
			end	
		 end
		 else
		  begin
			#2;
			layer2_en=0;
			layer2_done=1;
		  end
	end

	always @(negedge layer2_en) begin
		$display("Final sum =%d",sum);
		#10;	
	end

	always @(posedge clk) begin
		// $display("Final sum =%d",sum);
		$dumpfile("maxpooler.vcd");
		$dumpvars;
		#1000
		$finish;		
	end     
endmodule

