-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/aerial.nvim',
    opts = {
      -- optional: set keymaps when aerial attaches
      on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function(_, opts)
      require('aerial').setup(opts)
      -- Safe winbar: no errors if aerial isn't available
      _G.aerial_winbar = function()
        local ok, aerial = pcall(require, 'aerial')
        if not ok then return '' end
        local loc = aerial.get_location(true)
        if loc == nil or loc == '' then return '' end
        return loc
      end

      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Aerial toggle' })

      -- keymap to toggle aerial
      vim.keymap.set('n', '<leader>on', '<cmd>AerialNavToggle<CR>', { desc = 'Toggle Aerial Code Navigation' })
      vim.keymap.set('n', '<leader>oo', '<cmd>AerialOpen!<CR>', { desc = 'Open Aerial Code Outline' })
    end,
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    config = function()
      local dropbar_api = require 'dropbar.api'
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Nice keymaps (optional)
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek fold' })

      require('ufo').setup {
        -- default is: main = "lsp", fallback = "indent"
        provider_selector = function(_, _, _) return { 'lsp', 'indent' } end,
      }
    end,
  },
}
