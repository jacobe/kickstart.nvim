return {
  'olimorris/persisted.nvim',
  lazy = false, -- Load at startup to restore session
  config = function()
    require('persisted').setup {
      save_dir = vim.fn.expand(vim.fn.stdpath 'data' .. '/sessions/'), -- directory where session files are saved
      silent = false, -- silent nvim message when sourcing session file
      use_git_branch = false, -- create session files based on the branch of a git enabled repository
      default_branch = 'main', -- the branch to load if a session file is not found for the current branch
      autosave = true, -- automatically save session files when exiting Neovim
      should_autosave = function()
        -- Don't autosave if we're in certain special buffers
        local excluded_filetypes = {
          'gitcommit',
          'gitrebase',
          'lazy',
        }
        local buftype = vim.bo.buftype
        local filetype = vim.bo.filetype

        -- Don't save if buffer is not a normal file
        if buftype ~= '' and buftype ~= 'acwrite' then
          return false
        end

        -- Don't save for excluded filetypes
        for _, ft in ipairs(excluded_filetypes) do
          if filetype == ft then
            return false
          end
        end

        return true
      end,
      autoload = true, -- automatically load the session for the cwd on Neovim startup
      on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
      follow_cwd = true, -- change session file name to match current working directory if it changes
      allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
      ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
      ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
      telescope = {
        reset_prompt = true, -- Reset the Telescope prompt after an action?
        mappings = { -- table of mappings for the Telescope extension
          change_branch = '<c-b>',
          copy_session = '<c-c>',
          delete_session = '<c-d>',
        },
        icons = { -- icons displayed in the Telescope picker
          branch = ' ',
          dir = ' ',
          selected = ' ',
        },
      },
    }

    -- Close special windows before saving session
    local group = vim.api.nvim_create_augroup('PersistedHooks', { clear = true })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistedSavePre',
      group = group,
      callback = function()
        -- Close neo-tree
        pcall(vim.cmd, 'Neotree close')

        -- Close toggleterm terminals
        local ok, toggleterm = pcall(require, 'toggleterm.terminal')
        if ok then
          local terminals = toggleterm.get_all(true)
          for _, term in ipairs(terminals) do
            if term:is_open() then
              term:close()
            end
          end
        end

        -- Close any floating windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= '' then
            vim.api.nvim_win_close(win, false)
          end
        end

        -- Close buffers with special filetypes
        local special_filetypes = {
          'neo-tree',
          'toggleterm',
          'help',
          'qf',
          'claude-code',
        }

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local ft = vim.bo[buf].filetype
            local bt = vim.bo[buf].buftype

            for _, special_ft in ipairs(special_filetypes) do
              if ft == special_ft or bt == 'terminal' or bt == 'nofile' then
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
                break
              end
            end
          end
        end
      end,
    })
  end,
}
