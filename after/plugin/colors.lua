function enableTrans(color)
	color = color or "catppuccin-mocha"
	vim.cmd.colorscheme(color)
	
	vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
	vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

function disableTrans(color)
	color = color or "catppuccin-mocha"
	vim.cmd.colorscheme(color)
end
