module HP_12_16_1_rom (
	input logic clock,
	input logic [7:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:191] /* synthesis ram_init_file = "./HP_12_16_1/HP_12_16_1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
