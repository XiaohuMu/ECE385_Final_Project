module  Player ( input Reset, frame_clk,
					input [7:0] keycode,
               output [9:0]  BallX, BallY, BallSX, BallSY );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_SizeX, Ball_SizeY;
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=377;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=31;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=607;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=100;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=451;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 
	 parameter [9:0] Ball_HEIGHT=268;//jump height of the player
	 parameter [9:0] floor=408;//floor
	 parameter [9:0] Left_Edge=116;//Left Edge of the platform
	 parameter [9:0] Right_Edge=523;//right Edge of the platform	 

	 //Player is a rectangle
    assign Ball_SizeX = 28;  
	 assign Ball_SizeY = 62;  
	 // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
        end
           
        else 
        begin 
				 if (( Ball_Y_Pos + Ball_SizeY/2) > Ball_Y_Max)  // Bottom Edge
						Ball_Y_Pos = Ball_Y_Max-Ball_SizeY/2;	
				 if(((Ball_Y_Pos + Ball_SizeY/2) > floor) && ((Ball_X_Pos + Ball_SizeX/2)>=Left_Edge) && ((Ball_X_Pos - Ball_SizeX/2)<=Right_Edge) )// Check if the player is on the platform
						Ball_Y_Pos = floor-Ball_SizeY/2;
				 if ( (Ball_Y_Pos - Ball_SizeY/2) < Ball_Y_Min )  //Top Edge
						Ball_Y_Pos = Ball_Y_Min+Ball_SizeY/2;
				 if ( (Ball_X_Pos + Ball_SizeX/2) > Ball_X_Max )  // Right Edge
						Ball_X_Pos = Ball_X_Max-Ball_SizeX/2;
				 if ( (Ball_X_Pos - Ball_SizeX/2) < Ball_X_Min )  // Left Edge
						Ball_X_Pos = Ball_X_Min+Ball_SizeX/2;	


						
				 case (keycode)
					
					8'h50 : begin

								Ball_X_Motion <= -1.5;//A
								Ball_Y_Motion<= 0;
							  end
					        
					8'h4F : begin
								
					        Ball_X_Motion <= 1.5;//D
							  Ball_Y_Motion <= 0;
							  end

							  
					8'h51 : begin

					        Ball_Y_Motion <= 1.5;//S
							  Ball_X_Motion <= 0;
							 end
							  
					8'h52 : begin
					        Ball_Y_Motion <= -4;//W
							  Ball_X_Motion <= 0;
							 end	  
					default: begin
							if(Ball_Y_Pos<=Ball_HEIGHT)
									Ball_Y_Motion <= 4;
							if(Ball_Y_Pos>=Ball_Y_Center)
								  Ball_Y_Motion <= 0;//Stay still
								  Ball_X_Motion <= 0;
							end
						
			   endcase
				 
				 if ( (Ball_Y_Pos + Ball_SizeY/2) > Ball_Y_Max )  //Bottom
					   Ball_Y_Motion <= 10'd0;				 
					  
				 if ( (Ball_Y_Pos - Ball_SizeY/2) < Ball_Y_Min )  //Top
					   Ball_Y_Motion <= 10'd0;
					  
				 if ( (Ball_X_Pos + Ball_SizeX/2) > Ball_X_Max )  //Right
					  Ball_X_Motion <= 10'd0;  
					  
				 if ( (Ball_X_Pos - Ball_SizeX/2) < Ball_X_Min )  //Left
					  Ball_X_Motion <= 10'd0;

					  
					  
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			

      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallSX = Ball_SizeX;
	 assign BallSY = Ball_SizeY;
    

endmodule