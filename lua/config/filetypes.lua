vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.asm",
  callback = function()
    vim.bo.filetype = "nasm"
  end,
})
