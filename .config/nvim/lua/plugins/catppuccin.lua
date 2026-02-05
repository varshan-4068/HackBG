return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = true,
			flavour = "mocha",
			color_overrides = {
				mocha = {
					base = "#0f0f0f",
					mantle = "#0f0f0f",
					surface0 = "#3e4451",
					surface1 = "#545862",
					surface2 = "#565c64",
					text = "#cdd6f4",
					rosewater = "#b6bdca",
					lavender = "#c8ccd4",
					red = "#ff9999",
					peach = "#fab371",
					yellow = "#fff999",
					green = "#3cb371",
					teal = "#008080",
					blue = "#c0c0c0",
					mauve = "#c680dd",
					flamingo = "#f38b28",
					maroon = "#e06c75",
					sky = "#d19a66",
					pink = "#f38bb8",
					subtext0 = "#A6ADC8",
					overlay2 = "#9399B2",
					overlay1 = "#7F849C",
					overlay0 = "#6C7086",
					crust = "#11111B",
				},
			},
			custom_highlights = function(colors)
				return {
					-- comment
					Comment = { fg = colors.overlay2 },
					-- Lazy
					LazyNormal = { bg = "NONE", fg = colors.text },
					-- Mason
					MasonNormal = { bg = "NONE", fg = colors.text },
					-- fzf
					FzfLuaNormal = { bg = "NONE" },
					FzfLuaBorder = { bg = "NONE" },
					FzfLuaTitle = { bg = "NONE" },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight CmpItemAbbrDeprecated guibg=NONE guifg=#f38ba8 cterm=strikethrough]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight CmpItemAbbrMatch guibg=NONE guifg=#c999dd]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight NeoTreeWinSeparator guibg=NONE guifg=#ffffff]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight BufferLineOffsetSeparator guibg=NONE guifg=#ffffff]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight CmpItemKindVariable guibg=NONE guifg=#ff8888]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight CmpItemKindFunction guibg=NONE guifg=#e06c75]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight CmpItemKindKeyword guibg=NONE guifg=#3cb371]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight PmenuSel guibg=#ff6666 guifg=#000000]]
			end,
		})
		vim.api.nvim_create_autocmd('ColorScheme', {
			callback = function()
				vim.cmd [[highlight Visual guibg=#ff6666 guifg=#000000]]
			end,
		})
	end
}
