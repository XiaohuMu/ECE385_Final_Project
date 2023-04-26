module  player_mapper ( input			 vga_clk,
								input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
								input			 blank,
								output logic [3:0]  Red, Green, Blue );
    
    
	logic [16:0] rom_address;
	logic [3:0] rom_q;

	logic [3:0] palette_red, palette_green, palette_blue;
	logic negedge_vga_clk;
	// read from ROM on negedge, set pixel on posedge
	assign negedge_vga_clk = ~vga_clk;

	// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
	// this will stretch out the sprite across the entire screen
	assign rom_address = ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
		 
	 
	 
	 logic ball_on;
	  
    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	  
    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 4'hf;
            Green = 4'hf;
            Blue = 4'hf;
        end  
		  

        else 
        begin 
				Red <= palette_red;
				Green <= palette_green;
				Blue <= palette_blue;
        end      
    end 

background_320_240_rom background_320_240_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

background_320_240_palette background_320_240_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);
    
endmodule
