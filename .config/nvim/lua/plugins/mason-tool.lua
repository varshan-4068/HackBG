return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = { "eslint_d", "black", "clang-format", "stylelint", "prettier", "markdown_oxide", "shfmt", "htmlhint", "pylint", "stylua" },
			auto_update = false,
			run_on_start = true,
		})
	end,
}
