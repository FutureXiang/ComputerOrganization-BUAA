`timescale 1ns / 1ps

module Stall_Detector(
    input [31:0] IFID,
    input [31:0] IDEX,
    input [31:0] EXMEM,
	input [31:0] MEMWB,
	input [4:0] A3_IDEX,
    input [4:0] A3_EXMEM,
    input [4:0] A3_MEMWB,
    output STALL
    );

	// beq_rsrt@IF/ID stall:    calR@ID/EX    calI@ID/EX    lw@ID/EX    lw@EX/MEM
	// jr_rs   @IF/ID stall:    calR@ID/EX    calI@ID/EX    lw@ID/EX    lw@EX/MEM
	// C_R_rsrt@IF/ID stall:    lw@ID/EX
	// C_I_rs  @IF/ID stall:    lw@ID/EX
	// lw_rs   @IF/ID stall:    lw@ID/EX
	// sw_rs   @IF/ID stall:    lw@ID/EX
	
	`define BEQ 4
	`define LW 35
	`define SW 43
	`define R 0
	`define JR_funct 8
	`define ORI 13
	`define LUI 15
	`define JAL 3
	
	`define OP 31:26
	`define FUNCT 5:0
	`define rs 25:21
	`define rt 20:16
	`define rd 15:11
	
	

	assign C_R_IDEX = (IDEX[`OP]==`R   & IDEX[`FUNCT]!=`JR_funct);
	assign C_I_IDEX = (IDEX[`OP]==`LUI | IDEX[`OP]==`ORI);
	
	assign DM_IDEX = (IDEX[`OP]==`LW);
	assign DM_EXMEM = (EXMEM[`OP]==`LW);
	
	
	assign beq = (IFID[`OP]==`BEQ);
	assign jr  =  (IFID[`OP]==`R & IFID[`FUNCT]==`JR_funct);
	assign calR = (IFID[`OP]==`R & IFID[`FUNCT]!=`JR_funct);
	assign calI = (IFID[`OP]==`LUI | IFID[`OP]==`ORI);
	assign lw = (IFID[`OP]==`LW);
	assign sw = (IFID[`OP]==`SW);
	
	
	// add to here if adding instructions !!! (Tuse expressions)
	assign Tuse_rs0 = beq + jr;
	assign Tuse_rs1 = calR + calI + lw + sw;
	assign Tuse_rt0 = beq;
	assign Tuse_rt1 = calR;
	assign Tuse_rt2 = sw;
	
	
	wire [1:0] Res_IDEX, Res_EXMEM, Res_MEMWB;
	// change this if adding instructions !!! (case of opcode)
	Res_Translator GetRes(IDEX, EXMEM, MEMWB,     Res_IDEX, Res_EXMEM, Res_MEMWB);
	
	`define ALU 2'b01	// cal_R, cal_I
	`define DM 2'b10	// load
	`define PC 2'b11	// jal
	`define NW 2'b00	// others: beq, store, jr
	
	wire Stall_rs0_IDEX1 = Tuse_rs0 & (Res_IDEX==`ALU) & (IFID[`rs]==A3_IDEX & IFID[`rs]!=0 );
	wire Stall_rs0_IDEX2 = Tuse_rs0 & (Res_IDEX==`DM)  & (IFID[`rs]==A3_IDEX & IFID[`rs]!=0 );
	wire Stall_rs0_EXMEM1= Tuse_rs0 & (Res_EXMEM==`DM) & (IFID[`rs]==A3_EXMEM& IFID[`rs]!=0 );
	wire Stall_rs1_IDEX2 = Tuse_rs1 & (Res_IDEX==`DM)  & (IFID[`rs]==A3_IDEX & IFID[`rs]!=0 );
	wire Stall_rs = Stall_rs0_IDEX1 | Stall_rs0_IDEX2 | Stall_rs0_EXMEM1 | Stall_rs1_IDEX2;
	
	wire Stall_rt0_IDEX1 = Tuse_rs0 & (Res_IDEX==`ALU) & (IFID[`rt]==A3_IDEX & IFID[`rt]!=0 );
	wire Stall_rt0_IDEX2 = Tuse_rs0 & (Res_IDEX==`DM)  & (IFID[`rt]==A3_IDEX & IFID[`rt]!=0 );
	wire Stall_rt0_EXMEM1= Tuse_rs0 & (Res_EXMEM==`DM) & (IFID[`rt]==A3_EXMEM& IFID[`rt]!=0 );
	wire Stall_rt1_IDEX2 = Tuse_rs1 & (Res_IDEX==`DM)  & (IFID[`rt]==A3_IDEX & IFID[`rt]!=0 );
	wire Stall_rt = Stall_rt0_IDEX1 | Stall_rt0_IDEX2 | Stall_rt0_EXMEM1 | Stall_rt1_IDEX2;
	
    
	assign STALL = Stall_rs | Stall_rt;

endmodule
