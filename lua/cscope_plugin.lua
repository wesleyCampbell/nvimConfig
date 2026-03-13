local _plugin__cscope_config = {
	  "dhananjaylatkar/cscope_maps.nvim",
	  dependencies = {
	    "folke/snacks.nvim", -- optional [for picker="snacks"]
	  },
	  opts = {
	    -- USE EMPTY FOR DEFAULT OPTIONS
	    -- DEFAULTS ARE LISTED BELOW
	    prefix = "<leader>c",
	  },
	  config = function()
		  require("cscope_maps").setup()
	  end
}

local _plugin_dep__snacks_config = {
	  "folke/snacks.nvim",
	  ---@type snacks.Config
	  opts = {
	      cscope = {
		picker = 'snacks', -- snacks.picker (alternative: telescope)
		picker_opts = {
		  ---@class snacks.picker.Config
		  snacks = {
		    -- layout = 'vertical', -- Use "vertical" or "horizontal" if you want to use presets
		    ---@class snacks.picker.layout.Config
		    layout = {
		      layout = {
			height = 0.85, -- Take up 85% of the total height
			width = 0.9, -- Take up 90% of the total width (adjust as needed)
			box = 'horizontal', -- Horizontal layout (input and list on the left, preview on the right)
			{ -- Left side (input and list)
			  box = 'vertical',
			  width = 0.6, -- List and input take up 60% of the width
			  border = 'rounded',
			  { win = 'input', height = 1, border = 'bottom' },
			  { win = 'list', border = 'none' },
			},
			{ win = 'preview', border = 'rounded', width = 0.4 }, -- Preview window takes up 40% of the width
		      },
		    },
		    ---@class snacks.picker.win.Config
		    win = {
		      preview = {
			wo = { wrap = true },
		      },
		    },
		  }, -- snacks
		}, -- picker_opts
	      }, -- cscope
	 },
}

return {
	cscope_config = _plugin__cscope_config,
	cscope_dep__snacks_config = _plugin_dep__snacks_config
}
