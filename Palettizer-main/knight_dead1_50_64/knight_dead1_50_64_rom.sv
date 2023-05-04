module knight_dead1_50_64_rom (
	input logic clock,
	input logic [11:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:3199] /* synthesis ram_init_file = "./knight_dead1_50_64/knight_dead1_50_64.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
