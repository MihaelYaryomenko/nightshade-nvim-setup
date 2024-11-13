require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {"lua_ls", "clangd", "ast_grep", "eslint"}
})

require"lspconfig".eslint.setup{}

require"lspconfig".ast_grep.setup({
	ft = { "js" },
})

require("gcompilecommands").setup({
	opts = {
		tmp_file_path = "$HOME/tmp/compilecommandsNEOVIM.json"
	},
	ft = { "c", "cpp" }, -- lazy load plugin only on C and C++ filetypes
})

require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}

require'lspconfig'.clangd.setup{}

local lspconfig = require('lspconfig')
lspconfig.clangd.setup({
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
})

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

	
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
require('lspconfig').clangd.setup {
  capabilities = capabilities,
  ...  -- other lspconfig configs
}


require("luasnip.loaders.from_vscode").lazy_load()

local lspconfig = require('lspconfig')

local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-o>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})
