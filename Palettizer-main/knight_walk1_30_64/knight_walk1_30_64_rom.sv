module knight_walk1_30_64_rom (
	input logic clock,
	input logic [10:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:1919] /* synthesis ram_init_file = "./knight_walk1_30_64/knight_walk1_30_64.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
