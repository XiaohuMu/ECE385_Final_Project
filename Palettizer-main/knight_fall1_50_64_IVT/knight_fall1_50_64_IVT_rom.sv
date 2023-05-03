module knight_fall1_50_64_IVT_rom (
	input logic clock,
	input logic [11:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:3199] /* synthesis ram_init_file = "./knight_fall1_50_64_IVT/knight_fall1_50_64_IVT.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
