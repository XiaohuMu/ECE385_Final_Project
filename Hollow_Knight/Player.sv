module  Player ( input Reset, frame_clk,
					input [7:0] keycode,
               output [9:0]  PlayerX, PlayerY, Player_Size_X, Player_Size_Y, 
					output [3:0]  Player_Status,
					output Inverse);
    
    logic [9:0] Knight_X_Pos, Knight_X_Motion, Knight_Y_Pos, Knight_Y_Motion, Knight_SizeX, Knight_SizeY;
	 logic [3:0] status; //0 is idle, 1 is walk, 2 is jump up, 3 for down
	 logic Knight_Inverse; //0 is right, 1 is left
	 
    parameter [9:0] Knight_X_Center=320;  // Center position on the X axis
    parameter [9:0] Knight_Y_Center=377;  // Center position on the Y axis
    parameter [9:0] Knight_X_Min=31;       // Leftmost point on the X axis
    parameter [9:0] Knight_X_Max=607;     // Rightmost point on the X axis
    parameter [9:0] Knight_Y_Min=100;       // Topmost point on the Y axis
    parameter [9:0] Knight_Y_Max=451;     // Bottommost point on the Y axis
	 
	 parameter [9:0] JUMP_HEIGHT=268;//jump height of the player
	 parameter [9:0] floor=408;//floor
	 parameter [9:0] Left_Edge=116;//Left Edge of the platform
	 parameter [9:0] Right_Edge=523;//right Edge of the platform	
	
	

	 //Player is a rectangle
    assign Knight_SizeX = 30;  
	 assign Knight_SizeY = 62;  
	 // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Knight_Y_Motion <= 10'd0; //Ball_Y_Step;
				Knight_X_Motion <= 10'd0; //Ball_X_Step;
				Knight_Y_Pos <= Knight_Y_Center;
				Knight_X_Pos <= Knight_X_Center;
				status <=0;
				Knight_Inverse <= 0;
        end
           
        else 
        begin 	

				 if (( Knight_Y_Pos + Knight_SizeY/2) > Knight_Y_Max)  // Bottom Edge
						Knight_Y_Pos = Knight_Y_Max-Knight_SizeY/2;	
						
				 if(((Knight_Y_Pos + Knight_SizeY/2) > floor) 
				 && ((Knight_X_Pos + Knight_SizeX/2)>=Left_Edge) 
				 && ((Knight_X_Pos - Knight_SizeX/2)<=Right_Edge) )// Check if the player is on the platform
						Knight_Y_Pos = floor-Knight_SizeY/2;
						
				 if ( (Knight_Y_Pos - Knight_SizeY/2) < Knight_Y_Min )  //Top Edge
						Knight_Y_Pos = Knight_Y_Min+Knight_SizeY/2;
				 if ( (Knight_X_Pos + Knight_SizeX/2) > Knight_X_Max )  // Right Edge
						Knight_X_Pos = Knight_X_Max-Knight_SizeX/2;
				 if ( (Knight_X_Pos - Knight_SizeX/2) < Knight_X_Min )  // Left Edge
						Knight_X_Pos = Knight_X_Min+Knight_SizeX/2;	


						
				 case (keycode)
					
					8'h50 : begin

								Knight_X_Motion <= -1.5;//Left 
								Knight_Y_Motion<= 0;
								status <= 1;//walk
								Knight_Inverse = 1;
							  end
					        
					8'h4F : begin
								
					        Knight_X_Motion <= 1.5;//Right
							  Knight_Y_Motion <= 0;
							  status <= 1;//walk
							  Knight_Inverse = 0;
							  end

							  
					8'h51 : begin

					        Knight_Y_Motion <= 6;//Down
							  Knight_X_Motion <= 0;
							  status <= 2;
							 end
							  
					8'h52 : begin
					        Knight_Y_Motion <= -6;//Jump
							  Knight_X_Motion <= 0;
							  status <= 2;
							 end	  
							 
					default: begin
							if(Knight_Y_Pos<=JUMP_HEIGHT) begin//when it achieve its height it falls back
									Knight_Y_Motion <= 6;
									status <= 3;
							end
							
							if(((Knight_Y_Pos + Knight_SizeY/2) >= floor)&&
							(Knight_Y_Pos>=Knight_Y_Center 
							&& ((Knight_X_Pos + Knight_SizeX/2)>=Left_Edge) 
							&& ((Knight_X_Pos - Knight_SizeX/2)<=Right_Edge))) begin//When it reach the floor
								  Knight_Y_Motion <= 0;
								  Knight_X_Motion <= 0;
								  status <= 0;	
							end
								
							if	(Knight_Y_Motion == 0) begin//Stay still
								 Knight_X_Motion <= 0;
								 Knight_Y_Motion <= 0;
								 status <=0;
							end
							
							end
						
			   endcase
				
				 if(((Knight_Y_Pos + Knight_SizeY/2) >= floor)
				 &&(((Knight_X_Pos + Knight_SizeX/2)<=Left_Edge) || ((Knight_X_Pos - Knight_SizeX/2)>=Right_Edge))) begin
						Knight_Y_Motion <= 10'd6;
						Knight_X_Motion <= 10'd0;
						status <= 3;
				 end
				 if ( (Knight_Y_Pos + Knight_SizeY/2) > Knight_Y_Max )  //Bottom
					   Knight_Y_Motion <= 10'd0;				 
					  
				 if ( (Knight_Y_Pos - Knight_SizeY/2) < Knight_Y_Min )  //Top
					   Knight_Y_Motion <= 10'd0;
					  
				 if ( (Knight_X_Pos + Knight_SizeX/2) > Knight_X_Max )  //Right
					   Knight_X_Motion <= 10'd0;  
					  
				 if ( (Knight_X_Pos - Knight_SizeX/2) < Knight_X_Min )  //Left
					   Knight_X_Motion <= 10'd0;

					  
					  
				 Knight_Y_Pos <= (Knight_Y_Pos + Knight_Y_Motion);  // Update ball position
				 Knight_X_Pos <= (Knight_X_Pos + Knight_X_Motion);
			
			

      
			
		end  
    end
       
    assign PlayerX = Knight_X_Pos;
    assign PlayerY = Knight_Y_Pos;
   
    assign Player_Size_X = Knight_SizeX;
	 assign Player_Size_Y = Knight_SizeY;
	 assign Player_Status = status;
	 assign Inverse = Knight_Inverse;
    

endmodule