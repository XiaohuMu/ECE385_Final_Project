module fireball_60_26_rom (
	input logic clock,
	input logic [10:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:1559] /* synthesis ram_init_file = "./fireball_60_26/fireball_60_26.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
