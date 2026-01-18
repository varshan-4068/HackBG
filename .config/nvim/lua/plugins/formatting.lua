return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				typescript = { "prettier" },
				cpp = { "clang-format" },
				bash = { "shfmt" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format({
				lsp_fallback = true,
				async = true,
			})
		end)
	end
}
