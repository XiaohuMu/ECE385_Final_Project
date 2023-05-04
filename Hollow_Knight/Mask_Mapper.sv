module  mask_mapper ( input			 vga_clk, frame_clk,
								input		 	 [3:0] Player_Life,
								input        [9:0] MaskX1, MaskY1, DrawX, DrawY, MaskSX, MaskSY,
								input			 blank, 
								output logic [7:0]  Red, Green, Blue );

//	//Initialization of the background 

	
	logic [7:0] rom_address_mask;
	logic [1:0] rom_q_mask;
	logic [3:0] palette_red_mask, palette_green_mask, palette_blue_mask;
	
	logic negedge_vga_clk;
	assign negedge_vga_clk= ~vga_clk;
	
	logic [9:0] mX,mY;
	assign mX = DrawX-(MaskX1-5)+1;
	assign mY = DrawY-(MaskY1-7)+1;
	

	assign rom_address_mask = ((mX * 12) / 12) + (((mY * 16) / 16) * 12);
	
	logic mask_on;
	int DistXm, DistYm, SizeXm, SizeYm;
	assign DistXm = DrawX - MaskX1;
   assign DistYm = DrawY - MaskY1;
	assign SizeXm = MaskSX;
	assign SizeYm = MaskSY;
	
	always_comb
   begin:mask_on_proc
			if((DistXm*DistXm<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
				mask_on = 1'b1;
			else 
            mask_on = 1'b0;
   end
	
	always_comb
   begin:RGB_Display//Display the image
//			if(mask_on == 1 'b1)
//			begin
				Red = 8'hff;
				Green = 8'h00;
				Blue = 8'h00;
//
//			end
			
//			else
//			begin
//				Red = 8'h00;
//				Green = 8'hff;
//				Blue = 8'h00;
//			end
	end


	HP_12_16_rom HP_12_16_rom (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask),
		.q       (rom_q_mask)
	);

	HP_12_16_palette HP_12_16_palette (
		.index (rom_q_mask),
		.red   (palette_red_mask),
		.green (palette_green_mask),
		.blue  (palette_blue_mask)
	);	
	

endmodule 