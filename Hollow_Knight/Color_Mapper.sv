module  player_mapper ( input			 vga_clk,
								input        [9:0] BallX, BallY, DrawX, DrawY, Ball_sizeX, Ball_sizeY,
								input			 blank,
								output logic [7:0]  Red, Green, Blue );
    
   //Initialization of the background 
	logic [16:0] rom_address_bg;
	logic [3:0] rom_q_bg;
	logic [3:0] palette_red_bg, palette_green_bg, palette_blue_bg;
	//Initialization of the knight idle
	logic [10:0] rom_address_ki;
	logic [2:0] rom_q_ki;
	logic [3:0] palette_red_ki, palette_green_ki, palette_blue_ki;
	logic negedge_vga_clk;
	// read from ROM on negedge, set pixel on posedge
	assign negedge_vga_clk = ~vga_clk;
	// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
	// this will stretch out the sprite across the entire screen
	logic [9:0] X,Y;
	assign X = DrawX-(BallX-15)+1;
	assign Y = DrawY-(BallY-30)+1;
	assign rom_address_bg = ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
	assign rom_address_ki = ((X * 30) / 30) + (((Y * 64) / 64) * 30);	 
 

	 
	 logic ball_on;
	  
    int DistX, DistY, SizeX, SizeY;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign SizeX = Ball_sizeX;
	 assign SizeY = Ball_sizeY;
	  
    always_comb
    begin:Ball_on_proc
			if((DistX*DistX<=SizeX*SizeX/4) &&(DistY*DistY<=SizeY*SizeY/4)&&(palette_red_ki!=4'hD))
				ball_on = 1'b1;
			else 
            ball_on = 1'b0;
     end 
    
	
	
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
				Red <= 8'h00;
				Green <= 8'h00;
				Blue <= 8'h00;
				
				if (blank)  begin 
						Red <= {palette_red_ki,4'h0};
						Green <= {palette_green_ki,4'h0};
						Blue <= {palette_blue_ki,4'h0};

				end    
        end  
		  

        else 
			begin
				Red <= 8'h00;
				Green <= 8'h00;
				Blue <= 8'h00;
				
				if (blank)  begin 
						Red <= {palette_red_bg,4'h0};
						Green <= {palette_green_bg,4'h0};
						Blue <= {palette_blue_bg,4'h0};
				end    
			end
    end 

background_320_240_rom background_320_240_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_bg),
	.q       (rom_q_bg)
);

background_320_240_palette background_320_240_palette (
	.index (rom_q_bg),
	.red   (palette_red_bg),
	.green (palette_green_bg),
	.blue  (palette_blue_bg)
);
   
	
knight_idle_30_64_rom knight_idle_30_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_ki),
	.q       (rom_q_ki)
);

knight_idle_30_64_palette knight_idle_30_64_palette (
	.index (rom_q_ki),
	.red   (palette_red_ki),
	.green (palette_green_ki),
	.blue  (palette_blue_ki)
);	
endmodule
