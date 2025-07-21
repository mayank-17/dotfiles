return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  enabled = true,
  lazy = false,
  config = function()
    -- local is_mac = vim.loop.os_uname().sysname == "Darwin"
    local is_linux = vim.loop.os_uname().sysname == "Linux"

    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      color_overrides = {
        mocha = {
          base = is_linux and "#262626" or nil,
          mantle = is_linux and "#1c1c1c" or nil,
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
    local syntax_modes = require("catppuccin-syntax-modes")
    syntax_modes.setup({
      default_mode = "monokai",
    })
  end,
}

-- return {
--   { "ellisonleao/gruvbox.nvim" },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }

-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     vim.cmd("colorscheme rose-pine")
--   end,
-- }
--

-- return {
--   "rebelot/kanagawa.nvim",
--   lazy = false, -- load early since it's your main theme
--   priority = 1000, -- ensure it loads before other plugins
--   config = function()
--     require("kanagawa").setup({
--       -- default options; customize as needed:
--       transparent = false,
--       commentStyle = { italic = true },
--       statementStyle = { bold = true },
--       theme = "dragon", -- options: "wave", "dragon", "lotus"
--       background = { dark = "dragon" },
--     })
--     vim.cmd.colorscheme("kanagawa-dragon")
--
--     -- Fetch the real background color from the "Normal" group
--     local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
--
--     -- Apply it to line numbers and signs so they match exactly
--     vim.api.nvim_set_hl(0, "LineNr", { bg = normal_bg })
--     vim.api.nvim_set_hl(0, "CursorLineNr", { bg = normal_bg })
--     vim.api.nvim_set_hl(0, "SignColumn", { bg = normal_bg })
--     vim.api.nvim_set_hl(0, "VertSplit", { bg = normal_bg })
--
--     -- For snacks explorer or floating windows
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal_bg })
--     vim.api.nvim_set_hl(0, "SnacksNormal", { bg = normal_bg })
--     vim.api.nvim_set_hl(0, "SnacksFloat", { bg = normal_bg })
--
--   end,
-- }
