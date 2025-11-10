return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup{
      open_mapping = [[<C-`>]],
      direction = "horizontal",
      size = 15,
      shade_terminals = false,
    }
    -- Add Super+j as an additional keymap
    vim.keymap.set({'n', 't'}, '<D-j>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
  end
}

