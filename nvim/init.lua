--Options
require("options")

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
--require("lazy").setup(plugins, opts)


-- Plugins
require("lazy").setup({
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function () 
  local configs = require("nvim-treesitter.configs")
    configs.setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "go", "javascript", "html", "python" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },  
  })
  end
},
{
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {}
},
{
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
},
{
  'neoclide/coc.nvim',
  branch = 'release'
},
{ 
  "kyazdani42/nvim-tree.lua",
  event = "VimEnter",
  dependencies = "nvim-tree/nvim-web-devicons",
},
{
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons'
}
})



local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


-- setup nvim-tree with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  git = {
    enable = true,
  },
  view = {
    side = "left",
    number = false,
    relativenumber = false,
    -- signcolumn = "yes",
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

require("bufferline").setup({
  options = {
    close_command = "bdelete! %d",       -- 点击关闭按钮关闭
    right_mouse_command = "bdelete! %d", -- 右键点击关闭
    indicator = {
      icon = '▎', -- 分割线
      style = 'underline',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "left",
        separator = true,
      },
    },
  },
})
