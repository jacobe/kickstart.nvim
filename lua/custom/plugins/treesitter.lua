return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false, -- nvim-treesitter does not support lazy-loading
  branch = 'main', -- IMPORTANT: Use main branch (master is frozen)
  build = ':TSUpdate', -- Automatically update parsers on plugin update
  install = {
    'bash',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'query',
    'vim',
    'vimdoc',
    'python',
    'php',
  },
}
