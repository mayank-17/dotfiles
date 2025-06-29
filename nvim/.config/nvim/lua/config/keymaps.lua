-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<C-;>", "<C-w><", opts) -- Alt+h to shrink width
vim.api.nvim_set_keymap("n", "<C-'>", "<C-w>>", opts) -- Alt+l to grow width

vim.keymap.set("n", "<leader>tp", function()
  if require("precognition").toggle() then
    vim.notify("precognition on")
  else
    vim.notify("precognition off")
  end
end, { desc = "Toggle precognition.nvim" })
