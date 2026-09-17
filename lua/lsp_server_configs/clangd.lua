local clangd_config = {
  cmd = { "clangd" },  -- You can specify extra flags here
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  -- root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  root_markers = {
	  "compile_commands.json",
	  "compile_flags.txt",
	  ".git",
  },

  on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
}

return {
	name = "clangd",
	config = clangd_config,
}
