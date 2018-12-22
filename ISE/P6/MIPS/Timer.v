`timescale 1ns / 1ps

module Timer(
    input CLK,
    input RST,
    input [1:0] innerADDR,		// 0 for CTRL, 1 for PRESET, 2 for COUNT.  [ABS ADDR = base + innerADDR*4]
    input WE,
    input  [31:0] WD,
    output [31:0] RD,
    output IRQout
    );

	reg [31:0] CTRL, INIT, COUNT;
	initial begin
		CTRL <= 0;
		INIT <= 0;
		COUNT <= 0;
		IRQ <= 0;
	end
	
	assign Enable = CTRL[0]; 	// 1 for enable counting
	assign Mode = CTRL[1];		// 0 for down to zero, 1 for continous
	assign IAllow = CTRL[3];	// 1 for allowing interrupt
	assign Write_ctrl = (WE==1 && innerADDR==0);
	assign Write_init = (WE==1 && innerADDR==1);
	
	assign RD = (innerADDR==0) ? CTRL : (innerADDR==1 ? INIT : COUNT);
	
	reg IRQ;
	assign IRQout = IRQ;

	always@(posedge CLK) begin
		if(RST) begin
			CTRL <= 0;
			INIT <= 0;
			COUNT <= 0;
			IRQ <= 0;
		end
		else begin
			
			if(Mode==0) begin
				if(IRQ==1 && IAllow==0)		// IRQ holding 1 UNTIL IALLOW = 0.
					IRQ <= 0;
					
				if(Enable) begin
					if(COUNT > 0) begin
						COUNT <= COUNT-1;
						if(COUNT==1) IRQ <= IAllow;
					end
					else begin
						COUNT <= INIT+1;			// ZERO mode: wait for restarting until Enable = 1.
					end
					
					if(Write_ctrl)
						CTRL <= {28'b0, WD[3], 1'b0, WD[1:0]};	// WD Modify Priority !!!!!
					else if(COUNT==1)
						CTRL <= ({CTRL[31:1], 1'b0});			// ZERO mode: set Enable to 0 automatically !!!!!
					if(Write_init)
						INIT<= WD;
				end
				else begin						// ZERO mode: holding 0 value until Enable
					if(Write_ctrl)
						CTRL <= {28'b0, WD[3], 1'b0, WD[1:0]};
					if(Write_init)
						INIT<= WD;
				end
			end
			
			else if(Mode==1) begin
				if(Enable) begin
					if(COUNT > 0) begin
						COUNT <= COUNT-1;
						if(COUNT==1) IRQ <= IAllow;
					end
					else begin
						COUNT <= INIT+1;			// ONE mode: restart from INIT automatically !!!!!
						IRQ <= 0;
					end
					
					if(Write_ctrl)
						CTRL <= {28'b0, WD[3], 1'b0, WD[1:0]};
					if(Write_init)
						INIT<= WD;
				end
				else begin
					if(Write_ctrl)
						CTRL <= {28'b0, WD[3], 1'b0, WD[1:0]};
					if(Write_init)
						INIT<= WD;
				end
			end
		end
	end

endmodule
