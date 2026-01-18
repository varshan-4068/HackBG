return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	opts = {},
	config = function()
		require('render-markdown').setup({
			completions = { lsp = { enabled = true } },
			latex = { enabled = false }
			-- max_file_size = 10.0,
		})
	end,
}
