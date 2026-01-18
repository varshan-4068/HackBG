return {
	'code-biscuits/nvim-biscuits',
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('nvim-biscuits').setup({
			default_config = { prefix_string = " ✨" },
			toggle_keybind = "<leader>b",
			show_on_start = false,
			vim.cmd [[ 
				colorscheme catppuccin
				highlight BiscuitColor guifg=#c0c0c0 gui=italic
			]]
		})
	end
}
