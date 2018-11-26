`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:34:24 11/22/2018 
// Design Name: 
// Module Name:    Port_B 
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
module Port_B(
   inout reg [7:0] B,
inout reg [7:0] B_cpu,
input group_control,// control on or out
input control_logic // to activate the port
    );

if (control_logic)
begin
		always @(group_control)
		begin

			if(!group_control)
			begin
				
				B <= B_cpu;
			
			end
			else begin
				
				B_cpu <= B;
				
			end

		end //always

end //if

endmodule
