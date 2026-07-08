return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "asm",
        "bash",
        "c",
        "cpp",
        "java",
        "javascript",
        "lua",
        "python",
        "typescript",
        "vim",
      }

      require("nvim-treesitter").setup()
      vim.treesitter.language.register("asm", { "asm", "nasm", "vmasm" })
      require("nvim-treesitter").install(parsers)

      local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.lsp.config("asm_lsp", {
        capabilities = capabilities,
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

      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.config("jdtls", { capabilities = capabilities })
      vim.lsp.config("pyright", { capabilities = capabilities })
      vim.lsp.config("ts_ls", { capabilities = capabilities })

      require("mason-lspconfig").setup(opts)
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
