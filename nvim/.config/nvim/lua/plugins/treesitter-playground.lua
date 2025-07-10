return {
  "nvim-treesitter/playground",
  cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- Optional, enables Playground features
    require("nvim-treesitter.configs").setup({
      playground = {
        enable = true,
        updatetime = 25, -- debounced time for highlighting nodes
        persist_queries = false,
      },
    })
  end,
}
