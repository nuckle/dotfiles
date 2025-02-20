local wezterm = require 'wezterm';

return {
	font = wezterm.font_with_fallback {
	  'Fira Code',
	  'Symbols Nerd Font',
	  'DejaVu Sans Mono',
	  'Noto Color Emoji'
	},

	font_size	= 12.0,
	animation_fps = 10,
	cursor_blink_rate = 1000,
	freetype_load_flags = 'NO_HINTING|MONOCHROME',
	window_close_confirmation = "NeverPrompt",

	front_end = 'WebGpu',
	window_background_opacity   	= 0.9,   
	enable_tab_bar              	= false, -- [true]
	hide_tab_bar_if_only_one_tab	= false, -- [false] hide the tab bar when there is only a single tab in the window
	window_padding = {
		  left = 0,
		  right = 5,
		  top = 0,
		  bottom = 0,
	 },
	color_scheme = 'Dracula (Official)',
	window_decorations = 'RESIZE',
	adjust_window_size_when_changing_font_size = false,

	enable_scroll_bar = true,
	warn_about_missing_glyphs = false,

	keys = {
	  { key = 'l', mods = 'CTRL|SHIFT', action = 'DisableDefaultAssignment' },
	  { key = 'k', mods = 'CTRL|SHIFT', action = 'IncreaseFontSize' },
	  { key = 'j', mods = 'CTRL|SHIFT', action = 'DecreaseFontSize' },
	  { key = 'c', mods = 'ALT', action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }) },
	  { key = 'v', mods = 'ALT', action = wezterm.action({ PasteFrom = "Clipboard" }) },
	  { key = 'k', mods = 'ALT|SHIFT', action = wezterm.action.ScrollByLine(-3)},
	  { key = 'j', mods = 'ALT|SHIFT', action = wezterm.action.ScrollByLine(3)},
	  { key = 'Enter', mods = 'ALT', action = 'DisableDefaultAssignment'},
	}

}
