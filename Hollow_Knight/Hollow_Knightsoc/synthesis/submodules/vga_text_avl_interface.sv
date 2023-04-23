`define NUM_REGS 601 //80*30 characters / 4 characters per register
`define CTRL_REG 600 //index of control register

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs						// VGA HS/VS
);



	
byte_enabled_true_dual_port_ram vram(	.addr1(AVL_ADDR[10:0]), 							.addr2(letter_reg), 
													.be1(AVL_BYTE_EN), 									.be2('0), 
													.data_in1(AVL_WRITEDATA), 							.data_in2(AVL_WRITEDATA), 
													.we1(AVL_WRITE&AVL_CS&(~AVL_ADDR[11])), 		.we2('0), .clk(CLK), 
													.data_out1(VRAMout), 							.data_out2(letter_code_word));

logic [31:0] Palette_REG   [16];
logic [31:0] VRAMout;
													

always_ff @(posedge CLK) begin

	if (AVL_CS & AVL_ADDR[11])begin

		if(AVL_WRITE == 1'b1 && AVL_READ == 1'b0)  begin
			Palette_REG[AVL_ADDR[3:0]] = {'0, AVL_WRITEDATA[15:0]};

		end
		
	end
end

always_comb begin
	if (AVL_ADDR[11] == 1'b1)		AVL_READDATA = Palette_REG[AVL_ADDR[3:0]];
	else									AVL_READDATA = VRAMout;					
end

//handle drawing (may either be combinational or sequential - or both).
logic pixel_clk, blank, sync, pixel;
logic [9:0] DrawX, DrawY;
logic [10:0] glyph_line_number;
logic [7:0] glyph_line_data;
	
	
logic [10:0] letter_reg;
//logic [9:0] letter_reg_buffer;
logic	letter_positionREG;
logic [1:0][15:0] letter_code_word; //added!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//logic [3:0][7:0] letter_code_word_buffer; //added!!!!
logic [15:0] letter_code;

vga_controller vga_controller_0 (.Clk(CLK), .Reset(RESET), .hs, .vs, .pixel_clk, .blank, .sync, .DrawX, .DrawY  );
font_rom	font_rom_0 (.addr(glyph_line_number), .data(glyph_line_data));

logic [31:0] control_register;

always_comb  begin
	
	letter_reg = (DrawX >> 4) +  (DrawY >> 4) * 40;	
	letter_positionREG = DrawX[3]; 
	//letter_code =  LOCAL_REG[letter_reg][letter_positionREG];
	letter_code = letter_code_word[letter_positionREG];

	glyph_line_number = {letter_code[14:8], DrawY[3:0]};
	
	control_register[24:13] = Palette_REG[letter_code[7:4]][11:0];
	
	control_register[12:1] = Palette_REG[letter_code[3:0]][11:0];
	
	control_register[0] = '0;
	control_register[1] = '0;

end



always_ff @(posedge pixel_clk)	begin 

	if(blank)	begin
		if((glyph_line_data[7-DrawX[2:0]])^letter_code[15] == 1'b1) begin
		
			red <= control_register[24:21];
			green <= control_register[20:17];
			blue <= control_register[16:13];
		end
		
		else	begin
			
			red <= control_register[12:9];
			green <= control_register[8:5];
			blue <= control_register[4:1];
		
		end
	
	end
	

	else	begin
	
		red <= 4'h0;
		green <= 4'h0;
		blue <= 4'h0;
		
	end
	

end

endmodule