
module  LIFE ( input Reset, frame_clk, 
               output [9:0]  MaskX1, MaskY1, MaskX2, MaskX3, MaskX4, MaskX5,
					MaskSX, MaskSY );
    
    logic [9:0] Mask_X_Pos1,Mask_X_Pos2, Mask_X_Pos3, Mask_X_Pos4, Mask_X_Pos5, Mask_Y_Pos1,Mask_SizeX, Mask_SizeY;
	 
    parameter [9:0] Ball_X_Center1=96;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center1=48;  // Center position on the Y axis
    parameter [9:0] Ball_X_Center2=118;  // Center position on the X axis
	 parameter [9:0] Ball_X_Center3=140;  // Center position on the X axis
	 parameter [9:0] Ball_X_Center4=162;  // Center position on the X axis
	 parameter [9:0] Ball_X_Center5=184;  // Center position on the X axis

	//10 from each other
    assign Mask_SizeX = 11;  
	 assign Mask_SizeY = 16; 
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
				Mask_Y_Pos1 <= Ball_Y_Center1;
				Mask_X_Pos1 <= Ball_X_Center1;
				Mask_X_Pos2 <= Ball_X_Center2;
				Mask_X_Pos3 <= Ball_X_Center3;
				Mask_X_Pos4 <= Ball_X_Center4;
				Mask_X_Pos5 <= Ball_X_Center5;
        end
			
		  else
		  begin
			Mask_Y_Pos1 <= Mask_Y_Pos1;
			Mask_X_Pos1 <= Mask_X_Pos1;
			Mask_X_Pos2 <= Mask_X_Pos2;
			Mask_X_Pos3 <= Mask_X_Pos3;
			Mask_X_Pos4 <= Mask_X_Pos4;
			Mask_X_Pos5 <= Mask_X_Pos5;
		  end
		  
    end
       
    assign MaskX1 = Mask_X_Pos1;
	 assign MaskX2 = Mask_X_Pos2;
	 assign MaskX3 = Mask_X_Pos3;
	 assign MaskX4 = Mask_X_Pos4;
	 assign MaskX5 = Mask_X_Pos5;
    assign MaskY1 = Mask_Y_Pos1;
	 

	 
    assign MaskSX = Mask_SizeX;   
    assign MaskSY = Mask_SizeY;
endmodule
