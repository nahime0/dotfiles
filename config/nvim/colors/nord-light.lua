-- Nord Light colorscheme for Neovim
-- A light theme based on the Nord color palette (https://www.nordtheme.com/)
-- https://github.com/nord-light/neovim

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.o.background = 'light'
vim.g.colors_name = 'nord-light'

local c = {
  bg0 = '#E5E9F0', -- nord5, main background
  bg1 = '#D8DEE9', -- nord4, sidebar / statusline / inactive background
  bg2 = '#C8D0DA', -- selection / borders / visual
  muted = '#5F6A7E', -- comments, line numbers, disabled elements

  fg0 = '#2E3440', -- nord0, primary text
  fg1 = '#3B4252', -- nord1, secondary text
  fg2 = '#4C566A', -- nord3, punctuation / brackets

  red = '#AE4750', -- darkened nord11, errors
  orange = '#975943', -- darkened nord12, fields
  yellow = '#7F6614', -- darkened nord13, constants
  green = '#577140', -- darkened nord14, strings
  teal = '#1C7473', -- darkened nord7, classes/types
  cyan = '#0C7482', -- darkened nord8, functions
  blue2 = '#4B6C8C', -- darkened nord9, tags/operators
  blue = '#3B5E85', -- darkened nord10, keywords
  purple = '#865B7F', -- darkened nord15, numbers
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hl('Normal', { fg = c.fg0, bg = c.bg0 })
hl('NormalFloat', { fg = c.fg0, bg = c.bg1 })
hl('NormalNC', { fg = c.fg0, bg = c.bg0 })
hl('Cursor', { fg = c.bg0, bg = c.fg0 })
hl('CursorLine', { bg = c.bg1 })
hl('CursorLineNr', { fg = c.fg2, bold = true })
hl('CursorColumn', { bg = c.bg1 })
hl('LineNr', { fg = c.muted })
hl('SignColumn', { fg = c.muted, bg = c.bg0 })
hl('ColorColumn', { bg = c.bg2 })
hl('VertSplit', { fg = c.bg2, bg = c.bg0 })
hl('WinSeparator', { fg = c.bg2, bg = c.bg0 })
hl('StatusLine', { fg = c.fg0, bg = c.bg1 })
hl('StatusLineNC', { fg = c.fg2, bg = c.bg1 })
hl('TabLine', { fg = c.fg2, bg = c.bg1 })
hl('TabLineFill', { bg = c.bg1 })
hl('TabLineSel', { fg = c.fg0, bg = c.bg2, bold = true })
hl('Pmenu', { fg = c.fg0, bg = c.bg1 })
hl('PmenuSel', { fg = c.fg0, bg = c.bg2, bold = true })
hl('PmenuSbar', { bg = c.bg2 })
hl('PmenuThumb', { bg = c.muted })
hl('PmenuKind', { fg = c.cyan, bg = c.bg1 })
hl('PmenuKindSel', { fg = c.cyan, bg = c.bg2 })
hl('PmenuExtra', { fg = c.muted, bg = c.bg1 })
hl('PmenuExtraSel', { fg = c.muted, bg = c.bg2 })
hl('Visual', { bg = c.bg2 })
hl('VisualNOS', { bg = c.bg2 })
hl('Search', { fg = c.fg0, bg = c.yellow, bold = true })
hl('IncSearch', { fg = c.bg0, bg = c.cyan, bold = true })
hl('CurSearch', { fg = c.bg0, bg = c.orange, bold = true })
hl('Substitute', { fg = c.bg0, bg = c.orange })
hl('MatchParen', { fg = c.cyan, bold = true, underline = true })
hl('NonText', { fg = c.bg2 })
hl('EndOfBuffer', { fg = c.bg2 })
hl('Whitespace', { fg = c.bg2 })
hl('Directory', { fg = c.blue })
hl('Title', { fg = c.blue, bold = true })
hl('ModeMsg', { fg = c.fg0, bold = true })
hl('MoreMsg', { fg = c.green })
hl('Question', { fg = c.cyan })
hl('ErrorMsg', { fg = c.red, bold = true })
hl('WarningMsg', { fg = c.yellow, bold = true })
hl('FloatBorder', { fg = c.bg2, bg = c.bg1 })
hl('FloatermBorder', { fg = c.blue2, bg = c.bg1 })
hl('FloatTitle', { fg = c.blue, bg = c.bg1, bold = true })
hl('WinBar', { fg = c.fg0, bg = c.bg0 })
hl('WinBarNC', { fg = c.fg2, bg = c.bg0 })
hl('Folded', { fg = c.fg2, bg = c.bg1 })
hl('FoldColumn', { fg = c.muted, bg = c.bg0 })
hl('QuickFixLine', { bg = c.bg2, bold = true })
hl('SpellBad', { sp = c.red, undercurl = true })
hl('SpellCap', { sp = c.blue, undercurl = true })
hl('SpellRare', { sp = c.purple, undercurl = true })
hl('SpellLocal', { sp = c.cyan, undercurl = true })
hl('WildMenu', { fg = c.fg0, bg = c.bg2, bold = true })

-- Syntax
hl('Comment', { fg = c.muted, italic = true })
hl('Constant', { fg = c.yellow, bold = true })
hl('String', { fg = c.green })
hl('Character', { fg = c.green })
hl('Number', { fg = c.purple })
hl('Boolean', { fg = c.purple })
hl('Float', { fg = c.purple })
hl('Identifier', { fg = c.fg0 })
hl('Function', { fg = c.cyan })
hl('Statement', { fg = c.blue, bold = true })
hl('Conditional', { fg = c.blue, bold = true })
hl('Repeat', { fg = c.blue, bold = true })
hl('Label', { fg = c.blue })
hl('Operator', { fg = c.blue2 })
hl('Keyword', { fg = c.blue, bold = true })
hl('Exception', { fg = c.red, bold = true })
hl('PreProc', { fg = c.orange })
hl('Include', { fg = c.blue, bold = true })
hl('Define', { fg = c.blue })
hl('Macro', { fg = c.orange })
hl('PreCondit', { fg = c.orange })
hl('Type', { fg = c.teal })
hl('StorageClass', { fg = c.blue, bold = true })
hl('Structure', { fg = c.teal })
hl('Typedef', { fg = c.teal })
hl('Special', { fg = c.orange })
hl('SpecialChar', { fg = c.teal, bold = true })
hl('Tag', { fg = c.blue2 })
hl('Delimiter', { fg = c.fg2 })
hl('SpecialComment', { fg = c.muted, bold = true })
hl('Debug', { fg = c.red })
hl('Underlined', { fg = c.blue, underline = true })
hl('Ignore', { fg = c.muted })
hl('Error', { fg = c.bg0, bg = c.red, bold = true })
hl('Todo', { fg = c.yellow, bold = true, italic = true })

-- Diff
hl('DiffAdd', { bg = '#BAC5BB' })
hl('DiffChange', { bg = '#B2BFD0' })
hl('DiffDelete', { fg = c.red, bg = '#D5B8C0' })
hl('DiffText', { bg = '#7F96B0', bold = true })

-- Diagnostics
hl('DiagnosticError', { fg = c.red })
hl('DiagnosticWarn', { fg = c.yellow })
hl('DiagnosticInfo', { fg = c.cyan })
hl('DiagnosticHint', { fg = c.teal })
hl('DiagnosticOk', { fg = c.green })
hl('DiagnosticUnderlineError', { sp = c.red, undercurl = true })
hl('DiagnosticUnderlineWarn', { sp = c.yellow, undercurl = true })
hl('DiagnosticUnderlineInfo', { sp = c.cyan, undercurl = true })
hl('DiagnosticUnderlineHint', { sp = c.teal, undercurl = true })
hl('DiagnosticVirtualTextError', { fg = c.red, bg = '#DCCED6' })
hl('DiagnosticVirtualTextWarn', { fg = c.yellow, bg = '#D4D3CC' })
hl('DiagnosticVirtualTextInfo', { fg = c.cyan, bg = '#C1D6DE' })
hl('DiagnosticVirtualTextHint', { fg = c.teal, bg = '#C4D6DB' })

-- LSP
hl('LspReferenceText', { bg = c.bg2 })
hl('LspReferenceRead', { bg = c.bg2 })
hl('LspReferenceWrite', { bg = c.bg2, bold = true })
hl('LspCodeLens', { fg = c.muted })
hl('LspInlayHint', { fg = c.muted, bg = c.bg2 })
hl('LspSignatureActiveParameter', { bg = c.bg2, bold = true })

-- Treesitter
hl('@variable', { fg = c.fg0 })
hl('@variable.builtin', { fg = c.orange, italic = true })
hl('@variable.parameter', { fg = c.fg0, italic = true })
hl('@variable.member', { fg = c.orange })
hl('@constant', { fg = c.yellow, bold = true })
hl('@constant.builtin', { fg = c.purple })
hl('@string', { fg = c.green })
hl('@string.escape', { fg = c.teal, bold = true })
hl('@character', { fg = c.green })
hl('@number', { fg = c.purple })
hl('@boolean', { fg = c.purple })
hl('@function', { fg = c.cyan })
hl('@function.builtin', { fg = c.cyan, italic = true })
hl('@function.call', { fg = c.cyan })
hl('@method', { fg = c.cyan })
hl('@method.call', { fg = c.cyan })
hl('@constructor', { fg = c.teal })
hl('@keyword', { fg = c.blue, bold = true })
hl('@keyword.function', { fg = c.blue, bold = true })
hl('@keyword.operator', { fg = c.blue2 })
hl('@keyword.return', { fg = c.blue, bold = true })
hl('@conditional', { fg = c.blue, bold = true })
hl('@repeat', { fg = c.blue, bold = true })
hl('@operator', { fg = c.blue2 })
hl('@type', { fg = c.teal })
hl('@type.builtin', { fg = c.teal, italic = true })
hl('@type.definition', { fg = c.teal })
hl('@attribute', { fg = c.orange })
hl('@property', { fg = c.orange })
hl('@punctuation.delimiter', { fg = c.fg2 })
hl('@punctuation.bracket', { fg = c.fg2 })
hl('@punctuation.special', { fg = c.blue2 })
hl('@comment', { fg = c.muted, italic = true })
hl('@tag', { fg = c.blue2 })
hl('@tag.attribute', { fg = c.teal, italic = true })
hl('@tag.delimiter', { fg = c.fg2 })
hl('@markup.heading', { fg = c.blue, bold = true })
hl('@markup.strong', { fg = c.fg0, bold = true })
hl('@markup.italic', { fg = c.fg0, italic = true })
hl('@markup.link', { fg = c.blue, underline = true })

-- gitsigns.nvim
hl('GitSignsAdd', { fg = c.green })
hl('GitSignsChange', { fg = c.blue })
hl('GitSignsDelete', { fg = c.red })
