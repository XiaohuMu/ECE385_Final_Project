
module  NPC_Vertical ( input Reset, frame_clk,
//					input [3:0]  Player_Status,
					input [7:0] keycode,
					
//					Enemy_LifeH,
//					output Enemy_hurt,
//					output [3:0] Enemy_LifeV,
					output [9:0]  Enemy_state, Enemy_state1,
				   output [9:0]  Enemy_X, Enemy_Y, Enemy_Size_X, Enemy_Size_Y);
					 
    logic [9:0] NPC_X_Pos, NPC_Y_Pos, NPC_X_Motion, NPC_Y_Motion, NPC_SizeX, NPC_SizeY;
	 //logic [3:0] status;
	 //logic NPC_hurt;
	 
	 
	 logic [9:0] state, state1;
	 logic start;
	 logic [15:0] counter1;
//	 ,lifeV, lifeH, life; //0 is idle, 1 is up, 2 is left, 3 is right, 4 is down, 5 is dead

	 parameter [9:0] NPC_Y_Min = 0;
	 parameter [9:0] NPC_Y_MAX = 328;// center postion
	 parameter [9:0] NPC_X_Min = 64;
	 parameter [9:0] NPC_X_Max = 572;
		
	 parameter [9:0] NPC_X_Center=324;  // Center position on the X axis
    parameter [9:0] NPC_Y_Center=110;  // Center position on the Y axis
	 
//	 parameter [3:0] NPC_Life = 10;

	//10 from each other
    assign NPC_SizeX = 63;  
	 assign NPC_SizeY = 160; 
//  assign life = lifeV;
	
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
		  
        if (Reset )
//		  || Player_Status == 5)  // Asynchronous Reset
        begin 
				NPC_X_Pos <= NPC_X_Center;
				NPC_Y_Pos <= NPC_Y_Center;
				start <= 0;
				state <= 0;
				state1 <= 0;
				counter1 <= 0;

//				status <= 0;
//				life <= NPC_Life;
        end
		  //dead
		  
//		  else if (life == 0)
//		  begin
//				status <= 5;
//				
//		  end
			
		  else
		  begin

					case(keycode) 
					
					//game start
						8'h2C:
						begin
							start <= 1;
							state <= 1;
						end
						
						
						default:
						begin 
							start <= start;
							state <= state;
						end
						
					endcase
					
					if(start==1)
					begin: NPC_Animation
							//1 start move upward
							if(state == 1) begin
								counter1 <= counter1+1;
								if(counter1 == 30) begin
										if(state1 == 0) 
										begin
											NPC_Y_Motion <= 0;//stay still
											state1 <= 1;
											counter1 <= 0;
										end
										
										else if(state1 == 1) 
										begin
											NPC_Y_Motion <= 0;//stay still
											state1 <= 2;
											counter1 <= 15;
										end
										
										else if(state1 == 2) 
										begin
											NPC_Y_Motion <= -8;//up
											NPC_X_Motion <= -4;
											state1 <= 3;
											counter1 <= 24;
										end
										
										else if(state1 == 3) 
										begin
											NPC_Y_Motion <= -8;
											NPC_X_Motion <= -4;//up
											state1 <= 4;
											counter1 <= 24;
										end
										
										else if(state1 == 4) 
										begin						//stop
											NPC_Y_Motion <= 0;
											NPC_X_Motion <= 0;
																						
											state <= 2;
										end
							
										
								end
							end
					end
					
					else
					begin
						NPC_X_Motion <= 0;
						NPC_Y_Motion <= 0;
					end
					
					NPC_X_Pos <= NPC_X_Pos + NPC_X_Motion; 
					NPC_Y_Pos <= NPC_Y_Pos + NPC_Y_Motion;
		  end
		  
    end
    
	 assign Enemy_state = state; 
	 assign Enemy_state1 = state1;
	 assign Enemy_X = NPC_X_Pos;
	 assign Enemy_Y = NPC_Y_Pos;
	 assign Enemy_Size_X = NPC_SizeX;
	 assign Enemy_Size_Y = NPC_SizeY;
//	 assign Enemy_LifeV = life;
	 
endmodule
