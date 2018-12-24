`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:36:48 11/24/2018
// Design Name:   mips
// Module Name:   D:/BUAA/CS/ComputerOrgan/ISE/P5/Pipeline/TB.v
// Project Name:  Pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] dip_switch0, dip_switch1, dip_switch2, dip_switch3, dip_switch4, dip_switch5, dip_switch6, dip_switch7;
	reg [7:0] user_key;

	wire [7:0] digital_tube2, digital_tube1, digital_tube0;
	wire [3:0] digital_tube_sel1, digital_tube_sel0;
	wire digital_tube_sel2;
	wire [31:0] led_light;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk), 
		.sys_rstn(reset),
		.dip_switch0(dip_switch0),
		.dip_switch1(dip_switch1),
		.dip_switch2(dip_switch2),
		.dip_switch3(dip_switch3),
		.dip_switch4(dip_switch4),
		.dip_switch5(dip_switch5),
		.dip_switch6(dip_switch6),
		.dip_switch7(dip_switch7),
		.user_key(user_key),
		.led_light(led_light),
		.digital_tube2(digital_tube2),
		.digital_tube_sel2(digital_tube_sel2),
		.digital_tube1(digital_tube1),
		.digital_tube_sel1(digital_tube_sel1),
		.digital_tube0(digital_tube0),
		.digital_tube_sel0(digital_tube_sel0)
	);

	initial begin
		clk = 0;
		reset = 1;
		#10;
		reset = 0;

		user_key = 8'b10100101;
		dip_switch0 = 8'b11110000;
		dip_switch1 = 8'b00001111;
		dip_switch2 = 8'b11100111;
		dip_switch3 = 8'b00011000;
		dip_switch4 = 8'b11000011;
		dip_switch5 = 8'b00111100;
		dip_switch6 = 8'b10000001;
		dip_switch7 = 8'b01111110;
		
	end
	always #1 clk = ~clk;
      
endmodule

