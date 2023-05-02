module  player_mapper ( input			 vga_clk,
								 input		 [3:0] Player_Status,
								input        [9:0] Player_X, Player_Y, DrawX, DrawY, Player_SizeX, Player_SizeY,
								input			 blank,
								output logic [7:0]  Red, Green, Blue );
    
   //Initialization of the background 
	logic [16:0] rom_address_bg;
	logic [3:0] rom_q_bg;
	logic [3:0] palette_red_bg, palette_green_bg, palette_blue_bg;
	//Initialization of the knight idle
	logic [11:0] rom_address_ki;
	logic [2:0] rom_q_ki;
	logic [3:0] palette_red_ki, palette_green_ki, palette_blue_ki;
	//Initialization of the knight walk 1
	logic [11:0] rom_address_walk1;
	logic [2:0] rom_q_walk1;
	logic [3:0] palette_red_walk1, palette_green_walk1, palette_blue_walk1;
	//Initialization of the knight jump
	logic [11:0] rom_address_jp;
	logic [2:0] rom_q_jp;
	logic [3:0] palette_red_jp, palette_green_jp, palette_blue_jp;
	//Initialization of the knight fall
	logic [11:0] rom_address_fall;
	logic [2:0] rom_q_fall;
	logic [3:0] palette_red_fall, palette_green_fall, palette_blue_fall;
	
	logic negedge_vga_clk;
	// read from ROM on negedge, set pixel on posedge
	assign negedge_vga_clk = ~vga_clk;
	// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
	// this will stretch out the sprite across the entire screen
	logic [9:0] X,Y;
	assign X = DrawX-(Player_X-24)+1;
	assign Y = DrawY-(Player_Y-30)+1;
	assign rom_address_bg = ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
	assign rom_address_ki = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_walk1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_jp = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_fall = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 

	 
	 logic ball_on, ball_on_jump;
	  
    int DistX, DistY, SizeX, SizeY, SizeX_jump, SizeY_jump;
	 assign DistX = DrawX - Player_X;
    assign DistY = DrawY - Player_Y;
    assign SizeX = Player_SizeX;
	 assign SizeY = Player_SizeY;
	 assign SizeX_jump = 45; 
	 assign SizeY_jump = SizeY;
	 
	  //Determine whether the ball is on the background
    always_comb
     begin:Ball_on_proc
			if((DistX*DistX<=SizeX*SizeX/4) &&(DistY*DistY<=SizeY*SizeY/4))
				ball_on = 1'b1;
			else 
            ball_on = 1'b0;
     end
	  
    always_comb
     begin:Ball_on_proc_jump
			if((DistX*DistX<=SizeX_jump*SizeX_jump/4) &&(DistY*DistY<=SizeY_jump*SizeY_jump/4))
				ball_on_jump = 1'b1;
			else 
            ball_on_jump = 1'b0;
     end
	  

	
    always_comb
    begin:RGB_Display//Display the image
			
			//Draw the image of knight
        if ((ball_on == 1'b1)&&((Player_Status==1)||(Player_Status==0))) 
        begin 
				Red <= {palette_red_bg,4'h0};
				Green <= {palette_green_bg,4'h0};
				Blue <= {palette_blue_bg,4'h0};
				
				if (blank)  begin 
						if (Player_Status == 0 && (palette_red_ki!=4'hD)) begin //Idle 
						Red <= {palette_red_ki,4'h0};
						Green <= {palette_green_ki,4'h0};
						Blue <= {palette_blue_ki,4'h0};
						end
						

						if (Player_Status == 1 && (palette_red_walk1!=4'hD)) begin //walk
						Red <= {palette_red_walk1,4'h0};
						Green <= {palette_green_walk1,4'h0};
						Blue <= {palette_blue_walk1,4'h0};
						end
						
				end    
        end  
		else if ((ball_on_jump == 1'b1)
		&&((Player_Status==2)||(Player_Status==3)))
		begin
				Red <= {palette_red_bg,4'h0};
				Green <= {palette_green_bg,4'h0};
				Blue <= {palette_blue_bg,4'h0};
				
				if (blank)  begin 
						if (Player_Status == 2 && (palette_red_jp!=4'hD)) begin //jump
						Red <= {palette_red_jp,4'h0};
						Green <= {palette_green_jp,4'h0};
						Blue <= {palette_blue_jp,4'h0};
						end
						
						if (Player_Status == 3 && (palette_red_fall!=4'hD)) begin //fall
						Red <= {palette_red_fall,4'h0};
						Green <= {palette_green_fall,4'h0};
						Blue <= {palette_blue_fall,4'h0};
						end
				end    			
		end



			//Draw the image of the background
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
   
	
knight_idle_50_64_rom knight_idle_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_ki),
	.q       (rom_q_ki)
);

knight_idle_50_64_palette knight_idle_50_64_palette (
	.index (rom_q_ki),
	.red   (palette_red_ki),
	.green (palette_green_ki),
	.blue  (palette_blue_ki)
);	

knight_walk1_50_64_rom knight_walk1_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk1),
	.q       (rom_q_walk1)
);

knight_walk1_50_64_palette knight_walk1_50_64_palette (
	.index (rom_q_walk1),
	.red   (palette_red_walk1),
	.green (palette_green_walk1),
	.blue  (palette_blue_walk1)
);
knight_jump_50_64_rom knight_jump_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_jp),
	.q       (rom_q_jp)
);

knight_jump_50_64_palette knight_jump_50_64_palette (
	.index (rom_q_jp),
	.red   (palette_red_jp),
	.green (palette_green_jp),
	.blue  (palette_blue_jp)
);
knight_fall_50_64_rom knight_fall_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_fall),
	.q       (rom_q_fall)
);

knight_fall_50_64_palette knight_fall_50_64_palette (
	.index (rom_q_fall),
	.red   (palette_red_fall),
	.green (palette_green_fall),
	.blue  (palette_blue_fall)
);
endmodule
