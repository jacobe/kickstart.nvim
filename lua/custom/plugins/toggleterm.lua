return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-`>]],
      direction = 'horizontal',
      size = 25,
      shade_terminals = false,
    }
    -- Add visual mode support for C-` (open_mapping only works in normal/terminal modes)
    vim.keymap.set('v', '<C-`>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    -- Add Super+j as an additional keymap
    vim.keymap.set({ 'n', 't', 'v' }, '<D-j>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
  end,
}
