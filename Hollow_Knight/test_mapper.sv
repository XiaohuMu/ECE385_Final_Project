


module  test_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_sizeX, Ball_sizeY,
							 input				[9:0] BallX1, BallY1, Ball_sizeX1, Ball_sizeY1,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, ball_on1;
	  
    int DistX, DistY, SizeX, SizeY;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign SizeX = Ball_sizeX;
	 assign SizeY = Ball_sizeY;
	 
    int DistX1, DistY1, SizeX1, SizeY1;
	 assign DistX1 = DrawX - BallX1;
    assign DistY1 = DrawY - BallY1;
    assign SizeX1 = Ball_sizeX1;
	 assign SizeY1 = Ball_sizeY1;
	  
 always_comb
     begin:Ball_on_proc
			if((DistX*DistX<=SizeX*SizeX/4) &&(DistY*DistY<=SizeY*SizeY/4))
				ball_on = 1'b1;
			else 
            ball_on = 1'b0;
     end

 always_comb
     begin:Ball_on_proc1
			if((DistX1*DistX1<=SizeX1*SizeX1/4) &&(DistY1*DistY1<=SizeY1*SizeY1/4))
				ball_on1 = 1'b1;
			else 
            ball_on1 = 1'b0;
     end
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
            Blue = 8'h00;
        end 
		  
        else if ((ball_on1 == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
        end 
				
				
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 
    
endmodule
