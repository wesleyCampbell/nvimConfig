local lspconfig = require("lspconfig")

local jdtls_config = {
	root_dir = lspconfig.util.root_pattern(
		"pom.xml",
		".git"
	),
}

return {
	name = "jdtls",
	config = jdtls_config,
}
