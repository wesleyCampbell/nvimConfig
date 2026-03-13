local _java_jdtls_config = {
	'nvim-java/nvim-java',
	config = function()
		requre('java').setup()
		vim.lsp.enable("jdtls")
	end
}

return {
	java_jdtls_config = _java_jdtls_config,
}
