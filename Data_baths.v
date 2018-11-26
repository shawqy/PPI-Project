`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:04 11/25/2018 
// Design Name: 
// Module Name:    Data_baths 
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
module Data_baths(
inout [7:0]D,
inout [7:0]PA,
inout [7:0]PB,
inout [7:0]PC,
input write,
input read,
input cs,
input reset,
input [1:0] A

    );
wire [7:0] databus;
wire group_control,data_bus;
wire portA,portB,portC,r,w,c,re;
wire [1:0] Aa;

Control_logic control (
    .RD_n(r), 
    .WR_n(w), 
    .A(Aa), 
    .Reset(re), 
    .CS_n(c), 
    .data_bus(data_bus), 
    .group_control(group_control), 
    .port_control_A(portA), 
    .port_control_B(portB), 
    .port_control_C(portC)
    );
	 
	 assign Aa = A;
	 assign r = read;
	 assign w = write;
	 assign re = reset;
	 assign cs = c;
Data_bus_buffer buffer(
	 .control_logic(data_bus),
	 .databus(databus),
	 .bus(D)
    );

endmodule
