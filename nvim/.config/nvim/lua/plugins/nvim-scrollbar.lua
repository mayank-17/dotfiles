return {
  "petertriho/nvim-scrollbar",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- Required for git signs
  },
  config = function()
    require("scrollbar").setup({
      throttle_ms = 100, -- Higher throttle
      handle = {
        text = " ",
        color = "#404040", -- Custom gray color
        hide_if_all_visible = true,
      },
      marks = {
        GitAdd = {
          text = "▌", -- Left half block
          priority = 1,
          color = "#28a745",
        },
        GitChange = {
          text = "▌",
          priority = 1,
          color = "#e2c08d",
        },
        GitDelete = {
          text = "▌",
          priority = 1,
          color = "#f85149",
        },
      },
      handlers = {
        cursor = false,
        diagnostic = false,
        gitsigns = true,
        handle = true,
        search = true,
      },
    })
  end,
}
