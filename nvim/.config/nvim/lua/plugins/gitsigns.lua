-- return {
--   "lewis6991/gitsigns.nvim",
--   enabled = true,
--   config = function()
--     require("gitsigns").setup()
--       end,
-- }

return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
  "kevinhwang91/nvim-hlslens",
  },
  enabled = true,
  config = function()
    require("gitsigns").setup({
      update_debounce = 1000, -- Much higher debounce
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {}),
      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {}),
      -- signs = {
      --   add = { text = "│" },
      --   change = { text = "│" },
      --   delete = { text = "_" },
      --   topdelete = { text = "‾" },
      --   changedelete = { text = "~" },
      --   untracked = { text = "┆" },
      -- },
    })
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
