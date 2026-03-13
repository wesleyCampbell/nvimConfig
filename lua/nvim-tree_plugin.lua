local _plugin__nvim_tree_opts = {
	-- SORT CONFIG
	sort = {
	sorter = "case_sensitive",
	},

	-- VIEWPORT CONFIG
	view = {
	width = 45,
	signcolumn = "yes",
	},

	-- RENDER CONFIG
	renderer = {
	group_empty = true,
	highlight_git = true,
	highlight_opened_files = "all",
	indent_markers = {
	icons = {
		corner = "└",
		edge = "│",
		item = "│",
		none = " ",
	},
	},
	icons = {
	show = {
		git = true,
		folder = true,
		file = true,
		folder_arrow = true,
	},
	glyphs = {
		folder = {
		  default = "",
		  open = "",
		  empty = "",
		  empty_open = "",
		  symlink = "",
		},
		git = {
		  unstaged = "✗",
		  staged = "✓",
		  unmerged = "",
		  renamed = "➜",
		  untracked = "★",
		  deleted = "",
		  ignored = "◌",
		},
	  },
	},
	},


	-- GIT INTEGRATION
	git = {
	enable = true,
	ignore = false,
	timeout = 400,
	},

	-- FILTERS
	filters = {
	dotfiles = true,   -- Show dotfiles
	},
}

local _plugin__nvim_tree = {
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  dependencies = {
		"nvim-tree/nvim-web-devicons",
	  },
	  config = function()
		require("nvim-tree").setup(_plugin__nvim_tree_opts) 
	  end,
}

local _plugin_dep__nvim_web_devicons = {
	"nvim-tree/nvim-web-devicons",
	opts = {}
}

return {
	nvim_tree_config = _plugin__nvim_tree,
	nvim_tree_dep__nvim_web_devicons = _plugin_dep__nvim_web_devicons
}
