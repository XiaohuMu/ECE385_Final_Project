module  player_mapper ( input			 vga_clk,
								input		 	 [3:0] Player_Status,
								input        [9:0] Player_X, Player_Y, DrawX, DrawY, Player_SizeX, Player_SizeY,
								input			 blank, Inverse,
								output logic [7:0]  Red, Green, Blue );
    
   //Initialization of the background 
	logic [16:0] rom_address_bg;
	logic [3:0] rom_q_bg;
	logic [3:0] palette_red_bg, palette_green_bg, palette_blue_bg;
	//Initialization of the knight idle
	logic [11:0] rom_address_ki;
	logic [2:0] rom_q_ki;
	logic [3:0] palette_red_ki, palette_green_ki, palette_blue_ki;
	//Initialization of the knight idle inverted
	logic [11:0] rom_address_kiI;
	logic [2:0] rom_q_kiI;
	logic [3:0] palette_red_kiI, palette_green_kiI, palette_blue_kiI;
	//Initialization of the knight walk 1
	logic [11:0] rom_address_walk1;
	logic [2:0] rom_q_walk1;
	logic [3:0] palette_red_walk1, palette_green_walk1, palette_blue_walk1;
	//Initialization of the knight walk 1 inverted
	logic [11:0] rom_address_walk1I;
	logic [2:0] rom_q_walk1I;
	logic [3:0] palette_red_walk1I, palette_green_walk1I, palette_blue_walk1I;
	//Initialization of the knight jump
	logic [11:0] rom_address_jp;
	logic [2:0] rom_q_jp;
	logic [3:0] palette_red_jp, palette_green_jp, palette_blue_jp;
	//Initialization of the knight jump inverted
	logic [11:0] rom_address_jpI;
	logic [2:0] rom_q_jpI;
	logic [3:0] palette_red_jpI, palette_green_jpI, palette_blue_jpI;
	//Initialization of the knight fall
	logic [11:0] rom_address_fall;
	logic [2:0] rom_q_fall;
	logic [3:0] palette_red_fall, palette_green_fall, palette_blue_fall;
	//Initialization of the knight fall inverted
	logic [11:0] rom_address_fallI;
	logic [2:0] rom_q_fallI;
	logic [3:0] palette_red_fallI, palette_green_fallI, palette_blue_fallI;
	
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
	assign rom_address_kiI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_walk1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_walk1I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_jp = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_jpI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);		
	assign rom_address_fall = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_fallI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);		

	 
	 logic ball_on, ball_on_jump, Player_Inverse;
	 assign Player_Inverse = Inverse;
	  
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
						if (Player_Status == 0 && (palette_red_ki!=4'hD)&& Player_Inverse==0 ) begin //Idle_Right 
						Red <= {palette_red_ki,4'h0};
						Green <= {palette_green_ki,4'h0};
						Blue <= {palette_blue_ki,4'h0};
						end
						
						if (Player_Status == 0 && (palette_red_kiI!=4'hD)&& Player_Inverse==1 ) begin //Idle_Right 
						Red <= {palette_red_kiI,4'h0};
						Green <= {palette_green_kiI,4'h0};
						Blue <= {palette_blue_kiI,4'h0};
			
						end						
				
						if (Player_Status == 1 && (palette_red_walk1!=4'hD) && Player_Inverse==0) begin //walk_Right
						Red <= {palette_red_walk1,4'h0};
						Green <= {palette_green_walk1,4'h0};
						Blue <= {palette_blue_walk1,4'h0};
						end
						
						if (Player_Status == 1 && (palette_red_walk1I!=4'hD) && Player_Inverse==1) begin //walk_Right
						Red <= {palette_red_walk1I,4'h0};
						Green <= {palette_green_walk1I,4'h0};
						Blue <= {palette_blue_walk1I,4'h0};
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
						if (Player_Status == 2 && (palette_red_jp!=4'hD) && Player_Inverse == 0) begin //jump
						Red <= {palette_red_jp,4'h0};
						Green <= {palette_green_jp,4'h0};
						Blue <= {palette_blue_jp,4'h0};
						end
						
						if (Player_Status == 2 && (palette_red_jpI!=4'hD) && Player_Inverse == 1) begin //jump
						Red <= {palette_red_jpI,4'h0};
						Green <= {palette_green_jpI,4'h0};
						Blue <= {palette_blue_jpI,4'h0};
						end	
						
						if (Player_Status == 3 && (palette_red_fall!=4'hD) && Player_Inverse == 0) begin //fall
						Red <= {palette_red_fall,4'h0};
						Green <= {palette_green_fall,4'h0};
						Blue <= {palette_blue_fall,4'h0};
						end
						
						if (Player_Status == 3 && (palette_red_fallI!=4'hD) && Player_Inverse == 1) begin //fall
						Red <= {palette_red_fallI,4'h0};
						Green <= {palette_green_fallI,4'h0};
						Blue <= {palette_blue_fallI,4'h0};
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
knight_idle_50_64_IVT_rom knight_idle_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_kiI),
	.q       (rom_q_kiI)
);

knight_idle_50_64_IVT_palette knight_idle_50_64_IVT_palette (
	.index (rom_q_kiI),
	.red   (palette_red_kiI),
	.green (palette_green_kiI),
	.blue  (palette_blue_kiI)
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
knight_walk1_50_64_IVT_rom knight_walk1_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk1I),
	.q       (rom_q_walk1I)
);

knight_walk1_50_64_IVT_palette knight_walk1_50_64_IVT_palette (
	.index (rom_q_walk1I),
	.red   (palette_red_walk1I),
	.green (palette_green_walk1I),
	.blue  (palette_blue_walk1I)
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
knight_jump_50_64_IVT_rom knight_jump_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_jpI),
	.q       (rom_q_jpI)
);

knight_jump_50_64_IVT_palette knight_jump_50_64_IVT_palette (
	.index (rom_q_jpI),
	.red   (palette_red_jpI),
	.green (palette_green_jpI),
	.blue  (palette_blue_jpI)
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
knight_fall_50_64_IVT_rom knight_fall_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_fallI),
	.q       (rom_q_fallI)
);

knight_fall_50_64_IVT_palette knight_fall_50_64_IVT_palette (
	.index (rom_q_fallI),
	.red   (palette_red_fallI),
	.green (palette_green_fallI),
	.blue  (palette_blue_fallI)
);
endmodule
