module knight_jump_30_40_rom (
	input logic clock,
	input logic [10:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:1199] /* synthesis ram_init_file = "./knight_jump_30_40/knight_jump_30_40.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
