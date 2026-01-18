return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "cssls", "html", "ts_ls", "clangd", "bashls","markdown_oxide" }
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config('lua_ls',{
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'opts', 'vim' },
						},
					},
				},
			})
			vim.lsp.config('eslint',{})
			vim.lsp.config('stylelint',{})
			vim.lsp.config('pyright',{})
			vim.lsp.config('html',{})
			vim.lsp.config('bashls',{})
			vim.lsp.config('markdown_oxide',{})
			vim.lsp.config('cssls',{})
			vim.lsp.config('ccls',{})
			vim.lsp.config('ts_ls',{})
			vim.lsp.config('lua_ls',{})
		end
	},
	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = false,
		update_in_insert = false,
	})
}
