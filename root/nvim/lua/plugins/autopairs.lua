return {
	'windwp/nvim-autopairs',
	config = function()
		require('nvim-autopairs').setup({
			check_ts = true,
			map_cr = true,
			map_bs = true,

			chars = { '{', '[', '(', '"', "'" },
			pattern = string.gsub([[ [%'%"%(%{%[] ]], '%s+', ''),
			offset = 0,
			end_key = '$'
		})
	end
}
