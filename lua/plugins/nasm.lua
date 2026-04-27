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

}
