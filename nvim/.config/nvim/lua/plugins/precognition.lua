return {
  "tris203/precognition.nvim",
  lazy = false,
  config = function()
    require("precognition").setup()
    require("precognition").hide()
  end,
}
