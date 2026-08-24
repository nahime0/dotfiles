# Keymap

Keybindings configured across the tools in this repository.

- [AeroSpace](#aerospace)
  - [Layout](#layout)
  - [Focus](#focus)
  - [Move windows](#move-windows)
  - [Resize](#resize)
  - [Workspaces](#workspaces)
  - [Monitors](#monitors)
  - [Service mode](#service-mode)
- [Tmux](#tmux)
- [Zellij](#zellij)
- [Neovim](#neovim)
- [Vimium](#vimium)
  - [Page navigation](#page-navigation)
  - [Links and pages](#links-and-pages)
  - [Find and history](#find-and-history)
  - [Tabs](#tabs)
  - [Marks and advanced navigation](#marks-and-advanced-navigation)
- [fzf](#fzf)

## AeroSpace

Modifier scheme: **⌘⌃ (cmd-ctrl)** for focus/workspace/layout, **⌥⌃ (alt-ctrl)** to move windows.

Config: [`config/aerospace/aerospace.toml`](../config/aerospace/aerospace.toml)

### Layout

| Keybinding | Action |
|------------|--------|
| `⌘⌃ /` | Toggle tiling layout (horizontal/vertical) |
| `⌘⌃ ,` | Accordion layout (horizontal/vertical) |
| `⌥⌃ F` | Fullscreen |

### Focus

Vim-style `hjkl` navigation.

| Keybinding | Action |
|------------|--------|
| `⌘⌃ H` | Focus left |
| `⌘⌃ J` | Focus down |
| `⌘⌃ K` | Focus up |
| `⌘⌃ L` | Focus right |

### Move windows

| Keybinding | Action |
|------------|--------|
| `⌥⌃ H` | Move window left |
| `⌥⌃ J` | Move window down |
| `⌥⌃ K` | Move window up |
| `⌥⌃ L` | Move window right |

### Resize

| Keybinding | Action |
|------------|--------|
| `⌘⌃ -` | Resize smart -50 |
| `⌘⌃ =` | Resize smart +50 |

### Workspaces

| Keybinding | Action |
|------------|--------|
| `⌘⌃ 0-9` | Switch to workspace 0-9 |
| `⌥⌃ 0-9` | Move window to workspace 0-9 |
| `⌘⌃ W/E/R/T/Y/U/I/O/P` | Switch to the corresponding letter workspace |
| `⌥⌃ W/E/R/T/Y/U/I/O/P` | Move window to the corresponding letter workspace |
| `⌘⌃ Z/X/C/V/B/N/M` | Switch to the corresponding letter workspace |
| `⌥⌃ Z/X/C/V/B/N/M` | Move window to the corresponding letter workspace |
| `⌘⌃ Tab` | Toggle between the last two workspaces |

### Monitors

| Keybinding | Action |
|------------|--------|
| `⌥⌃ Tab` | Move current workspace to the next monitor (wrap-around) |

Workspaces 1-3 are pinned to their physical displays:

| Workspace | Display |
|-----------|---------|
| `1` | Built-in Retina Display |
| `2` | LG HDR 4K |
| `3` | LG ULTRAWIDE |

If a display is disconnected, AeroSpace can temporarily show its workspace on
another display; the fixed assignment applies again when the display returns.
If it does not move immediately, switch to another workspace and back.

### Service mode

Enter service mode with `⌥⌃ ;`. Every action returns to the main mode.

| Keybinding | Action |
|------------|--------|
| `Esc` | Reload config |
| `R` | Reset layout (flatten workspace tree) |
| `F` | Toggle floating/tiling for the focused window |
| `Backspace` | Close all windows but the current one |
| `⌥⌃ H` | Join with the window on the left |
| `⌥⌃ J` | Join with the window below |
| `⌥⌃ K` | Join with the window above |
| `⌥⌃ L` | Join with the window on the right |

## Tmux

Prefix key: `Ctrl-q`.

| Keybinding | Action |
|------------|--------|
| `Ctrl-q e` | Open the current pane scrollback in a Neovim popup |

## Zellij

`Ctrl-h/j/k/l` navigates seamlessly between Neovim splits and Zellij panes. At the outer horizontal edge, `Ctrl-h/l` continues to the previous or next Zellij tab.

| Keybinding | Action |
|------------|--------|
| `Ctrl-h/j/k/l` | Navigate left/down/up/right through Neovim and Zellij |
| `Ctrl-q c` | Open a new tab |
| `Ctrl-q n/p` | Go to the next/previous tab |
| `Ctrl-q %` | Open a pane on the right |
| `Ctrl-q "` | Open a pane below |
| `Ctrl-q z` | Toggle focused pane fullscreen |
| `Ctrl-q [` | Enter scroll mode |
| `Ctrl-q d` | Detach from the session |
| `Ctrl-p m`, then `h/j/k/l` | Move the focused pane |
| `Ctrl-t a` | Open the note for the current tab |
| `Ctrl-t h/l` | Go to the previous/next tab |
| `Ctrl-t k/j` | Move the current tab left/right |

## Neovim

Leader key: `Space`.

| Keybinding | Action |
|------------|--------|
| `<leader>f` | Neotree (file browser) |
| `<leader>n` | Neotree reveal toggle |
| `<leader>o` | Telescope find_files |
| `<leader>O` | Telescope find_files (all files) |
| `<leader>e` | Telescope oldfiles (recent files) |
| `<leader>b` | Telescope buffers |
| `<leader>g` | Telescope live grep |
| `<leader>s` | Telescope LSP document symbols |
| `Alt+Enter` | Copilot accept (insert mode) |
| `Tab` | Completion menu: next item (nvim-cmp) |

## Vimium

Default Vimium keybindings. Press `?` in the browser to show the complete keymap available in the installed version.

### Page navigation

| Keybinding | Action |
|------------|--------|
| `h` / `j` / `k` / `l` | Scroll left / down / up / right |
| `gg` | Scroll to the top of the page |
| `G` | Scroll to the bottom of the page |
| `d` / `u` | Scroll down / up half a page |
| `zH` / `zL` | Scroll all the way left / right |
| `r` | Reload the page |
| `R` | Hard reload the page, bypassing the cache |
| `i` | Enter insert mode; press `Esc` to exit |
| `gf` | Focus the next frame |
| `gF` | Focus the main frame |

### Links and pages

| Keybinding | Action |
|------------|--------|
| `f` | Open a link in the current tab |
| `F` | Open a link in a new tab |
| `Alt+F` | Open multiple links in new tabs |
| `o` | Open a URL, bookmark, or history entry |
| `O` | Open a URL, bookmark, or history entry in a new tab |
| `b` | Open a bookmark |
| `B` | Open a bookmark in a new tab |
| `ge` | Edit the current URL |
| `gE` | Edit the current URL and open it in a new tab |
| `gu` | Go up one level in the URL hierarchy |
| `gU` | Go to the root of the URL hierarchy |
| `gs` | View the page source |
| `yy` | Copy the current URL |
| `yf` | Copy a link URL |

### Find and history

| Keybinding | Action |
|------------|--------|
| `/` | Enter find mode |
| `n` / `N` | Go to the next / previous match |
| `H` / `L` | Go back / forward in browser history |

### Tabs

| Keybinding | Action |
|------------|--------|
| `J` or `gT` | Go to the tab on the left |
| `K` or `gt` | Go to the tab on the right |
| `g0` | Go to the first tab; prefix with a number for the n-th tab |
| `g$` | Go to the last tab |
| `^` | Go to the previously visited tab |
| `t` | Open a new tab |
| `yt` | Duplicate the current tab |
| `x` | Close the current tab |
| `X` | Restore the last closed tab |
| `T` | Search open tabs |
| `W` | Move the current tab to a new window |
| `Alt+P` | Pin or unpin the current tab |

### Marks and advanced navigation

| Keybinding | Action |
|------------|--------|
| `ma` / `mA` | Set local mark `a` / global mark `A` |
| `` `a `` / `` `A `` | Jump to local mark `a` / global mark `A` |
| <code>``</code> | Jump back to the position before the previous jump |
| `]]` / `[[` | Follow the next / previous page link |
| `gi` | Focus the first text input; use `Tab` to cycle |
| `v` / `V` | Enter visual / visual-line mode |
| `Esc` or `Ctrl+[` | Clear a partial command or exit insert/find mode |

Commands accept numeric prefixes: for example, `5t` opens five tabs.

## fzf

| Keybinding | Action |
|------------|--------|
| `Ctrl+R` | Fuzzy search shell history |
| `Ctrl+T` | Fuzzy search files |
