-- catppuccin-syntax-modes.lua
-- A system to switch between different syntax highlighting modes for Catppuccin

local M = {}

-- Store the current mode
M.current_mode = "monokai"

-- Define syntax modes with their highlight group mappings
M.syntax_modes = {
  monokai = {
    -- Monokai-inspired syntax highlighting with Catppuccin colors
    ["@keyword"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@keyword.function"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@keyword.return"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@conditional"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@repeat"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@string"] = function(colors)
      return { fg = colors.yellow }
    end,
    ["@string.escape"] = function(colors)
      return { fg = colors.peach }
    end,
    ["@character"] = function(colors)
      return { fg = colors.yellow }
    end,
    ["@number"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@boolean"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@float"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@function"] = function(colors)
      return { fg = colors.green, bold = true }
    end,
    ["@function.call"] = function(colors)
      return { fg = colors.green }
    end,
    ["@function.builtin"] = function(colors)
      return { fg = colors.green, bold = true }
    end,
    ["@function.macro"] = function(colors)
      return { fg = colors.green, bold = true }
    end,
    ["@method"] = function(colors)
      return { fg = colors.green, bold = true }
    end,
    ["@method.call"] = function(colors)
      return { fg = colors.green }
    end,
    ["@constructor"] = function(colors)
      return { fg = colors.blue }
    end,
    ["@parameter"] = function(colors)
      return { fg = colors.peach, italic = true }
    end,
    ["@variable"] = function(colors)
      return { fg = colors.text }
    end,
    ["@variable.builtin"] = function(colors)
      return { fg = colors.red, italic = true }
    end,
    ["@constant"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@constant.builtin"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@constant.macro"] = function(colors)
      return { fg = colors.lavender }
    end,
    ["@type"] = function(colors)
      return { fg = colors.blue, italic = true }
    end,
    ["@type.builtin"] = function(colors)
      return { fg = colors.blue, italic = true }
    end,
    ["@type.qualifier"] = function(colors)
      return { fg = colors.pink }
    end,
    ["@property"] = function(colors)
      return { fg = colors.text }
    end,
    ["@attribute"] = function(colors)
      return { fg = colors.green }
    end,
    ["@comment"] = function(colors)
      return { fg = colors.overlay0, italic = true }
    end,
    ["@operator"] = function(colors)
      return { fg = colors.pink }
    end,
    ["@punctuation"] = function(colors)
      return { fg = colors.overlay2 }
    end,
    ["@punctuation.bracket"] = function(colors)
      return { fg = colors.overlay2 }
    end,
    ["@punctuation.delimiter"] = function(colors)
      return { fg = colors.overlay2 }
    end,
    ["@tag"] = function(colors)
      return { fg = colors.pink, bold = true }
    end,
    ["@tag.attribute"] = function(colors)
      return { fg = colors.green }
    end,
    ["@tag.delimiter"] = function(colors)
      return { fg = colors.overlay2 }
    end,
  },
}

-- Get Catppuccin colors for the current flavor
local function get_catppuccin_colors()
  -- Add error handling for when catppuccin is not available
  local ok, catppuccin_palettes = pcall(require, "catppuccin.palettes")
  if not ok then
    vim.notify("Catppuccin palettes not found. Make sure Catppuccin is installed.", vim.log.levels.ERROR)
    return nil
  end

  local colors = catppuccin_palettes.get_palette()
  if not colors then
    vim.notify("Failed to get Catppuccin color palette", vim.log.levels.ERROR)
    return nil
  end

  return colors
end

-- Apply a syntax mode
function M.apply_syntax_mode(mode)
  if not M.syntax_modes[mode] then
    vim.notify("Invalid syntax mode: " .. mode, vim.log.levels.ERROR)
    vim.notify("Available modes: " .. table.concat(vim.tbl_keys(M.syntax_modes), ", "), vim.log.levels.ERROR)
    return false
  end

  local colors = get_catppuccin_colors()
  if not colors then
    return false
  end

  local mode_config = M.syntax_modes[mode]

  -- Apply each highlight group with error handling
  for group, color_func in pairs(mode_config) do
    local ok, highlight_config = pcall(color_func, colors)
    if ok and highlight_config then
      vim.api.nvim_set_hl(0, group, highlight_config)
    else
      vim.notify("Failed to apply highlight for group: " .. group, vim.log.levels.WARN)
    end
  end

  M.current_mode = mode
  -- vim.notify("Switched to syntax mode: " .. mode, vim.log.levels.INFO)
  return true
end

-- Set up user commands
function M.setup_commands()
  -- Command to switch syntax mode
  vim.api.nvim_create_user_command("CatppuccinSyntaxMode", function(opts)
    local mode = opts.args
    if mode == "" then
      vim.notify("Current syntax mode: " .. M.current_mode, vim.log.levels.INFO)
      vim.notify("Available modes: " .. table.concat(vim.tbl_keys(M.syntax_modes), ", "), vim.log.levels.INFO)
    else
      M.apply_syntax_mode(mode)
    end
  end, {
    nargs = "?",
    complete = function()
      return vim.tbl_keys(M.syntax_modes)
    end,
    desc = "Switch Catppuccin syntax highlighting mode",
  })

  -- Command to list available modes
  vim.api.nvim_create_user_command("CatppuccinSyntaxModes", function()
    vim.notify("Available syntax modes:", vim.log.levels.INFO)
    for mode, _ in pairs(M.syntax_modes) do
      local indicator = mode == M.current_mode and " (current)" or ""
      vim.notify("  " .. mode .. indicator, vim.log.levels.INFO)
    end
  end, {
    desc = "List available Catppuccin syntax modes",
  })
end

-- Initialize the system
function M.setup(opts)
  opts = opts or {}

  -- Set default mode (fix: use "monokai" instead of "default" since that's what exists)
  M.current_mode = opts.default_mode or "monokai"

  -- Validate that the default mode exists
  if not M.syntax_modes[M.current_mode] then
    vim.notify("Invalid default mode: " .. M.current_mode .. ". Using 'monokai'", vim.log.levels.WARN)
    M.current_mode = "monokai"
  end

  -- Setup commands
  M.setup_commands()

  -- Apply initial mode after ensuring Catppuccin is loaded
  -- Use autocmd to wait for ColorScheme event instead of timer
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      -- Small delay to ensure everything is set up
      vim.defer_fn(function()
        if M.current_mode and M.syntax_modes[M.current_mode] then
          M.apply_syntax_mode(M.current_mode)
        end
      end, 50)
    end,
    once = false, -- Keep listening for colorscheme changes
    group = vim.api.nvim_create_augroup("CatppuccinSyntaxModes", { clear = true }),
  })

  -- Also try to apply immediately if Catppuccin is already loaded
  vim.defer_fn(function()
    if M.current_mode and M.syntax_modes[M.current_mode] then
      M.apply_syntax_mode(M.current_mode)
    end
  end, 100)
end

-- Convenience function to switch modes
function M.switch_mode(mode)
  return M.apply_syntax_mode(mode)
end

-- Get current mode
function M.get_current_mode()
  return M.current_mode
end

-- Get available modes
function M.get_available_modes()
  return vim.tbl_keys(M.syntax_modes)
end

-- Add a function to add new syntax modes dynamically
function M.add_syntax_mode(name, mode_config)
  if type(name) ~= "string" or type(mode_config) ~= "table" then
    vim.notify("Invalid syntax mode configuration", vim.log.levels.ERROR)
    return false
  end

  M.syntax_modes[name] = mode_config
  vim.notify("Added syntax mode: " .. name, vim.log.levels.INFO)
  return true
end

-- Add a function to remove syntax modes
function M.remove_syntax_mode(name)
  if not M.syntax_modes[name] then
    vim.notify("Syntax mode does not exist: " .. name, vim.log.levels.ERROR)
    return false
  end

  if M.current_mode == name then
    vim.notify("Cannot remove currently active mode. Switch to another mode first.", vim.log.levels.ERROR)
    return false
  end

  M.syntax_modes[name] = nil
  vim.notify("Removed syntax mode: " .. name, vim.log.levels.INFO)
  return true
end

return M
