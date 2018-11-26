`timescale 1ns / 1ps

module Group_A_control(
input control_logic, //1 for control mode
inout [7:0] bus_cpu, // D6,D5,D4,D3
output reg port_control_A,
output reg port_control_C_U
    );
	 
reg [7:0] bus;
always@ (bus_cpu)
begin
bus <= bus_cpu;

end
 
assign bus_cpu = (!bus_cpu[7]&&control_logic)? bus : 8'bzzzz_zzzz;

always@(control_logic,bus_cpu)
		if (control_logic)
		begin
			
			if(bus_cpu[7])
			begin //mode select flag
				
				casez (bus_cpu[6:5])
				
					2'b00 : begin
					port_control_A <= (bus_cpu[4])? 1'b1 : 1'b0 ;
					port_control_C_U <= (bus_cpu[3])? 1'b1 : 1'b0 ;
					end
									
				endcase
			
			end //end of mode select
		else begin //BSR
			
				casez (bus_cpu[3:1])
					
					3'b111: bus <=(bus_cpu[0])? 8'bzzzz_zzz1 :8'bzzzz_zzz0;
					3'b110: bus <=(bus_cpu[0])? 8'bzzzz_zz1z :8'bzzzz_zz0z;
					3'b101: bus <=(bus_cpu[0])? 8'bzzzz_z1zz:8'bzzzz_z0zz;
					3'b100: bus <=(bus_cpu[0])? 8'bzzzz_1zzz :8'bzzzz_0zzz;
					default:bus <=8'bzzzz_zzzz;
					
				endcase
			
			end //end of BSR 
		end // if
   /*assign  bus_cpu = (!control_logic)? 8'bzzzz_zzzz: 
				(bus_cpu[7])? 8'bzzzz_zzzz:
				(bus_cpu[3:1] == 3'b111)? {7'bzzzz_zzz,bus_cpu[0]}:
				(bus_cpu[3:1] == 3'b110)? {2'bzz,bus_cpu[0],5'bzzzzz}: //zz_1_zzzzz
				(bus_cpu[3:1] == 3'b101)? {3'bzzz,bus_cpu[0],4'bzzzz}:
				(bus_cpu[3:1] == 3'b100)? {4'bzzzz,bus_cpu[0],3'bzzz}: 8'bzzzz_zzzz;
			*/	
				
endmodule


module test_group_control();

reg control_logic;
wire [7:0] bus_cpu;
wire port_control_A,port_control_C_U;

reg [7:0] bus;

Group_A_control groupA (
    .control_logic(control_logic), 
    .bus_cpu(bus_cpu), 
    .port_control_A(port_control_A), 
    .port_control_C_U(port_control_C_U)
    );



assign bus_cpu =(control_logic)? bus: 8'bzzzz_zzzz;

initial
begin

control_logic = 1;
bus = 8'b0000_1011;
#10

control_logic = 1;
bus = 8'b1001_1011;
#10

control_logic = 1;
bus = 8'b1000_1011;
#10

control_logic = 1;
bus = 8'b1001_0011;
#10
control_logic = 0;
end

	


endmodule


