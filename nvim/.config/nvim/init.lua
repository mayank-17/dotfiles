-- Bootstrap lazy.nvim, LazyVim, and your plugins
require("config.lazy")
require("config.which-key")

-- Enable line wrap for all buffers on BufEnter event
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.wo.wrap = true
  end,
})

-- Compile and run C++ program in a terminal split
local function compile_and_run_cpp()
  vim.cmd("write") -- Save current buffer

  local file_path = vim.fn.expand("%:p") -- Full path to file
  local file_dir = vim.fn.expand("%:p:h") -- Directory of current file
  local file_name = vim.fn.expand("%:t") -- Filename with extension
  local file_base = vim.fn.expand("%:t:r") -- Filename without extension

  local cmd = string.format(
    'cd "%s" && g++ -std=c++17 -Wall -Wextra "%s" -o "%s" && "./%s" && rm -f "%s"; echo "\\nPress Enter to close..."; read',
    file_dir, -- cd into file directory
    file_name, -- compile source file
    file_base, -- output binary name
    file_base, -- run binary
    file_base -- cleanup binary after run
  )

  vim.cmd("vsplit | terminal bash -c '" .. cmd .. "'")
end

-- Map F5 to compile_and_run_cpp only for C++ files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<F5>", compile_and_run_cpp, { buffer = true, desc = "Compile and run C++" })
  end,
})
