

module Hollow_Knight (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 7: 0]   VGA_R,
      output   [ 7: 0]   VGA_G,
      output   [ 7: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesigx, ballsizesigy;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	logic [3:0] status,life;
	logic inverse;
	logic [9:0] MX1,MX2,MX3, MX4, MX5, MY1, MSX, MSY;	
	logic [9:0] enemyV_X, enemyV_Y, enemyV_SizeX, enemyV_SizeY, enemy_state, enemy_state1, enemy_state2,enemy_stateH;
	logic [9:0] enemyH_X, enemyH_Y, enemyH_SizeX, enemyH_SizeY;
//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit

	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	Hollow_Knightsoc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
	 );



//instantiate a vga_controller, ball, and color_mapper here with the ports.

vga_controller vga1(         			  .Clk(MAX10_CLK1_50),       // 50 MHz clock
                                      .Reset(Reset_h),     // reset signal
												  .hs(VGA_HS),        // Horizontal sync pulse.  Active low
								              .vs(VGA_VS),        // Vertical sync pulse.  Active low
												  .pixel_clk(VGA_Clk), // 25 MHz pixel clock output
												  .blank(blank),     // Blanking interval indicator.  Active low.
												  .sync(sync),      // Composite Sync signal.  Active low.  We don't use it in this lab,
												             //   but the video DAC on the DE2 board requires an input for it.
												  .DrawX(drawxsig),     // horizontal coordinate
								              .DrawY(drawysig) ); 

												  
LIFE Life1( .Reset (Reset_h),
				.frame_clk(VGA_VS),
				.MaskX1(MX1),
				.MaskX2(MX2),
				.MaskX3(MX3),
				.MaskX4(MX4),
				.MaskX5(MX5),
				.MaskY1(MY1),
				.MaskSX(MSX),
				.MaskSY(MSY)
				);		

Player player1( .Reset(Reset_h),
				.frame_clk(VGA_VS),
				.keycode(keycode),
            .PlayerX(ballxsig), 
				.PlayerY(ballysig), 
				.Player_Size_X(ballsizesigx),
				.Player_Size_Y(ballsizesigy),
				.Player_Status(status),
				.Player_Life(life),
				.Inverse(inverse));



player_mapper color1(.vga_clk(VGA_Clk),
							.frame_clk(VGA_VS),
							.Player_Status(status),
							.Player_Life(life),
							.Player_X(ballxsig), 
							.Player_Y(ballysig),
							
							.MaskX1(MX1),
							.MaskX2(MX2),
							.MaskX3(MX3),
							.MaskX4(MX4),
							.MaskX5(MX5),
							.MaskY1(MY1),
							.MaskSX(MSX),
							.MaskSY(MSY),
							
							.EnemyV_X(enemyV_X),
							.EnemyV_Y(enemyV_Y),
							.EnemyV_Size_X(enemyV_SizeX),
							.EnemyV_Size_Y(enemyV_SizeY),
							
							.EnemyH_X(enemyH_X),
							.EnemyH_Y(enemyH_Y),
							.EnemyH_Size_X(enemyH_SizeX),
							.EnemyH_Size_Y(enemyH_SizeY),
							.Enemy_stateH(enemy_stateH),
							
							.Enemy_state(enemy_state),
							.Enemy_state1(enemy_state1),
							.Enemy_state2(enemy_state2),
							
							.DrawX(drawxsig), 
							.DrawY(drawysig), 
							.Player_SizeX(ballsizesigx),
							.Player_SizeY(ballsizesigy),
							.blank(blank),
							.Inverse(inverse),
                     .Red(Red), 
							.Green(Green), 
							.Blue(Blue) );

NPC_V NPCV1 ( .Reset(Reset_h), 
							.frame_clk(VGA_VS),
//					input [3:0]  Player_Status,
					      .keycode(keycode),
							.Enemy_stateH(enemy_stateH),
//					Enemy_LifeH,
//					output Enemy_hurt,
//					output [3:0] Enemy_LifeV,
							.Enemy_X(enemyV_X), 
							.Enemy_Y(enemyV_Y), 
							.Enemy_Size_X(enemyV_SizeX),
							.Enemy_state(enemy_state),
							.Enemy_state1(enemy_state1),
							.Enemy_state2(enemy_state2),
							.Enemy_Size_Y(enemyV_SizeY));	

NPC_H NPCH1 ( .Reset(Reset_h), 
							.frame_clk(VGA_VS),
							.Enemy_stateV(enemy_state),
//							.Enemy_stateV2(enemy_state2),
//					input [3:0]  Player_Status,
//					Enemy_LifeH,
//					output Enemy_hurt,
//					output [3:0] Enemy_LifeV,
							.Enemy_state(enemy_stateH),
							.Enemy_X(enemyH_X), 
							.Enemy_Y(enemyH_Y), 
							.Enemy_Size_X(enemyH_SizeX),
							.Enemy_Size_Y(enemyH_SizeY));	
//
//test_mapper color1(	.BallX(enemyV_X), 
//							.BallY(enemyV_Y), 
//							.DrawX(drawxsig), 
//							.DrawY(drawysig), 
//							.Ball_sizeX(enemyV_SizeX),
//							.Ball_sizeY(enemyV_SizeY),
//							.BallX1(enemyH_X), 
//							.BallY1(enemyH_Y),
//							.Ball_sizeX1(enemyH_SizeX),
//							.Ball_sizeY1(enemyH_SizeY),							
//                     .Red(Red), 
//							.Green(Green), 
//							.Blue(Blue) );							

endmodule
