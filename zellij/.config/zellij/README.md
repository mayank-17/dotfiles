# Tmux to Zellij Configuration Conversion

This conversion translates your tmux configuration to Zellij with Gruvbox dark theme and minimal pane borders.

## Files Included

1. **config-fixed.kdl** - Main Zellij configuration (corrected syntax) with minimal borders
2. **config-no-borders-fixed.kdl** - Ultra-minimal with NO borders (corrected syntax)
3. **minimal-layout.kdl** - Optional minimal layout
4. ~~config.kdl / config-no-borders.kdl~~ - (Old versions with syntax error - use -fixed versions instead)

## Installation

```bash
# Create zellij config directory
mkdir -p ~/.config/zellij/layouts

# Copy the FIXED config file (use the -fixed versions!)
cp config-fixed.kdl ~/.config/zellij/config.kdl

# OR for no borders:
cp config-no-borders-fixed.kdl ~/.config/zellij/config.kdl

# Copy the layout file (optional)
cp minimal-layout.kdl ~/.config/zellij/layouts/minimal-layout.kdl
```

**Note**: Use the `-fixed` versions of the config files! The original versions had a KDL syntax issue with the plugin declaration that has been corrected.

## What Was Converted

### ✅ Fully Converted Features

1. **Prefix Key**: Changed from `Ctrl+b` to `Ctrl+a` (same as your tmux config)
2. **Mouse Support**: Enabled
3. **Clipboard**: System clipboard integration
4. **History**: 1,000,000 lines of scrollback buffer
5. **Window/Tab Swapping**: `Shift+Left` and `Shift+Right` to swap tabs
6. **Base Index**: Tabs start at index 1 (like your tmux `base-index 1`)
7. **Gruvbox Theme**: Full color scheme ported to Zellij
8. **Session Management**: Built-in session serialization (like tmux-resurrect)
9. **Vim-style Navigation**: `h/j/k/l` for pane navigation
10. **Config Reload**: `Ctrl+a` then `r` to reload config

### 🔄 Partial Equivalents

1. **tmux-resurrect/continuum**: Zellij has built-in `session_serialization` - it saves sessions automatically
2. **vim-tmux-navigator**: Zellij doesn't have a direct plugin, but you can use the built-in navigation
3. **tmux-fzf-session-switch**: Zellij has a built-in session-manager accessible with `Ctrl+a` then `o`
4. **CPU/Memory Monitor**: Zellij's status bar can be customized with plugins (see plugins section below)

### ❌ Not Available (Yet)

1. **tmux-sensible**: Not needed - Zellij has sensible defaults built-in
2. **Terminal Overrides**: Zellij handles 256-color and RGB automatically
3. **Passthrough**: Different implementation in Zellij

## Minimal Borders Configuration

Your request for minimal/no fancy borders is achieved through:

```kdl
ui {
    pane_frames {
        rounded_corners true
        hide_session_name false
    }
}
```

You can further minimize the UI by:

1. **Option 1**: Use `simplified_ui true` in config.kdl (this will hide most UI elements)
2. **Option 2**: Set `pane_frames false` to completely remove borders
3. **Option 3**: Use the minimal-layout.kdl which has borderless status bars

To use the minimal layout:
```bash
zellij --layout minimal-layout
```

## Key Binding Cheatsheet

Since you're migrating from tmux, here's a mapping of your common commands:

| Tmux Command | Zellij Equivalent | Notes |
|--------------|-------------------|-------|
| `Ctrl+b` | `Ctrl+a` | Prefix changed to match your config |
| `Ctrl+b c` | `Ctrl+a c` | New tab/window |
| `Ctrl+b "` | `Ctrl+a "` | Split horizontal |
| `Ctrl+b %` | `Ctrl+a %` | Split vertical |
| `Ctrl+b z` | `Ctrl+a z` | Toggle fullscreen |
| `Ctrl+b x` | `Ctrl+a x` | Close pane |
| `Ctrl+b h/j/k/l` | `Ctrl+a h/j/k/l` | Navigate panes |
| `Ctrl+b 1-9` | `Ctrl+a 1-9` | Go to tab number |
| `Ctrl+b [` | `Ctrl+a [` | Resize mode |
| `Ctrl+b d` | `Ctrl+a d` | Detach session |
| `Ctrl+b r` | `Ctrl+a r` | Reload config |
| `Ctrl+b o` | `Ctrl+a o` | Session manager (fzf-like) |
| `Shift+Left/Right` | `Shift+Left/Right` | Swap tabs/windows |

## Status Bar Customization

To add CPU/Memory monitoring like your tmux setup, you can:

1. Use Zellij's plugin system to create custom status bar widgets
2. Install community plugins from https://github.com/zellij-org/awesome-zellij
3. Customize the status-bar plugin

Example plugins:
- [zjstatus](https://github.com/dj95/zjstatus) - Advanced status bar with system info
- [room](https://github.com/rvcas/room) - Minimal status bar

## Advanced Customization

### Completely Remove Borders

Edit config.kdl:
```kdl
pane_frames false
```

### Use Even More Minimal UI

Edit config.kdl:
```kdl
simplified_ui true
```

### Change Default Shell

Edit config.kdl:
```kdl
default_shell "bash"  // or "fish", "zsh", etc.
```

## Session Persistence

Unlike tmux which requires tmux-resurrect plugin, Zellij has built-in session persistence:

```kdl
session_serialization true
serialize_pane_viewport true
scrollback_lines_to_serialize 1000
```

Sessions are automatically saved to `~/.cache/zellij/` and can be restored.

## Navigation Integration with Neovim

For vim-tmux-navigator equivalent, consider:

1. **zellij.nvim** - Neovim plugin for Zellij integration
2. **smart-splits.nvim** - Works with Zellij
3. Use Zellij's built-in focus switching

Add to your Neovim config:
```lua
-- Example for smart-splits.nvim
require('smart-splits').setup({
  at_edge = 'stop',
})
```

## Differences from Tmux

1. **No TPM**: Zellij uses built-in plugins and Rust-based plugin system
2. **KDL Config Format**: Uses KDL instead of shell-like syntax
3. **Modes**: Zellij uses explicit modes (Normal, Tmux, Resize, etc.)
4. **Built-in Features**: Many things that need plugins in tmux are built-in

## Testing Your Config

```bash
# Test with the new config
zellij --config ~/.config/zellij/config.kdl

# Test with minimal layout
zellij --layout minimal-layout --config ~/.config/zellij/config.kdl

# Attach to existing session
zellij attach

# List sessions
zellij list-sessions

# Delete a session
zellij delete-session <session-name>
```

## Troubleshooting

1. **Config errors**: Run `zellij setup --check` to validate your config
2. **KDL syntax error with LaunchOrFocusPlugin**: Make sure you're using the `-fixed` versions of the config files. The original had incorrect nested brace syntax.
3. **Colors not working**: Make sure your terminal supports 256 colors
4. **Keybindings not working**: Check for conflicts with terminal emulator shortcuts
5. **Session not persisting**: Check `~/.cache/zellij/` permissions

## Is Everything Possible? YES! ✅

**All your requirements are achievable:**

1. ✅ **Minimal/No Fancy Borders**: Yes! Set `pane_frames false` or use `simplified_ui true`
2. ✅ **Gruvbox Theme**: Fully ported with all colors
3. ✅ **Ctrl+a Prefix**: Configured
4. ✅ **Mouse Support**: Enabled
5. ✅ **Session Persistence**: Built-in (no plugin needed)
6. ✅ **High Scrollback**: 1M lines configured
7. ✅ **Window/Tab Management**: All key bindings ported

The only features that work differently are plugin-based features (like CPU monitor), but Zellij has its own plugin ecosystem for these.

## Resources

- [Zellij Documentation](https://zellij.dev/documentation/)
- [Zellij GitHub](https://github.com/zellij-org/zellij)
- [Awesome Zellij Plugins](https://github.com/zellij-org/awesome-zellij)
- [KDL Language](https://kdl.dev/)

Enjoy your Zellij setup! 🚀
