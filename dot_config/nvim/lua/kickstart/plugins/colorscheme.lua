-- set theme

return {
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'mocha',
  --       transparent_background = true,
  --     }
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   priority = 1000,
  --   config = function()
  --     require('rose-pine').setup {}
  --     vim.cmd.colorscheme 'rose-pine'
  --   end,
  -- },
  -- {
  --   'tomasiser/vim-code-dark',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'codedark'
  --   end,
  -- },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('dracula').setup {
        transparent_bg = true,
      }
      vim.cmd.colorscheme 'dracula'
    end,
  },
}
