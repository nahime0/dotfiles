require('neo-tree').setup({
    close_if_last_window = true,
    hide_root_node = true,
    sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
    },
    source_selector = {
        winbar = true,
        statusline = false,
        -- separator = { left = "", right= "" },
        -- show_separator_on_edge = true,
        -- highlight_tab = "SidebarTabInactive",
        -- highlight_tab_active = "SidebarTabActive",
        -- highlight_background = "StatusLine",
        -- highlight_separator = "SidebarTabInactiveSeparator",
        -- highlight_separator_active = "SidebarTabActiveSeparator",
    },
    default_component_configs = {
        indent = {
            padding = 0,
        },
        name = {
            use_git_status_colors = false,
            highlight_opened_files = true,
        },
    },
    window = {
        mappings = {
            ["<cr>"] = "open_with_window_picker",
        },
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_by_name = {
                ".git",
            },
        },
        -- follow_current_file = {
        --   enabled = true,
        -- },
        group_empty_dirs = false
    },
})

vim.keymap.set('n', '<leader>n', ':Neotree reveal toggle<CR>')
