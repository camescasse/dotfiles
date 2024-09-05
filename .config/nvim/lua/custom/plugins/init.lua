-- You can add your own plugins here or in other files in this directory!
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        view = {
          side = 'right',
        },
        tab = {
          sync = {
            open = true,
            close = true,
          },
        },
      }
    end,
  },
  { 'tpope/vim-fugitive' },
  { 'frabjous/knap' },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {}
    end,
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    enabled = true,
    init = false,
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'
      local logo = [[
	                                                             
	      ████ ██████           █████      ██                       
	     ███████████             █████                               
	     █████████ ███████████████████ ███   ███████████     
	    █████████  ███    █████████████ █████ ██████████████     
	   █████████ ██████████ █████████ █████ █████ ████ █████     
	 ███████████ ███    ███ █████████ █████ █████ ████ █████    
	██████  █████████████████████ ████ █████ █████ ████ ██████   
      ]]

      dashboard.section.header.val = vim.split(logo, '\n')
    -- stylua: ignore
      dashboard.section.buttons.val = {
      -- 󰨙  󰘦    󰏿        󰊕     󰦮  󰎠      󰆼 󰏚   󰀫 
      dashboard.button("f", " " .. " Find file",       '<cmd> Telescope find_files <cr>'),
      dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files",    '<cmd> Telescope oldfiles <cr>'),
      dashboard.button("d", " " .. " Recent projects", '<cmd> Telescope projects <cr>'),
      dashboard.button('p', ' ' .. ' All projects',    '<cmd> e ~/projects <cr>'),
      dashboard.button("g", " " .. " Find text",       '<cmd> Telescope live_grep <cr>'),
      dashboard.button("c", " " .. " Config",          '<cmd> e ~/.config/nvim <cr>'),
      dashboard.button("l", "󰒲 " .. " Lazy",            '<cmd> Lazy <cr>'),
      dashboard.button("q", " " .. " Quit",            '<cmd> qa <cr>'),
    }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.section.footer.opts.hl = 'AlphaFooter'
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          once = true,
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'michaelrommel/nvim-silicon',
    dependencies = { 'folke/which-key.nvim' },
    cmd = 'Silicon',
    keys = {
      {
        '<leader>cs',
        function()
          require('nvim-silicon').clip()
        end,
        mode = 'v',
        desc = 'Code screenshot to clipboard',
      },
    },
    config = function()
      require('silicon').setup {
        font = 'JetBrainsMono Nerd Font=34',
      }
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },
}
