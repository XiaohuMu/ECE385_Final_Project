module mantis_idle_31_156_rom (
	input logic clock,
	input logic [12:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:4835] /* synthesis ram_init_file = "./mantis_idle_31_156/mantis_idle_31_156.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
