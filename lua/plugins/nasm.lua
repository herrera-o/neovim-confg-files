return {

  -- NASM snippets + cmp sources
  {
    "Who5673/who5673-nasm",
    ft = "nasm",
    lazy = true,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- Treesitter (if you want to ensure asm parser; included here just in case)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "asm" },
      highlight = { enable = true },
    },
  },

  -- Mason + LSP for asm-lsp
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "asm_lsp" },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Attach to nasm filetype
      if vim.lsp and vim.lsp.config then
        vim.lsp.config("asm_lsp", {
          filetypes = { "asm", "vmasm", "nasm" },
          settings = {
            ["asm-lsp"] = {
              assembler = "nasm",
              instruction_set = "x86/x86-64",
              diagnostics = true,
              default_diagnostics = true,
            },
          },
        })
      end
    end,
  },

}
