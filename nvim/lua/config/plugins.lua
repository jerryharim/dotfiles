-- Plugin manager : 
-- Lazy.nvim : https://github.com/folke/lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
  -- COLORSCHEME

  -- tokyodark
  { "tiagovla/tokyodark.nvim" },

  -- moonfly
  { 
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000
  },

  -- for KDL file (zellij)
  { "imsnif/kdl.vim", event = "BufReadPre *.kdl" },


  -- NERD TREE
  "preservim/nerdtree",
  "ryanoasis/vim-devicons",

  -- Icons
  "nvim-tree/nvim-web-devicons",

  -- Telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-telescope/telescope-fzf-native.nvim", -- FZF sorter for telescope written in c
      "nvim-treesitter/nvim-treesitter"
    }
  },


  -- Bottom section
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  "nvim-lua/lsp-status.nvim",


  -- Language Server Protocol (LSP)

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- "mfussenegger/nvim-dap", -- il faut en savoir un peu plus

  "mfussenegger/nvim-jdtls", -- recommended for Java LSP

  -- Autocompletion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "onsails/lspkind.nvim", -- adds vscode-like pictograms to neovim built-in lsp

  -- Which key
  -- WhichKey is a lua plugin for Neovim 0.5 that 
  -- displays a popup with possible keybindings 
  -- of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 200
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    }
  }
}


local opts = {}

require("lazy").setup(
  plugins,
  opts
)

-- default colorscheme
vim.cmd [[colorscheme moonfly]]
