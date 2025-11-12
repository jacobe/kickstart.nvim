return {
  {
    'lewis6991/satellite.nvim',
    event = 'VeryLazy',
    opts = {
      current_only = false,
      width = 4,
      winblend = 10,
      zindex = 40,
      excluded_filetypes = {},
      handlers = {
        cursor = {
          enable = true,
        },
        diagnostic = {
          enable = true,
        },
        gitsigns = {
          enable = true,
        },
        marks = {
          enable = true,
          show_builtins = false,
        },
        quickfix = {
          enable = true,
        },
      },
    },
  },
}
