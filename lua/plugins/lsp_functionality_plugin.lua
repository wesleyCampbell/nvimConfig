local _plugin__blink_cmp_config = {
	  'saghen/blink.cmp',
	  -- optional: provides snippets for the snippet source
	  dependencies = { 'rafamadriz/friendly-snippets' },

	  -- use a release tag to download pre-built binaries
	  version = '1.*',
	  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	  -- build = 'cargo build --release',
	  -- If you use nix, you can build from source using latest nightly rust with:
	  -- build = 'nix run .#build-plugin',

	  ---@module 'blink.cmp'
	  ---@type blink.cmp.Config
	  opts = {
	    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	    -- 'super-tab' for mappings similar to vscode (tab to accept)
	    -- 'enter' for enter to accept
	    -- 'none' for no mappings
	    --
	    -- All presets have the following mappings:
	    -- C-space: Open menu or open docs if already open
	    -- C-n/C-p or Up/Down: Select next/previous item
	    -- C-e: Hide menu
	    -- C-k: Toggle signature help (if signature.enabled = true)
	    --
	    -- See :h blink-cmp-config-keymap for defining your own keymap
	    keymap = { preset = 'super-tab' },

	    appearance = {
	      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	      -- Adjusts spacing to ensure icons are aligned
	      nerd_font_variant = 'mono'
	    },

	    -- (Default) Only show the documentation popup when manually triggered
	    completion = { documentation = { auto_show = false } },

	    -- Default list of enabled providers defined so that you can extend it
	    -- elsewhere in your config, without redefining it, due to `opts_extend`
	    sources = {
	      default = { 'lsp', 'path', 'snippets', 'buffer' },
	    },

	    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	    --
	    -- See the fuzzy documentation for more information
	    fuzzy = { implementation = "prefer_rust_with_warning" }
	  },
	  opts_extend = { "sources.default" }
}

local _plugin__lspconfig_config = {
	  'neovim/nvim-lspconfig',
	  dependencies = { 'saghen/blink.cmp' },

	  -- example using `opts` for defining servers
	  -- opts = {
	  --   servers = {
	  --     pyright = {},
	  --     clangd = {},
	  --     perlpls = {},
	  --     jsonls = {}
	  --  }
	  -- },
	  -- config = function(_, opts)
	  --   local lspconfig = require('lspconfig')
	  --   for server, config in pairs(opts.servers) do
	  --     -- passing config.capabilities to blink.cmp merges with the capabilities in your
	  --     -- `opts[server].capabilities, if you've defined it
	  --     config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
	  --     lspconfig[server].setup(config)
	  --   end
	  -- end
} 

local _plugin__nvim_treesitter_opts = {
	-- A list of parser names, or "all" (the listed parsers MUST always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cpp", "python", "perl" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
	enable = true,

	-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
	-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
	-- the name of the parser)
	-- list of language that will be disabled
	disable = { "rust" },
	-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
	disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,

	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false,
	}
}

local _plugin__nvim_treesitter_config = {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	lazy = false,
	build = ":TSUpdate",
	config = function ()
		require('nvim-treesitter.configs').setup(_plugin__nvim_treesitter_opts)
	end	
}

return {
	_plugin__blink_cmp_config,
	_plugin__lspconfig_config,
	_plugin__nvim_treesitter_config,
}

