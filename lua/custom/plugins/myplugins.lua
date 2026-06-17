local function gh(repo) return 'https://github.com/' .. repo end
-- Aerial
vim.pack.add {
  gh 'stevearc/aerial.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'nvim-tree/nvim-web-devicons',
}

require('aerial').setup {
  on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
  end,
}

_G.aerial_winbar = function()
  local ok, aerial = pcall(require, 'aerial')
  if not ok then return '' end
  local loc = aerial.get_location(true)
  if loc == nil or loc == '' then return '' end
  return loc
end

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Aerial toggle' })
vim.keymap.set('n', '<leader>on', '<cmd>AerialNavToggle<CR>', { desc = 'Toggle Aerial Code Navigation' })
vim.keymap.set('n', '<leader>oo', '<cmd>AerialOpen!<CR>', { desc = 'Open Aerial Code Outline' })

-- Dropbar
vim.pack.add {
  gh 'Bekaboo/dropbar.nvim',
  gh 'nvim-telescope/telescope-fzf-native.nvim',
}

local dropbar_api = require 'dropbar.api'

vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

-- UFO
vim.pack.add {
  gh 'kevinhwang91/nvim-ufo',
  gh 'kevinhwang91/promise-async',
}

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', 'zp', require('ufo').peekFoldedLinesUnderCursor, { desc = 'Peek fold' })

require('ufo').setup {
  provider_selector = function() return { 'lsp', 'indent' } end,
}

