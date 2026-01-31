-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.window_background_image = "/home/mayank/Pictures/goku-blurred.jpg"

-- Optional: tweak how the image appears
config.window_background_image_hsb = {
	brightness = 0.1, -- reduce brightness so text stands out
	hue = 1.0,
	saturation = 1.0,
}

-- ✅ Set opacity for transparency (this is what you're missing)
config.window_background_opacity = 1.0 -- keep window solid

config.enable_wayland = false

config.force_reverse_video_cursor = true

-- This is where you actually apply your config choices

config.window_decorations = "TITLE|RESIZE"
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}

config.keys = {
	-- Map Ctrl+Left to send escape sequences for backward word
	{ key = "LeftArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bb" }) }, -- ESC + b = backward-word
	{ key = "RightArrow", mods = "CTRL", action = wezterm.action({ SendString = "\x1bf" }) }, -- ESC + f = forward-word
	{ key = "V", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},
}

-- config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font = wezterm.font("JetBrains Mono", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.enable_scroll_bar = true
-- Disable tab bar
config.enable_tab_bar = false
-- For example, changing the color scheme:
config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "catppuccin-mocha"
config.colors = { background = "#1c1c1c" }
-- Cursor style when focused
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 400 -- blink rate in milliseconds (default is 1200)
-- options: "BlinkingBlock", "SteadyBlock", "BlinkingUnderline", "SteadyUnderline", "BlinkingBar", "SteadyBar"

-- This event is fired when the GUI starts up
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
