return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { 'bash', 'html', 'css', 'javascript', 'python', 'java', 'lua' },
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true, },
	},
}
