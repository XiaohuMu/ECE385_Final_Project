
module  LIFE1 ( input Reset, frame_clk, 
               output [9:0]  MaskX1, MaskY1 );
    
    logic [9:0] Mask_X_Pos1, Mask_Y_Pos1,Mask_SizeX, Mask_SizeY;
	 
    parameter [9:0] Ball_X_Center1=200;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center1=200;  // Center position on the Y axis
    parameter [9:0] Ball_X_Center2=140;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center2=48;  // Center position on the Y axis

	//10 from each other
    assign Mask_SizeX = 11;  
	 assign Mask_SizeY = 16; 
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				Mask_Y_Pos1 <= Ball_Y_Center1;
				Mask_X_Pos1 <= Ball_X_Center1;
//				Mask_Y_Pos2 <= Ball_Y_Center2;
//				Mask_X_Pos2 <= Ball_X_Center2;
        end
			
		  else
		  begin
			Mask_Y_Pos1 <= Mask_Y_Pos1;
			Mask_X_Pos1 <= Mask_X_Pos1;
		  end
		  
    end
       
    assign MaskX1 = Mask_X_Pos1;
    assign MaskY1 = Mask_Y_Pos1;
	 
//    assign MaskX2 = Mask_X_Pos2;
//    assign MaskY2 = Mask_Y_Pos2;

	 
    assign MaskSX = Mask_SizeX;   
    assign MaskSY = Mask_SizeY;
endmodule
