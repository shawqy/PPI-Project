`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:40:37 11/22/2018 
// Design Name: 
// Module Name:    Group_A_control 
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
module Group_B_control(
input control_logic, //1 for control mode
inout [6:0] bus, // D6,D5,D4,D3
input M_S_F, // D7
output reg port_control_B,
output reg port_control_C_L
    );

always@(control_logic,bus)
		if (control_logic)
		begin
			
			if(M_S_F)
			begin //mode select flag
				
				case (bus[3])
				
					1'b0 : begin
					Port_control_B <= (bus[1])? 1 : 0 ;
					port_control_C_L <= (bus[0])? 1 : 0 ;
					end
									
				endcase
			
			end //end of mode select
			else begin //SBR
			
			
			end //end of SBR
			
		end // if

endmodule
