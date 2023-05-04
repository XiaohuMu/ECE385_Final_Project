module  player_mapper ( input			 vga_clk, frame_clk,
								input		 	 [3:0] Player_Status,Player_Life,
								input        [9:0] Player_X, Player_Y, DrawX, DrawY, Player_SizeX, Player_SizeY,
								input			 [9:0] MaskX1, MaskX2, MaskX3, MaskX4, MaskX5, MaskY1, MaskSX, MaskSY,
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
	//Initialization of the knight walk 3
	logic [11:0] rom_address_walk3;
	logic [2:0] rom_q_walk3;
	logic [3:0] palette_red_walk3, palette_green_walk3, palette_blue_walk3;
	//Initialization of the knight walk 3 inverted
	logic [11:0] rom_address_walk3I;
	logic [2:0] rom_q_walk3I;
	logic [3:0] palette_red_walk3I, palette_green_walk3I, palette_blue_walk3I;
	//Initialization of the knight walk 2
	logic [11:0] rom_address_walk2;
	logic [2:0] rom_q_walk2;
	logic [3:0] palette_red_walk2, palette_green_walk2, palette_blue_walk2;
   //Initialization of the knight walk 2 INVERTED
	logic [11:0] rom_address_walk2I;
	logic [2:0] rom_q_walk2I;
	logic [3:0] palette_red_walk2I, palette_green_walk2I, palette_blue_walk2I;
	
	
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
	//Initialization of the knight fall
	logic [11:0] rom_address_fall1;
	logic [2:0] rom_q_fall1;
	logic [3:0] palette_red_fall1, palette_green_fall1, palette_blue_fall1;
	//Initialization of the knight fall inverted
	logic [11:0] rom_address_fall1I;
	logic [2:0] rom_q_fall1I;
	logic [3:0] palette_red_fall1I, palette_green_fall1I, palette_blue_fall1I;
	
	
	//Initialization of the knight attack1
	logic [11:0] rom_address_at1;
	logic [2:0] rom_q_at1;
	logic [3:0] palette_red_at1, palette_green_at1, palette_blue_at1;
	//Initialization of the knight attack1 inverted	
	logic [11:0] rom_address_at1I;
	logic [2:0] rom_q_at1I;
	logic [3:0] palette_red_at1I, palette_green_at1I, palette_blue_at1I;
	//Initialization of the knight attack2
	logic [11:0] rom_address_at2;
	logic [2:0] rom_q_at2;
	logic [3:0] palette_red_at2, palette_green_at2, palette_blue_at2;
	//Initialization of the knight attack2 inverted
	logic [11:0] rom_address_at2I;
	logic [2:0] rom_q_at2I;
	logic [3:0] palette_red_at2I, palette_green_at2I, palette_blue_at2I;
	//Initialization of the knight attack3
	logic [11:0] rom_address_at3;
	logic [2:0] rom_q_at3;
	logic [3:0] palette_red_at3, palette_green_at3, palette_blue_at3;
	//Initialization of the knight attack3 inverted
	logic [11:0] rom_address_at3I;
	logic [2:0] rom_q_at3I;
	logic [3:0] palette_red_at3I, palette_green_at3I, palette_blue_at3I;
	//Initialization of the knight attack4
	logic [11:0] rom_address_at4;
	logic [2:0] rom_q_at4;
	logic [3:0] palette_red_at4, palette_green_at4, palette_blue_at4;
	//Initialization of the knight attack4
	logic [11:0] rom_address_at4I;
	logic [2:0] rom_q_at4I;
	logic [3:0] palette_red_at4I, palette_green_at4I, palette_blue_at4I;
	
	
	//Initialization of the mask
	logic [7:0] rom_address_mask1;
	logic [1:0] rom_q_mask1;
	logic [3:0] palette_red_mask1, palette_green_mask1, palette_blue_mask1;
	logic [7:0] rom_address_mask2;
	logic [1:0] rom_q_mask2;
	logic [3:0] palette_red_mask2, palette_green_mask2, palette_blue_mask2;
	logic [7:0] rom_address_mask3;
	logic [1:0] rom_q_mask3;
	logic [3:0] palette_red_mask3, palette_green_mask3, palette_blue_mask3;	
	logic [7:0] rom_address_mask4;
	logic [1:0] rom_q_mask4;
	logic [3:0] palette_red_mask4, palette_green_mask4, palette_blue_mask4;	
	logic [7:0] rom_address_mask5;
	logic [1:0] rom_q_mask5;
	logic [3:0] palette_red_mask5, palette_green_mask5, palette_blue_mask5;	
	
	logic [11:0] rom_address_dead1;
	logic [2:0] rom_q_dead1;
	logic [3:0] palette_red_dead1, palette_green_dead1, palette_blue_dead1;
	logic [11:0] rom_address_dead2;
	logic [2:0] rom_q_dead2;
	logic [3:0] palette_red_dead2, palette_green_dead2, palette_blue_dead2;
	
	
	
	
	logic fclk;
	logic negedge_vga_clk;
	// read from ROM on negedge, set pixel on posedge
	assign fclk = frame_clk;
	assign negedge_vga_clk = ~vga_clk;
	// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
	// this will stretch out the sprite across the entire screen
	logic [9:0] X,Y,X1,Y1;
	assign X = DrawX-(Player_X-24)+1;
	assign Y = DrawY-(Player_Y-30)+1;
	assign X1 = DrawX-(Player_X-28)+1;
	assign Y1 = DrawY-(Player_Y-30)+1;
	
	logic [9:0] mX1,mX2,mX3,mX4,mX5, mY;
	assign mX1 = DrawX-(MaskX1-5)+1;
	assign mX2 = DrawX-(MaskX2-5)+1;
	assign mX3 = DrawX-(MaskX3-5)+1;
	assign mX4 = DrawX-(MaskX4-5)+1;
	assign mX5 = DrawX-(MaskX5-5)+1;
	assign mY = DrawY-(MaskY1-7)+1;
	
	assign rom_address_bg = ((DrawX * 320) / 640) + (((DrawY * 240) / 480) * 320);
	assign rom_address_ki = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_kiI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	
	assign rom_address_walk1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	 
	assign rom_address_walk1I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_walk2 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_walk2I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_walk3 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_walk3I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);		
	
	assign rom_address_jp = ((X * 50) / 50) + (((Y * 64) / 64) * 50);	
	assign rom_address_jpI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);		
	assign rom_address_fall = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_fall1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_fallI = ((X * 50) / 50) + (((Y * 64) / 64) * 50);		
	assign rom_address_fall1I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);

	assign rom_address_at1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at1I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at2 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at2I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at3 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at3I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at4 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_at4I = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	
	assign rom_address_dead2 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);
	assign rom_address_dead1 = ((X * 50) / 50) + (((Y * 64) / 64) * 50);

	assign rom_address_mask1 = ((mX1 * 12) / 12) + (((mY * 16) / 16) * 12);
	assign rom_address_mask2 = ((mX2 * 12) / 12) + (((mY * 16) / 16) * 12);
	assign rom_address_mask3 = ((mX3 * 12) / 12) + (((mY * 16) / 16) * 12);
	assign rom_address_mask4 = ((mX4 * 12) / 12) + (((mY * 16) / 16) * 12);
	assign rom_address_mask5 = ((mX5 * 12) / 12) + (((mY * 16) / 16) * 12);
	 
	 
	 logic ball_on, ball_on_jump,  Player_Inverse;
	 logic mask_on1, mask_on2,mask_on3, mask_on4, mask_on5;
	 assign Player_Inverse = Inverse;
	  
    int DistX, DistY, SizeX, SizeY, SizeX_jump, SizeY_jump;
	 assign DistX = DrawX - Player_X;
    assign DistY = DrawY - Player_Y;
	 
    assign SizeX = Player_SizeX;
	 assign SizeY = Player_SizeY;
	 assign SizeX_jump = 45; 
	 assign SizeY_jump = SizeY;
	 
	 int DistXm1,DistXm2,DistXm3,DistXm4,DistXm5, DistYm, SizeXm, SizeYm;
	 assign DistXm1 = DrawX - MaskX1;
	 assign DistXm2 = DrawX - MaskX2;
	 assign DistXm3 = DrawX - MaskX3;
	 assign DistXm4 = DrawX - MaskX4;
	 assign DistXm5 = DrawX - MaskX5;
    assign DistYm = DrawY - MaskY1;
	 assign SizeXm = MaskSX;
	 assign SizeYm = 15;
	 
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
    begin:mask1_on_proc
				if((DistXm1*DistXm1<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
					mask_on1 = 1;

				else 
					mask_on1 = 0;
	 end
	 
	 always_comb 
    begin:mask2_on_proc
				if((DistXm2*DistXm2<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
					mask_on2 = 1;

				else 
					mask_on2 = 0;
	 end
	 
	 always_comb
    begin:mask3_on_proc
				if((DistXm3*DistXm3<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
					mask_on3 = 1;

				else 
					mask_on3 = 0;
	 end
	 
	 always_comb
    begin:mask4_on_proc
				if((DistXm4*DistXm4<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
					mask_on4 = 1;

				else 
					mask_on4 = 0;
	 end 
	 
	 always_comb
    begin:mask5_on_proc
				if((DistXm5*DistXm5<=SizeXm*SizeXm/4) &&(DistYm*DistYm<=SizeYm*SizeYm/4))
					mask_on5 = 1;

				else 
					mask_on5 = 0;
	 end 
	 
	logic [8:0] counter, color;
	always_ff @ (posedge frame_clk )
	begin: Walk_animation //Walk _animation
			
			counter <= counter+1;
			if (counter == 5) begin
				
				if(color == 0) begin
					color <= 1;
					counter <= 0;
				end
				
				else if(color == 1) begin
					color <= 2;
					counter <= 0;
				end
				
				else begin 
					color <= 0;
					counter <= 0;
				end

			end
	end


	logic [8:0] counterf, state;
	always_ff @ (posedge frame_clk )
	begin: Fall_animation //Fall_animation
			
			counterf <= counterf+1;
			if (counterf == 15) begin
				
				if(state == 0) begin
					state <= 1;
					counterf <= 0;
				end
				
				else if(state == 1) begin
					state <= 0;
					counterf <= 0;
				end
				

			end
	end	
	
	logic [8:0] counter_at, state_at;
	always_ff @ (posedge frame_clk )
	begin: Attack_animation //Attack_animation
			
			counter_at <= counter_at+1;
			if (counter_at == 5) begin
				
				if(state_at == 0) begin
					state_at  <= 1;
					counter_at <= 0;
				end
				
				else if(state_at == 1) begin
					state_at <= 2;
					counter_at <= 0;
				end
				
				else if(state_at == 2)
				begin 
					state_at <= 3;
					counter_at <= 0;
				end
				
				else if(state_at == 3)
				begin 
					state_at <= 0;
					counter_at <= 0;
				end
			end
	end
	
	

	
	logic [8:0] counterd, stated;
	always_ff @ (posedge frame_clk )
	begin: Die_animation //Die_animation
			
			counterd <= counterd+1;
			if (counterd == 5) begin
				
				if(stated == 0) begin
					stated <= 1;
					counterd <= 0;
				end
				
				else if(stated == 1) begin
					stated <= 0;
					counterd <= 0;
				end
				

			end
	end	
	always_comb
    begin:RGB_Display//Display the image
			


			
			//Draw the image of knight
        if ((ball_on == 1'b1)&&((Player_Status==1)||(Player_Status==0))) 
        begin: Draw_walk_idle_attack3
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
				
				if (blank)  begin 
						if (Player_Status == 0 && (palette_red_ki!=4'hD)&& Player_Inverse==0 ) begin //Idle_Right 
						Red = {palette_red_ki,4'h0};
						Green = {palette_green_ki,4'h0};
						Blue = {palette_blue_ki,4'h0};
						end
						
						if (Player_Status == 0 && (palette_red_kiI!=4'hD)&& Player_Inverse==1 ) begin //Idle_Right 
						Red = {palette_red_kiI,4'h0};
						Green = {palette_green_kiI,4'h0};
						Blue = {palette_blue_kiI,4'h0};
			
						end						
						//Walk Right
						if (Player_Status == 1 && Player_Inverse==0) // Walk Right
						begin 
							if(color == 0 && palette_red_walk1!=4'hD)
							begin //walk_Right
							Red = {palette_red_walk1,4'h0};
							Green = {palette_green_walk1,4'h0};
							Blue = {palette_blue_walk1,4'h0};
							end
							
							if((color == 1 )
							&& palette_red_walk2!=4'hD)
							begin //walk_Right
							Red = {palette_red_walk2,4'h0};
							Green = {palette_green_walk2,4'h0};
							Blue = {palette_blue_walk2,4'h0};
							end
							
							if(color == 2 
							&& palette_red_walk3!=4'hD)
							begin //walk_Right
							Red = {palette_red_walk3,4'h0};
							Green = {palette_green_walk3,4'h0};
							Blue = {palette_blue_walk3,4'h0};
							end		
							
						end
						//Walk Left
						if (Player_Status == 1 && Player_Inverse==1) //Walk Left
						begin 
							if(color == 0 && palette_red_walk1I!=4'hD)
							begin //walk_Left
							Red = {palette_red_walk1I,4'h0};
							Green = {palette_green_walk1I,4'h0};
							Blue = {palette_blue_walk1I,4'h0};
							end
							
							if((color == 1 )
							&& palette_red_walk2I!=4'hD)
							begin //walk_Left
							Red = {palette_red_walk2I,4'h0};
							Green = {palette_green_walk2I,4'h0};
							Blue = {palette_blue_walk2I,4'h0};
							end
							
							if(color == 2 
							&& palette_red_walk3I!=4'hD)
							begin //walk_Left
							Red = {palette_red_walk3I,4'h0};
							Green = {palette_green_walk3I,4'h0};
							Blue = {palette_blue_walk3I,4'h0};
							end		
							
						end
				end    
        end 
		  
		
		
		else if ((ball_on_jump == 1'b1)
		&&((Player_Status==2)||(Player_Status==3)
		||(Player_Status == 4)||(Player_Status == 5)))
		begin: Draw_jump_attack1
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
				
				if (blank)  begin 
						if (Player_Status == 2 && (palette_red_jp!=4'hD) && Player_Inverse == 0) begin //jump Right
						Red = {palette_red_jp,4'h0};
						Green = {palette_green_jp,4'h0};
						Blue = {palette_blue_jp,4'h0};
						end
						
						if (Player_Status == 2 && (palette_red_jpI!=4'hD) && Player_Inverse == 1) begin //jump Left
						Red = {palette_red_jpI,4'h0};
						Green = {palette_green_jpI,4'h0};
						Blue = {palette_blue_jpI,4'h0};
						end	
						
						if (Player_Status == 3 && Player_Inverse==0) //Fall Right
						begin 
							if(state == 0 && palette_red_fall!=4'hD)
							begin //fall Left
							Red = {palette_red_fall,4'h0};
							Green = {palette_green_fall,4'h0};
							Blue = {palette_blue_fall,4'h0};
							end
							
							if(state == 1 && palette_red_fall1!=4'hD)
							begin //fall Left
							Red = {palette_red_fall1,4'h0};
							Green = {palette_green_fall1,4'h0};
							Blue = {palette_blue_fall1,4'h0};
							end
							
							
						end
						
						if (Player_Status == 3 && Player_Inverse==1) //Fall Left
						begin 
							if(state == 0 && palette_red_fallI!=4'hD)
							begin //fall Left
							Red = {palette_red_fallI,4'h0};
							Green = {palette_green_fallI,4'h0};
							Blue = {palette_blue_fallI,4'h0};
							end
							
							if(state == 1 && palette_red_fall1I!=4'hD)
							begin //fall Left
							Red = {palette_red_fall1I,4'h0};
							Green = {palette_green_fall1I,4'h0};
							Blue = {palette_blue_fall1I,4'h0};
							end
							
							
						end
						
						
						
						if (Player_Status == 4 && Player_Inverse == 0) //Attack Right
						begin 
							if(state_at == 0 && (palette_red_at1!=4'hD))begin
								Red = {palette_red_at1,4'h0};
								Green = {palette_green_at1,4'h0};
								Blue = {palette_blue_at1,4'h0};
							end
							
							if(state_at == 1 && (palette_red_at2!=4'hD))begin
								Red = {palette_red_at2,4'h0};
								Green = {palette_green_at2,4'h0};
								Blue = {palette_blue_at2,4'h0};
							end
							
							if(state_at == 2 && (palette_red_at3 != 4'hD))begin
								Red = {palette_red_at3,4'h0};
								Green = {palette_green_at3,4'h0};
								Blue = {palette_blue_at3,4'h0};
							end
							
							if(state_at == 3 && (palette_red_at4 != 4'hD))begin
								Red = {palette_red_at4,4'h0};
								Green = {palette_green_at4,4'h0};
								Blue = {palette_blue_at4,4'h0};
							end
							
						end
						
						
						if (Player_Status == 4 && Player_Inverse == 1) //Attack Right
						begin 
							if(state_at == 0 && (palette_red_at1I!=4'hD))begin
								Red = {palette_red_at1I,4'h0};
								Green = {palette_green_at1I,4'h0};
								Blue = {palette_blue_at1I,4'h0};
							end
							
							if(state_at == 1 && (palette_red_at2I!=4'hD))begin
								Red = {palette_red_at2I,4'h0};
								Green = {palette_green_at2I,4'h0};
								Blue = {palette_blue_at2I,4'h0};
							end
							
							if(state_at == 2 && (palette_red_at3I != 4'hD))begin
								Red = {palette_red_at3I,4'h0};
								Green = {palette_green_at3I,4'h0};
								Blue = {palette_blue_at3I,4'h0};
							end
							
							if(state_at == 3 && (palette_red_at4I != 4'hD))begin
								Red = {palette_red_at4I,4'h0};
								Green = {palette_green_at4I,4'h0};
								Blue = {palette_blue_at4I,4'h0};
							end
							
						end
						//dead
						if (Player_Status == 5 ) //dead
						begin 
							if(stated == 0 && (palette_red_dead1!=4'hD))begin
								Red = {palette_red_dead1,4'h0};
								Green = {palette_green_dead1,4'h0};
								Blue = {palette_blue_dead1,4'h0};
							end
							
							if(stated == 1 && (palette_red_dead2!=4'hD))begin
								Red = {palette_red_dead2,4'h0};
								Green = {palette_green_dead2,4'h0};
								Blue = {palette_blue_dead2,4'h0};
							end
							
							
						end
				end    			
		end
		
		

			
			
			else if(mask_on1 == 1)
			begin
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
				
					if(blank) begin
						if(palette_red_mask1 != 4'hC)
						begin
							if(Player_Life !=0)
							begin
								Red = {palette_red_mask1,4'h0};
								Green = {palette_green_mask1,4'h0};
								Blue = {palette_blue_mask1,4'h0};
							end
							
							else
							begin
								Red = 8'h10;
								Green = 8'h20;
								Blue = 8'h30;
							end
						end
					end
			end
			
			else if(mask_on2 == 1)
			begin
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
				
					if(blank) begin
						if(palette_red_mask2 != 4'hC)
						begin
							if(Player_Life !=0 && Player_Life !=1)
							begin
								Red = {palette_red_mask2,4'h0};
								Green = {palette_green_mask2,4'h0};
								Blue = {palette_blue_mask2,4'h0};
							end
							
							else
							begin
								Red = 8'h10;
								Green = 8'h20;
								Blue = 8'h30;
							end
						end
					end
			end
			
			else if(mask_on3 == 1)
			begin
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
				
					if(blank) begin
						if(palette_red_mask3 != 4'hC)
						begin
							if(Player_Life !=0 && Player_Life !=1 && Player_Life !=2 )
							begin
								Red = {palette_red_mask3,4'h0};
								Green = {palette_green_mask3,4'h0};
								Blue = {palette_blue_mask3,4'h0};
							end
						
							else
							begin
								Red = 8'h10;
								Green = 8'h20;
								Blue = 8'h30;
							end
						end
					end
			end	
			
			else if(mask_on4 == 1)
			begin
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
					if(blank) begin
						if(palette_red_mask4 != 4'hC)
						begin
							if(Player_Life ==4 || Player_Life ==5 )
							begin
								Red = {palette_red_mask4,4'h0};
								Green = {palette_green_mask4,4'h0};
								Blue = {palette_blue_mask4,4'h0};
							end
							
							else
							begin
								Red = 8'h10;
								Green = 8'h20;
								Blue = 8'h30;
							end
						end
					end
					
			end	
			
			else if(mask_on5 == 1)
			begin
				Red = {palette_red_bg,4'h0};
				Green = {palette_green_bg,4'h0};
				Blue = {palette_blue_bg,4'h0};
					if(blank) begin
						if(palette_red_mask5 != 4'hC)
						begin
							if(Player_Life ==5)
							begin
								Red = {palette_red_mask5,4'h0};
								Green = {palette_green_mask5,4'h0};
								Blue = {palette_blue_mask5,4'h0};
							end
							
							else
							begin
								Red = 8'h10;
								Green = 8'h20;
								Blue = 8'h30;
							end
						end
					end
			end
			//Draw the image of the background
        else 
			begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
				
				if (blank)  begin 
						Red = {palette_red_bg,4'h0};
						Green = {palette_green_bg,4'h0};
						Blue = {palette_blue_bg,4'h0};
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
knight_walk2_50_64_rom knight_walk2_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk2),
	.q       (rom_q_walk2)
);

knight_walk2_50_64_palette knight_walk2_50_64_palette (
	.index (rom_q_walk2),
	.red   (palette_red_walk2),
	.green (palette_green_walk2),
	.blue  (palette_blue_walk2)
);
knight_walk2_50_64_IVT_rom knight_walk2_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk2I),
	.q       (rom_q_walk2I)
);

knight_walk2_50_64_IVT_palette knight_walk2_50_64_IVT_palette (
	.index (rom_q_walk2I),
	.red   (palette_red_walk2I),
	.green (palette_green_walk2I),
	.blue  (palette_blue_walk2I)
);
knight_walk3_50_64_rom knight_walk3_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk3),
	.q       (rom_q_walk3)
);

knight_walk3_50_64_palette knight_walk3_50_64_palette (
	.index (rom_q_walk3),
	.red   (palette_red_walk3),
	.green (palette_green_walk3),
	.blue  (palette_blue_walk3)
);
knight_walk3_50_64_IVT_rom knight_walk3_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_walk3I),
	.q       (rom_q_walk3I)
);

knight_walk3_50_64_IVT_palette knight_walk3_50_64_IVT_palette (
	.index (rom_q_walk3I),
	.red   (palette_red_walk3I),
	.green (palette_green_walk3I),
	.blue  (palette_blue_walk3I)
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
knight_fall1_50_64_rom knight_fall1_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_fall1),
	.q       (rom_q_fall1)
);

knight_fall1_50_64_palette knight_fall1_50_64_palette (
	.index (rom_q_fall1),
	.red   (palette_red_fall1),
	.green (palette_green_fall1),
	.blue  (palette_blue_fall1)
);

knight_fall1_50_64_IVT_rom knight_fall1_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_fall1I),
	.q       (rom_q_fall1I)
);

knight_fall1_50_64_IVT_palette knight_fall1_50_64_IVT_palette (
	.index (rom_q_fall1I),
	.red   (palette_red_fall1I),
	.green (palette_green_fall1I),
	.blue  (palette_blue_fall1I)
);
knight_attack1_50_64_rom knight_attack1_50_64_rom (
 .clock   (negedge_vga_clk),
 .address (rom_address_at1),
 .q       (rom_q_at1)
);

knight_attack1_50_64_palette knight_attack1_50_64_palette (
 .index (rom_q_at1),
 .red   (palette_red_at1),
 .green (palette_green_at1),
 .blue  (palette_blue_at1)
);

knight_attack2_50_64_rom knight_attack2_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at2),
	.q       (rom_q_at2)
);

knight_attack2_50_64_palette knight_attack2_50_64_palette (
	.index (rom_q_at2),
	.red   (palette_red_at2),
	.green (palette_green_at2),
	.blue  (palette_blue_at2)
);

knight_attack3_50_64_rom knight_attack3_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at3),
	.q       (rom_q_at3)
);

knight_attack3_50_64_palette knight_attack3_50_64_palette (
	.index (rom_q_at3),
	.red   (palette_red_at3),
	.green (palette_green_at3),
	.blue  (palette_blue_at3)
);
knight_attack4_50_64_rom knight_attack4_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at4),
	.q       (rom_q_at4)
);

knight_attack4_50_64_palette knight_attack4_50_64_palette (
	.index (rom_q_at4),
	.red   (palette_red_at4),
	.green (palette_green_at4),
	.blue  (palette_blue_at4)
);
knight_attack1_50_64_IVT_rom knight_attack1_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at1I),
	.q       (rom_q_at1I)
);

knight_attack1_50_64_IVT_palette knight_attack1_50_64_IVT_palette (
	.index (rom_q_at1I),
	.red   (palette_red_at1I),
	.green (palette_green_at1I),
	.blue  (palette_blue_at1I)
);

knight_attack2_50_64_IVT_rom knight_attack2_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at2I),
	.q       (rom_q_at2I)
);

knight_attack2_50_64_IVT_palette knight_attack2_50_64_IVT_palette (
	.index (rom_q_at2I),
	.red   (palette_red_at2I),
	.green (palette_green_at2I),
	.blue  (palette_blue_at2I)
);

knight_attack3_50_64_IVT_rom knight_attack3_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at3I),
	.q       (rom_q_at3I)
);

knight_attack3_50_64_IVT_palette knight_attack3_50_64_IVT_palette (
	.index (rom_q_at3I),
	.red   (palette_red_at3I),
	.green (palette_green_at3I),
	.blue  (palette_blue_at3I)
);
knight_attack4_50_64_IVT_rom knight_attack4_50_64_IVT_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_at4I),
	.q       (rom_q_at4I)
);

knight_attack4_50_64_IVT_palette knight_attack4_50_64_IVT_palette (
	.index (rom_q_at4I),
	.red   (palette_red_at4I),
	.green (palette_green_at4I),
	.blue  (palette_blue_at4I)
);
HP_12_16_rom HP_12_16_rom1 (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask1),
		.q       (rom_q_mask1)
);

HP_12_16_palette HP_12_16_palette1 (
		.index (rom_q_mask1),
		.red   (palette_red_mask1),
		.green (palette_green_mask1),
		.blue  (palette_blue_mask1)
);	
HP_12_16_rom HP_12_16_rom2 (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask2),
		.q       (rom_q_mask2)
);

HP_12_16_palette HP_12_16_palette2 (
		.index (rom_q_mask2),
		.red   (palette_red_mask2),
		.green (palette_green_mask2),
		.blue  (palette_blue_mask2)
);	
HP_12_16_rom HP_12_16_rom3 (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask3),
		.q       (rom_q_mask3)
);

HP_12_16_palette HP_12_16_palette3 (
		.index (rom_q_mask3),
		.red   (palette_red_mask3),
		.green (palette_green_mask3),
		.blue  (palette_blue_mask3)
);	
HP_12_16_rom HP_12_16_rom4 (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask4),
		.q       (rom_q_mask4)
);

HP_12_16_palette HP_12_16_palette4 (
		.index (rom_q_mask4),
		.red   (palette_red_mask4),
		.green (palette_green_mask4),
		.blue  (palette_blue_mask4)
);	
HP_12_16_rom HP_12_16_rom5 (
		.clock   (negedge_vga_clk),
		.address (rom_address_mask5),
		.q       (rom_q_mask5)
);

HP_12_16_palette HP_12_16_palette5 (
		.index (rom_q_mask5),
		.red   (palette_red_mask5),
		.green (palette_green_mask5),
		.blue  (palette_blue_mask5)
);	
knight_dead1_50_64_rom knight_dead1_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_dead1),
	.q       (rom_q_dead1)
);

knight_dead1_50_64_palette knight_dead1_50_64_palette (
	.index (rom_q_dead1),
	.red   (palette_red_dead1),
	.green (palette_green_dead1),
	.blue  (palette_blue_dead1)
);
knight_dead2_50_64_rom knight_dead2_50_64_rom (
	.clock   (negedge_vga_clk),
	.address (rom_address_dead2),
	.q       (rom_q_dead2)
);

knight_dead2_50_64_palette knight_dead2_50_64_palette (
	.index (rom_q_dead2),
	.red   (palette_red_dead2),
	.green (palette_green_dead2),
	.blue  (palette_blue_dead2)
);
endmodule
