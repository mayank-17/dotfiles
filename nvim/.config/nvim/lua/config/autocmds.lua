-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Function to load template
local function load_template(template_name)
  local template_path = vim.fn.stdpath("config") .. "/templates/template." .. template_name
  if vim.fn.filereadable(template_path) == 1 then
    vim.cmd("0r " .. template_path)
    -- Position cursor at first placeholder or end
    vim.cmd("normal! G")
  else
    print("Template not found: " .. template_path)
  end
end

-- Key mappings for different templates
-- vim.keymap.set('n', '<leader>tp', function() load_template('python') end, { desc = 'Load Python template' })
-- vim.keymap.set('n', '<leader>th', function() load_template('html') end, { desc = 'Load HTML template' })
-- vim.keymap.set('n', '<leader>tj', function() load_template('javascript') end, { desc = 'Load JS template' })

-- Generic template loader with prompt
vim.keymap.set("n", "<leader>tl", function()
  local template_name = vim.fn.input("Template name: ")
  if template_name ~= "" then
    load_template(template_name)
  end
end, { desc = "Load template by name" })
