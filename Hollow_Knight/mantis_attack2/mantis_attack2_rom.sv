module mantis_attack2_rom (
	input logic clock,
	input logic [14:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:18815] /* synthesis ram_init_file = "./mantis_attack2/mantis_attack2.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
