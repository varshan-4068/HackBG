return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("fzf-lua").setup({
			winopts = {
				fullscreen = false,
				treesitter = {
					enabled = true,
				},
			},
		})
	end
}
