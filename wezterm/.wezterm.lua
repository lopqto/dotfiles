local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Appearance
config.font_size = 20.0
config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.color_scheme = 'Catppuccin Macchiato'
config.color_scheme = 'Classic Dark (base16)'

-- Terminal configuration
config.enable_scroll_bar = true
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Tabs
-- Relocate tabs
config.keys = {
    { key = '{', mods = 'CTRL|ALT', action = act.MoveTabRelative(-1) },
    { key = '}', mods = 'CTRL|ALT', action = act.MoveTabRelative(1) },
}
-- Switch tabs
for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|ALT',
        action = act.ActivateTab(i - 1),
    })
end

return config
