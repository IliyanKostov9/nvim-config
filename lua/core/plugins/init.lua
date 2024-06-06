return {
	require("core.plugins.telescope"),
	-- Setup nvim java before lspconfig!!
	require("core.plugins.nvim-java"),
	require("core.plugins.lspconfig"),
	require("core.plugins.conform"),
	require("core.plugins.cmp"),
	require("core.plugins.mini"),
	require("core.plugins.treesitter"),
}
