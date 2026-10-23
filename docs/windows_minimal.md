# Windows

Some instructions to quickly set up Windows to be usable in a pinch (with no admin access), with the following tools:

- Terminal (wezterm)
  - I'm quite used to tmux bindings, fortunately, most of them are configurable in wezterm
- Text Editor (neovim)

These programs are available as portable binaries, just download the official releases, unzip them and add them to your path.

## Terminal

Paste the following into `~\.wezterm.lua`

```lua
local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

config.prefer_egl = true -- set to true if running in a VM with no GPU
config.default_prog = { 'powershell.exe', '-NoLogo' }
config.color_scheme = 'GruvboxLight'

-- =============================================================================
-- CONSTANTS & GENERAL SETTINGS (tmux-sensible equivalents)
-- =============================================================================
config.scrollback_lines = 50000 -- set -g history-limit 50000

-- Tab Bar Emulation (tmux status line appearance)
config.tab_bar_at_bottom = true -- Place tab bar at bottom like tmux status bar
config.use_fancy_tab_bar = false -- Retro text-based tab bar for tmux feel
config.tab_and_split_indices_are_zero_based = false -- set -g base-index 1 & pane-base-index 1

-- =============================================================================
-- LEADER / PREFIX CONFIGURATION
-- =============================================================================
-- set -g prefix `
-- set -g repeat-time 1000
config.leader = { key = '`', mods = 'NONE', timeout_milliseconds = 1000 }

-- Visual indicator in right status when LEADER is active
wezterm.on('update-right-status', function(window, pane)
  if window:leader_is_active() then
    window:set_right_status(wezterm.format {
      { Background = { Color = '#e06c75' } },
      { Foreground = { Color = '#1e1e1e' } },
      { Attribute = { Intensity = 'Bold' } },
      { Text = ' ` LEADER ' },
    })
  else
    window:set_right_status('')
  end
end)

-- =============================================================================
-- KEYBINDINGS
-- =============================================================================
config.keys = {
  -- Double backtick sends a literal backtick: bind ` send-prefix
  { key = '`', mods = 'LEADER', action = act.SendKey { key = '`' } },

  -- ---------------------------------------------------------------------------
  -- WINDOW / TAB MANAGEMENT
  -- ---------------------------------------------------------------------------
  -- bind c new-window -c "#{pane_current_path}"
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

  -- bind [ swap-window -d -t -1
  { key = '[', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  -- bind ] swap-window -d -t +1
  { key = ']', mods = 'LEADER', action = act.MoveTabRelative(1) },

  -- ---------------------------------------------------------------------------
  -- SPLITS
  -- ---------------------------------------------------------------------------
  -- bind '"' split-window (vertical split in WezTerm terms = top/bottom)
  { key = '"', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- bind % split-window -h (horizontal split in WezTerm terms = left/right)
  { key = '%', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- ---------------------------------------------------------------------------
  -- PANE NAVIGATION (vim keys)
  -- ---------------------------------------------------------------------------
  -- bind h select-pane -L
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  -- bind j select-pane -D
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  -- bind k select-pane -U
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  -- bind l select-pane -R
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- ---------------------------------------------------------------------------
  -- COPY MODE & PASTING
  -- ---------------------------------------------------------------------------
  -- bind Enter copy-mode
  { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode },

  -- unbind i / bind i paste-buffer
  { key = 'i', mods = 'LEADER', action = act.PasteFrom 'Clipboard' },

  -- ---------------------------------------------------------------------------
  -- CONVENIENCE PARITY (tmux defaults)
  -- ---------------------------------------------------------------------------
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  { key = '&', mods = 'LEADER|SHIFT', action = act.CloseCurrentTab { confirm = true } },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
    description = 'Enter new name for tab',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:active_tab():set_title(line)
      end
    end),
    },
  },
}

-- Tab switching: <Leader> + 1..9 (set -g base-index 1 emulation)
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

-- =============================================================================
-- COPY MODE VI-KEYBINDINGS
-- =============================================================================
-- Inherit defaults (h, j, k, l, v, y, Esc) and add custom `Y` binding
if wezterm.gui then
  local copy_mode = wezterm.gui.default_key_tables().copy_mode

  -- bind -T copy-mode-vi Y send-keys -X begin-selection \; end-of-line \; copy-selection-and-cancel
  local copy_to_end_of_line = wezterm.action_callback(function(window, pane)
    window:perform_action(act.CopyMode { SetSelectionMode = 'Cell' }, pane)
    window:perform_action(act.CopyMode 'MoveToEndOfLineContent', pane)
    local text = window:get_selection_text_for_pane(pane)
    if text and text ~= '' then
      window:copy_to_clipboard(text, 'ClipboardAndPrimarySelection')
    end
    window:perform_action(act.ClearSelection, pane)
    window:perform_action(act.CopyMode 'Close', pane)
  end)

  table.insert(copy_mode, { key = 'y', mods = 'SHIFT', action = copy_to_end_of_line })
  table.insert(copy_mode, { key = 'Y', mods = 'SHIFT', action = copy_to_end_of_line })
  table.insert(copy_mode, { key = 'Y', mods = 'NONE',  action = copy_to_end_of_line })

  config.key_tables = {
    copy_mode = copy_mode,
  }
end

return config
```

## Text Editor

We'll be using nvim, add it to `~\AppData\Local\nvim\init.lua`

```lua
-- Theme
vim.cmd("colorscheme retrobox")
vim.o.background = "light"

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- OSC 52 clipboard
vim.g.clipboard = "osc52"
vim.o.clipboard = "unnamedplus"

-- QOL
vim.o.ignorecase = true     -- Case-insensitive search
vim.o.smartcase = true      -- Smart case search
vim.o.scrolloff = 8         -- Keeps 8 lines visible when scrolling
vim.o.termguicolors = true  -- 24-bit RGB colors
```
