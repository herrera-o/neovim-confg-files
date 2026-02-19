return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "ts_ls" },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      vim.lsp.config("ts_ls", {})
      local ok = pcall(vim.lsp.enable, "ts_ls")
      if not ok then
        vim.lsp.config("tsserver", {})
        vim.lsp.enable("tsserver")
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "javascript", "typescript" },
    },
  },
}
