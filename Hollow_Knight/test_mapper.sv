


module  test_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_sizeX, Ball_sizeY,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	  
    int DistX, DistY, SizeX, SizeY;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign SizeX = Ball_sizeX;
	 assign SizeY = Ball_sizeY;
	  
 always_comb
     begin:Ball_on_proc
			if((DistX*DistX<=SizeX*SizeX/4) &&(DistY*DistY<=SizeY*SizeY/4))
				ball_on = 1'b1;
			else 
            ball_on = 1'b0;
     end
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
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
