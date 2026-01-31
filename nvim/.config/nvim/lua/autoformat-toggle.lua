-- File: lua/autoformat-toggle/init.lua
local M = {}

-- Default configuration
local config = {
  default_enabled = false,
  toggle_key = "<leader>af",
  status_key = "<leader>as",
  show_messages = true,
}

-- Function to toggle autoformat
local function toggle_autoformat()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    vim.opt_local.fixeol = true
    if config.show_messages then
      print("Autoformat: ON")
    end
  else
    vim.b.autoformat = false
    vim.opt_local.fixeol = false
    if config.show_messages then
      print("Autoformat: OFF")
    end
  end
end

-- Function to check current autoformat status
local function check_autoformat_status()
  if config.show_messages then
    if vim.b.autoformat == false then
      print("Autoformat: OFF")
    else
      print("Autoformat: ON")
    end
  end
end

-- Setup function
function M.setup(opts)
  -- Merge user config with defaults
  config = vim.tbl_deep_extend("force", config, opts or {})

  -- Set default autoformat state for all files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      if not config.default_enabled then
        vim.b.autoformat = false
        vim.opt_local.fixeol = false
      end
    end,
  })

  -- Create key mappings
  vim.keymap.set("n", config.toggle_key, toggle_autoformat, {
    desc = "Toggle autoformat for current buffer",
    silent = not config.show_messages,
  })

  if config.status_key then
    vim.keymap.set("n", config.status_key, check_autoformat_status, {
      desc = "Check autoformat status",
    })
  end
end

-- Expose functions for manual use
M.toggle = toggle_autoformat
M.status = check_autoformat_status

return M
