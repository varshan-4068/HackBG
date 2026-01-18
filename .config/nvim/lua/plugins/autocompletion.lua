return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			build = (function()
				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
					return
				end
				return 'make install_jsregexp'
			end)(),
		},
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-buffer',
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local cmp = require 'cmp'
		require('luasnip.loaders.from_vscode').lazy_load()
		local luasnip = require 'luasnip'
		luasnip.config.setup {}
		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					border = 'rounded',
					scrollbar = false,
				},
				documentation = {
					border = 'rounded'
				},
			},
			view = {
				entries = { name = 'custom' }
			},
			mapping = cmp.mapping.preset.insert {
				['<C-j>'] = cmp.mapping.select_next_item(),   -- Select the [n]ext item
				['<C-k>'] = cmp.mapping.select_prev_item(),   -- Select the [p]revious item
				['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept the completion with Enter.
				['<C-c>'] = cmp.mapping.complete {},          -- Manually trigger a completion from nvim-cmp.

				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
			},
			formatting = {
				format = function(entry, vim_item)
					local max_width = 45
					if #vim_item.abbr > max_width then
						vim_item.abbr = vim_item.abbr:sub(1, max_width - 3) .. "..."
					end
					return vim_item
				end,
			},

			-- Uncomment below lines to use autocompletions for command line in nvim
			--
			-- cmp.setup.cmdline('/', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = 'buffer' }
			-- 	}
			-- }),
			--
			-- cmp.setup.cmdline(':', {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = 'path' }
			-- 	}, {
			-- 		{ name = 'cmdline' }
			-- 	}),
			-- 	matching = { disallow_symbol_nonprefix_matching = false }
			-- }),
		}
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.sh",
			callback = function() vim.bo.filetype = "sh" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.txt",
			callback = function() vim.bo.filetype = "text" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile","BufWritePost" }, {
			pattern = "*.md",
			callback = function() vim.bo.filetype = "markdown" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.conf",
			callback = function() vim.bo.filetype = "conf" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.py",
			callback = function() vim.bo.filetype = "python" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.jsonc",
			callback = function() vim.bo.filetype = "jsonc" end,
		})
		vim.api.nvim_create_autocmd({ "bufRead", "BufNewFile" }, {
			pattern = "*.lua",
			callback = function() vim.bo.filetype = "lua" end,
		})
	end,
}
