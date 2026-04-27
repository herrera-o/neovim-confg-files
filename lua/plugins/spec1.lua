return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({
        "c",
        "cpp",
        "javascript",
        "typescript",
        "python",
        "java",
        "lua",
        "vim",
        "bash",
        "asm",
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "asm_lsp",
        "clangd",
        "jdtls",
        "pyright",
        "ts_ls",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
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

      vim.lsp.config("jdtls", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("ts_ls", {})

      require("mason-lspconfig").setup(opts)

      vim.lsp.enable("asm_lsp")
      vim.lsp.enable("jdtls")
      vim.lsp.enable("pyright")
      local ok = pcall(vim.lsp.enable, "ts_ls")
      if not ok then
        vim.lsp.config("tsserver", {})
        vim.lsp.enable("tsserver")
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("clangd", {})
      vim.lsp.enable("clangd")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.filetype("nasm", {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "nasm_registers" },
          { name = "nasm_instructions" },
        }),
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

}
