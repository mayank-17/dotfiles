return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = false,
  opts = {
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {
      mocha = {
        base = "#11111b",
        mantle = "#181825",
        crust = "#11111b",
      },
    },
    custom_highlights = {},
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")

    -- Get the mocha palette for reuse
    local latte = require("catppuccin.palettes").get_palette("latte")
    local frappe = require("catppuccin.palettes").get_palette("frappe")
    local macchiato = require("catppuccin.palettes").get_palette("macchiato")
    local mocha = require("catppuccin.palettes").get_palette("mocha")

    vim.api.nvim_set_hl(0, "Keyword", { fg = mocha.red })
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = mocha.red })
    vim.api.nvim_set_hl(0, "@function.call", { fg = mocha.green })
    vim.api.nvim_set_hl(0, "@function.builtin", { fg = mocha.green })
    vim.api.nvim_set_hl(0, "@keyword.return", { fg = mocha.red })
    vim.api.nvim_set_hl(0, "@property", { fg = mocha.text })
    vim.api.nvim_set_hl(0, "@variable", { fg = mocha.blue })
    vim.api.nvim_set_hl(0, "@boolean", { fg = mocha.sky })
    vim.api.nvim_set_hl(0, "@namespace.builtin", { fg = mocha.text })
    vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = mocha.red })
    vim.api.nvim_set_hl(0, "@keyword.directive.define", { fg = mocha.red })

    vim.api.nvim_set_hl(0, "String", { fg = mocha.yellow })
    vim.api.nvim_set_hl(0, "@string", { fg = mocha.yellow })

    -- Operators
    vim.api.nvim_set_hl(0, "Operator", { fg = mocha.red })
    vim.api.nvim_set_hl(0, "@operator", { fg = mocha.red })

    vim.api.nvim_set_hl(0, "@parameter", { fg = mocha.peach, italic = true })
    vim.api.nvim_set_hl(0, "Function", { fg = mocha.green, bold = true })
  end,
}
