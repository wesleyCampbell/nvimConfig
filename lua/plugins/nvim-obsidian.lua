local nvimObsidianConfig = {
  "obsidian-nvim/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. vim.fn.expand "~" .. "/Notes/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Notes/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
	"folke/snacks.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Education",
        path = "~/Notes/Education",
      },
      {
        name = "Personal",
        path = "~/Notes/Personal",
      },
      {
        name = "Gospel",
        path = "~/Notes/Gospel",
      },
    },

	picker = {
		name = "snacks.picker",
		-- name = "telescope.nvim"
	},

	notes_subdir = "Notes",

	legacy_commands = false,

	new_notes_location = "notes_subdir",

	-- preferred_link_style = "wiki",
	-- link.style = "wiki",

	-- disable_frontmatter = false,
	-- frontmatter = "enabled",

	templates = {
		folder = "Assets/Templates",
		date_format = "%Y-%m-%d",
	},
    -- see below for full list of options 👇
  },
}

local obsidianBridge = {
  "oflisback/obsidian-bridge.nvim",
  dependencies = { 
	  "nvim-telescope/telescope.nvim",
	  "folke/snacks.nvim",
  },

  opts = {
	obsidian_server_address = "https://127.0.0.1:27124",
	scroll_sync = false,
	cert_path = "~/.ssl/obsidian.crt",
	picker = "snacks",
	warnings = true,
  },
  event = {
    "BufReadPre *.md",
    "BufNewFile *.md",
  },
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  event = {
	"BufReadPre *.md",
	"BufNewFile *.md",
  },

  lazy = true,
}

function obsidianConf() 
	vim.opt.conceallevel = 1
end

return {
	nvimObsidianConfig,
	obsidianBridge,
	configFunc = obsidianConf,
}
