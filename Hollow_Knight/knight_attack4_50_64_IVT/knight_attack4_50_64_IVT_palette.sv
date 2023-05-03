module knight_attack4_50_64_IVT_palette (
	input logic [2:0] index,
	output logic [3:0] red, green, blue
);

localparam [0:7][11:0] palette = {
	{4'hD, 4'h0, 4'h1},
	{4'hE, 4'hF, 4'hE},
	{4'h0, 4'h0, 4'h0},
	{4'h3, 4'h3, 4'h6},
	{4'h1, 4'h2, 4'h3},
	{4'h0, 4'h0, 4'h1},
	{4'hE, 4'hF, 4'hE},
	{4'hE, 4'hF, 4'hE}
};

assign {red, green, blue} = palette[index];

endmodule
