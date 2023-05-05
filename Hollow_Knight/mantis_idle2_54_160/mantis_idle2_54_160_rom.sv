module mantis_idle2_54_160_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:11199] /* synthesis ram_init_file = "./mantis_idle2_54_160/mantis_idle2_54_160.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
