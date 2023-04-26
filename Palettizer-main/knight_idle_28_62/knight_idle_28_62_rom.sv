module knight_idle_28_62_rom (
	input logic clock,
	input logic [10:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:1735] /* synthesis ram_init_file = "./knight_idle_28_62/knight_idle_28_62.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
