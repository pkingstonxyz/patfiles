-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme tokyonight]])
      end,
    },
    {
      "Olical/conjure",
      ft = { "clojure", "fennel", "python", "scheme" },
      lazy = true,
      init = function()
      end,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp", -- Tells LSP about nvim-cmp
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "pyright", "clojure_lsp" }, 
        })
        -- Bridge with nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        -- Automatically set up handlers for installed LSPs
        require("mason-lspconfig").setup({
          handlers = function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
        })

        -- Global LSP Mappings
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover info" })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = "Rename Symbol" })
      end,
    },

    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "PaterJason/cmp-conjure",
        "L3MON4D3/LuaSnip",        
        "saadparwaiz1/cmp_luasnip", 
        "hrsh7th/cmp-nvim-lsp", -- Duplicated for safety
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          -- Blend LSP results and Conjure results together
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "conjure" },
          }),
        })
      end,
    },
    {
      "dundalek/parpar.nvim",
      dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
      opts = { },
    },
    { "HiPhish/rainbow-delimiters.nvim",
    init = function()
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = 'rainbow-delimiters.strategy.global',
          vim = 'rainbow-delimiters.strategy.local',
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
          clojure = 'rainbow-delimiters',
          scheme = 'rainbow-delimiters',
          lisp = 'rainbow-delimiters',
        },
        priority = {
          [''] = 110,
          lua = 210,
          clojure = 120,
          scheme = 120,
          lisp = 120,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
},
install = { colorscheme = { "tokyonight" } },
checker = { enabled = true },

-- This, for some reason, makes guix work. I do not understand it --
performance = {
  reset_packpath = false,
  rtp = {
    reset = false, 
  },
},
})


vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd('syntax on')
vim.filetype.add({}) -- modern filetype detection

