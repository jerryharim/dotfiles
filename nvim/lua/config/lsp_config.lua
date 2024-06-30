require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"lua-language-server"}
})

-- Set up servers via lspconfig
require("lspconfig").lua_ls.setup {}
require("lspconfig").svelte.setup {}
