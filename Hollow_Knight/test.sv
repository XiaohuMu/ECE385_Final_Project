//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module test (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 


      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 7: 0]   VGA_R,
      output   [ 7: 0]   VGA_G,
      output   [ 7: 0]   VGA_B

);




logic pixel_clk, blank, sync;

logic [9:0] DrawX, DrawY;

vga_controller vga_controller_0 (.Clk(MAX10_CLK1_50), .Reset(1'b0), .hs(VGA_HS), .vs(VGA_VS), .pixel_clk, .blank, .sync, .DrawX, .DrawY  );

background_320_240_example background(.vga_clk(pixel_clk), .DrawX, .DrawY, .blank, .red(VGA_R), .green(VGA_G), .blue(VGA_B) );
  
endmoduleVG