`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:26 04/07/2015 
// Design Name: 
// Module Name:    H2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module H2(input [1:0] Block, input clk, nonce_sig, input [31:0] b, output reg [31:0] H2_out, H2 );

reg [31:0] inter;
reg source; 
initial
begin
H2_out =32'hbb67ae85;
H2 = 32'hbb67ae85;
end

always @ (posedge clk)
begin
	
	if (Block == 0  && nonce_sig ==0)			//initial block, reading default values
		begin
			H2_out <=32'hbb67ae85;
			H2<=32'hbb67ae85;
			source <=0;
		end
	else
		begin
		if(Block ==1 && source == 0)
			begin
			H2_out <=b + H2_out;
			H2<=b + H2_out;
			if (nonce_sig == 0)	
				inter <=b + H2_out; 
			source <=~source;
			end
		else
		if(Block ==2 && source ==1)
				begin
					H2_out <=b + H2_out;
					H2<=32'hbb67ae85;
					source <=~source;
				end
				if(Block ==3 && source ==0)
				begin
					H2_out <=b + H2;
					H2 <= inter;
					if(nonce_sig ==0)
					source <= ~source;
					else
					source <= 0;
				end
		end
		
end

endmodule


