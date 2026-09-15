_complete_config = {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    -- config = function()
    --     require("nvim-surround").setup({
    --         -- Put your configuration here
    --     })
    -- end
}

function _loadCustomSurrounds() 
	require("nvim-surround").buffer_setup({
		surrounds = {
			["$"] = {
				add = { "${", "}" },
				find = "$%b{}",
				delete = "^(..)().-(.)()$",
			},
		},
	})	
end

return {
	_complete_config,
	configFunc = _loadCustomSurrounds
}

