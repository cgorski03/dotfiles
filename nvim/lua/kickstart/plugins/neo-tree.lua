-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  -- lazy = false, -- It's better to let lazy.nvim handle this. Remove this line.
  cmd = "Neotree", -- This is a better way to load it on demand
  keys = {
    -- This keymap is now syntactically correct and uses the leader key, which is standard.
    -- It will open the file explorer and reveal the current file.
    {
      '<leader>e',
      function()
        require('neo-tree.command').execute { toggle = true, reveal = true }
      end,
      desc = 'Explorer NeoTree (reveal)',
    },
    -- You can also map the backslash if you really want to.
    {
      '\\',
      function()
        require('neo-tree.command').execute { toggle = true }
      end,
      desc = 'Explorer NeoTree',
    },
  },
  opts = {
    -- You can leave opts empty to accept the defaults, which are very good.
    -- Or you can add specific configurations here. For example:
    window = {
      width = 30, -- Set a custom width for the file explorer
      mappings = {
        ['<space>'] = 'none', -- Disable the space key for now if you like
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
}
