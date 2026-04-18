-- Generated with wallust
-- Adaptive Neovim Colorscheme
-- Migrated from matugen Material You → wallust 16-color palette + filters

vim.cmd("highlight clear")
if vim.g.colors_name then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "adaptive"
vim.g.loaded_adaptive = 1

-- ── Palette ────────────────────────────────────────────────────
--
-- Wallust color roles for this wallpaper (dark purple/blue theme):
--   color0  = deep dark bg      color8  = muted gray
--   color1  = dark purple       color9  = bright purple
--   color2  = steel blue        color10 = bright blue
--   color3  = deep magenta      color11 = vivid magenta
--   color4  = deep violet       color12 = bright violet
--   color5  = navy              color13 = dark navy
--   color6  = steel blue alt    color14 = medium blue
--   color7  = light blue-gray   color15 = light blue-gray
--
-- Filter conventions:
--   lighten(0.X) = shift toward white by X%
--   darken(0.X)  = shift toward black by X%

local p = {
	-- Text
	fg = "#D5C4EA",
	muted = "#827297",
	subtle = "#9B8EAC",

	-- Surfaces (graduated from background)
	surface0 = "#2E1E42",
	surface1 = "#35264A",
	surface2 = "#3B2C4F",
	surface3 = "#423355",
	surface4 = "#483A5A",

	-- Borders
	overlay = "#6E6180",

	-- ── Syntax colors ──
	-- Keywords & control flow: saturated purple
	keyword = "#8658C2",
	keyword_deep = "#644292",

	-- Functions & methods: bright blue
	func = "#865CC5",

	-- Strings: lighter blue to stand out
	string = "#9DB4EC",

	-- Types: steel blue
	type = "#7953B1",

	-- Constants & numbers: magenta accent
	constant = "#815FC5",

	-- Properties: blue
	property = "#644594",

	-- Operators: muted tone
	operator = "#8F80A1",

	-- Preprocessor, macros, annotations: navy-light
	macro = "#8293BD",

	-- ── UI accent colors ──
	accent = "#8658C2",
	accent2 = "#865CC5",
	red = "#907EB3",

	-- Tonal: primary (purple shades)
	primary_5 = "#2F4044",
	primary_40 = "#644292",
	primary_50 = "#74559D",
	primary_60 = "#8658C2",
	primary_70 = "#9269C8",

	-- Tonal: secondary (blue shades)
	secondary_50 = "#6378AD",
	secondary_60 = "#84A1E7",
	secondary_70 = "#90AAE9",

	-- Tonal: tertiary (blue-magenta shades)
	tertiary_30 = "#5A3E85",
	tertiary_40 = "#644594",
	tertiary_50 = "#7953B1",
	tertiary_60 = "#865CC5",
	tertiary_70 = "#926CCB",

	-- Tonal: error (magenta/red shades)
	error_10 = "#4E3976",
	error_30 = "#574084",
	error_40 = "#614793",
	error_50 = "#71599E",
	error_60 = "#815FC5",
	error_70 = "#8E6FCB",

	-- Tonal: neutral
	neutral_10 = "#304145",
	neutral_40 = "#756788",
	neutral_50 = "#827297",
	neutral_60 = "#8F80A1",
	neutral_70 = "#9B8EAC",
	neutral_80 = "#BAA3D8",
}

local hl = vim.api.nvim_set_hl

-- ── Editor ─────────────────────────────────────────────────────

hl(0, "Normal", { fg = p.fg })
hl(0, "NormalNC", { fg = p.fg })
hl(0, "NormalFloat", { fg = p.fg, bg = "none" })
hl(0, "FloatBorder", { fg = p.muted, bg = "none" })
hl(0, "FloatTitle", { fg = p.accent, bg = "none", bold = true })
hl(0, "FloatFooter", { fg = p.muted, bg = "none" })

-- Cursor
hl(0, "Cursor", { fg = p.surface0, bg = p.accent })
hl(0, "CursorIM", { link = "Cursor" })
hl(0, "CursorLine", { bg = p.surface1 })
hl(0, "CursorColumn", { link = "CursorLine" })
hl(0, "CursorLineSign", { bg = p.surface1 })
hl(0, "CursorLineFold", { bg = p.surface1 })
hl(0, "CursorLineNr", { fg = p.accent, bold = true })

-- Line numbers
hl(0, "LineNr", { fg = p.muted })
hl(0, "LineNrAbove", { fg = p.muted })
hl(0, "LineNrBelow", { fg = p.muted })

-- Sign column
hl(0, "SignColumn", { fg = p.muted })

-- Folding
hl(0, "FoldColumn", { fg = p.muted })
hl(0, "Folded", { fg = p.muted, bg = p.surface1, italic = true })

-- Parentheses
hl(0, "MatchParen", { fg = p.accent, bg = p.surface3, bold = true })

-- Status line
hl(0, "StatusLine", { fg = p.fg })
hl(0, "StatusLineNC", { fg = p.muted })
hl(0, "StatusLineTerm", { link = "StatusLine" })
hl(0, "StatusLineTermNC", { link = "StatusLineNC" })

-- Tab line
hl(0, "TabLine", { fg = p.fg, bg = p.surface2 })
hl(0, "TabLineFill", { fg = p.fg })
hl(0, "TabLineSel", { fg = p.accent, bold = true })

-- Winbar
hl(0, "WinBar", { fg = p.fg, bg = "none" })
hl(0, "WinBarNC", { fg = p.muted, bg = "none" })
hl(0, "WinSeparator", { fg = p.overlay })

-- Popup menu
hl(0, "Pmenu", { fg = p.fg, bg = p.surface2 })
hl(0, "PmenuSel", { fg = p.fg, bg = p.surface3, bold = true })
hl(0, "PmenuSbar", { bg = p.surface1 })
hl(0, "PmenuThumb", { bg = p.muted })
hl(0, "PmenuMatch", { fg = p.accent, bg = p.surface2 })
hl(0, "PmenuMatchSel", { fg = p.accent, bg = p.surface3, bold = true })

-- Search
hl(0, "Search", { fg = p.fg, bg = p.primary_40, italic = true })
hl(0, "IncSearch", { fg = p.fg, bg = p.primary_40, bold = true })
hl(0, "CurSearch", { link = "IncSearch" })
hl(0, "Substitute", { fg = p.fg, bg = p.error_40 })

-- Visual
hl(0, "Visual", { bg = p.surface3 })
hl(0, "VisualNOS", { link = "Visual" })

-- Conceal
hl(0, "Conceal", { fg = p.muted })

-- Messages
hl(0, "ModeMsg", { fg = p.subtle })
hl(0, "MsgArea", { fg = p.fg })
hl(0, "MsgSeparator", { fg = p.overlay })
hl(0, "MoreMsg", { fg = p.accent })
hl(0, "Question", { fg = p.accent })
hl(0, "WarningMsg", { fg = p.red })
hl(0, "Error", { fg = p.red })
hl(0, "ErrorMsg", { fg = p.red })

-- Spell
hl(0, "SpellBad", { undercurl = true, sp = p.red })
hl(0, "SpellCap", { undercurl = true, sp = p.accent })
hl(0, "SpellLocal", { undercurl = true, sp = p.accent2 })
hl(0, "SpellRare", { undercurl = true, sp = p.accent2 })

-- Diff
hl(0, "DiffAdd", { bg = p.surface1 })
hl(0, "DiffDelete", { bg = p.surface1 })
hl(0, "DiffChange", { bg = p.surface1 })
hl(0, "DiffText", { bg = p.surface2 })
hl(0, "diffAdded", { fg = p.tertiary_60 })
hl(0, "diffRemoved", { fg = p.error_60 })
hl(0, "diffChanged", { fg = p.primary_60 })
hl(0, "diffOldFile", { fg = p.error_60 })
hl(0, "diffNewFile", { fg = p.tertiary_60 })

-- Misc
hl(0, "Directory", { fg = p.accent })
hl(0, "Title", { fg = p.accent, bold = true })
hl(0, "EndOfBuffer", { fg = p.muted })
hl(0, "NonText", { fg = p.overlay })
hl(0, "SpecialKey", { fg = p.muted })
hl(0, "Whitespace", { fg = p.overlay })
hl(0, "WildMenu", { fg = p.fg, bg = p.surface3 })
hl(0, "QuickFixLine", { bg = p.surface2 })
hl(0, "ColorColumn", { bg = p.surface1 })

-- Menus
hl(0, "Menu", { fg = p.fg, bg = p.surface2 })
hl(0, "Scrollbar", { fg = p.muted })

-- Mode indicators
hl(0, "NormalMode", { fg = p.accent })
hl(0, "InsertMode", { fg = p.tertiary_60 })
hl(0, "VisualMode", { fg = p.accent2 })
hl(0, "CommandMode", { fg = p.accent })
hl(0, "ReplaceMode", { fg = p.error_60 })
hl(0, "SelectMode", { fg = p.accent2 })
hl(0, "TerminalMode", { fg = p.tertiary_60 })
hl(0, "OperatorPendingMode", { fg = p.subtle })

-- ── Syntax (Legacy Vim) ────────────────────────────────────────

hl(0, "Comment", { fg = p.muted, italic = true })
hl(0, "Constant", { fg = p.constant })
hl(0, "String", { fg = p.string })
hl(0, "Character", { link = "String" })
hl(0, "Number", { fg = p.constant })
hl(0, "Boolean", { fg = p.constant, italic = true })
hl(0, "Float", { link = "Number" })
hl(0, "Identifier", { fg = p.fg })
hl(0, "Function", { fg = p.func })
hl(0, "Statement", { fg = p.keyword, italic = true })
hl(0, "Conditional", { fg = p.keyword, italic = true })
hl(0, "Repeat", { fg = p.keyword, italic = true })
hl(0, "Label", { fg = p.keyword })
hl(0, "Operator", { fg = p.operator })
hl(0, "Keyword", { fg = p.keyword, italic = true })
hl(0, "Exception", { fg = p.red })
hl(0, "PreProc", { fg = p.macro })
hl(0, "Include", { fg = p.keyword })
hl(0, "Define", { fg = p.keyword })
hl(0, "Macro", { fg = p.macro })
hl(0, "PreCondit", { link = "PreProc" })
hl(0, "Type", { fg = p.type, italic = true })
hl(0, "StorageClass", { fg = p.type, italic = true })
hl(0, "Structure", { fg = p.type, italic = true })
hl(0, "Typedef", { fg = p.type, italic = true })
hl(0, "Special", { fg = p.string })
hl(0, "SpecialChar", { fg = p.keyword })
hl(0, "Tag", { fg = p.keyword })
hl(0, "Delimiter", { fg = p.operator })
hl(0, "SpecialComment", { fg = p.muted, italic = true })
hl(0, "Debug", { fg = p.red })
hl(0, "Todo", { fg = p.keyword, bg = p.surface2, bold = true, italic = true })
hl(0, "Ignore", { fg = p.muted })
hl(0, "Underlined", { fg = p.accent, underline = true })

-- ── Treesitter ─────────────────────────────────────────────────

-- Comments
hl(0, "@comment", { link = "Comment" })
hl(0, "@comment.error", { fg = p.red, italic = true })
hl(0, "@comment.warning", { fg = p.error_70, italic = true })
hl(0, "@comment.note", { fg = p.keyword, italic = true })
hl(0, "@comment.todo", { fg = p.keyword, bg = p.surface2, bold = true, italic = true })

-- Constants
hl(0, "@constant", { fg = p.constant })
hl(0, "@constant.builtin", { fg = p.constant, italic = true })
hl(0, "@constant.macro", { fg = p.macro })
hl(0, "@number", { fg = p.constant })
hl(0, "@number.float", { fg = p.constant })
hl(0, "@boolean", { fg = p.constant, italic = true })
hl(0, "@character", { link = "String" })
hl(0, "@character.special", { fg = p.keyword })

-- Strings
hl(0, "@string", { fg = p.string })
hl(0, "@string.regexp", { fg = p.keyword })
hl(0, "@string.escape", { fg = p.keyword })
hl(0, "@string.special", { fg = p.keyword })
hl(0, "@string.special.path", { fg = p.type })
hl(0, "@string.special.url", { fg = p.type, underline = true })
hl(0, "@string.special.symbol", { fg = p.constant })

-- Identifiers
hl(0, "@identifier", { fg = p.fg })
hl(0, "@identifier.builtin", { fg = p.keyword, italic = true })
hl(0, "@identifier.function", { fg = p.func })
hl(0, "@identifier.function.call", { fg = p.func })
hl(0, "@identifier.method", { fg = p.func })
hl(0, "@identifier.method.call", { fg = p.func })

-- Variables
hl(0, "@variable", { fg = p.fg })
hl(0, "@variable.builtin", { fg = p.keyword, italic = true })
hl(0, "@variable.member", { fg = p.fg })
hl(0, "@variable.parameter", { fg = p.subtle, italic = true })

-- Keywords
hl(0, "@keyword", { fg = p.keyword, italic = true })
hl(0, "@keyword.conditional", { fg = p.keyword, italic = true })
hl(0, "@keyword.conditional.ternary", { fg = p.keyword, italic = true })
hl(0, "@keyword.repeat", { fg = p.keyword, italic = true })
hl(0, "@keyword.return", { fg = p.keyword, italic = true })
hl(0, "@keyword.exception", { fg = p.red })
hl(0, "@keyword.import", { fg = p.keyword })
hl(0, "@keyword.coroutine", { fg = p.keyword })
hl(0, "@keyword.operator", { fg = p.keyword, italic = true })
hl(0, "@keyword.directive", { fg = p.macro })
hl(0, "@keyword.directive.define", { fg = p.macro })
hl(0, "@keyword.storage", { fg = p.type, italic = true })
hl(0, "@keyword.debug", { fg = p.red })
hl(0, "@keyword.function", { fg = p.keyword, italic = true })

-- Operators
hl(0, "@operator", { fg = p.operator })

-- Types
hl(0, "@type", { fg = p.type, italic = true })
hl(0, "@type.builtin", { fg = p.type, italic = true })
hl(0, "@type.definition", { fg = p.type, italic = true })
hl(0, "@type.qualifier", { fg = p.type, italic = true })

-- Attributes & Properties
hl(0, "@attribute", { fg = p.macro })
hl(0, "@attribute.builtin", { fg = p.macro, italic = true })
hl(0, "@property", { fg = p.property })

-- Punctuation
hl(0, "@punctuation.bracket", { fg = p.operator })
hl(0, "@punctuation.delimiter", { fg = p.operator })
hl(0, "@punctuation.special", { fg = p.keyword })

-- Markup
hl(0, "@markup.heading", { fg = p.keyword, bold = true })
hl(0, "@markup.heading.1", { fg = p.keyword, bold = true })
hl(0, "@markup.heading.2", { fg = p.func, bold = true })
hl(0, "@markup.heading.3", { fg = p.type, bold = true })
hl(0, "@markup.heading.4", { fg = p.string, bold = true })
hl(0, "@markup.heading.5", { fg = p.macro, bold = true })
hl(0, "@markup.heading.6", { fg = p.constant, bold = true })
hl(0, "@markup.italic", { italic = true })
hl(0, "@markup.bold", { bold = true })
hl(0, "@markup.strikethrough", { strikethrough = true })
hl(0, "@markup.underline", { underline = true })
hl(0, "@markup.list", { fg = p.keyword })
hl(0, "@markup.list.checked", { fg = p.type })
hl(0, "@markup.list.unchecked", { fg = p.muted })
hl(0, "@markup.link", { fg = p.func, underline = true })
hl(0, "@markup.link.label", { fg = p.keyword })
hl(0, "@markup.link.url", { fg = p.type, underline = true })
hl(0, "@markup.raw", { fg = p.string })
hl(0, "@markup.raw.block", { fg = p.fg, bg = p.surface1 })
hl(0, "@markup.quote", { fg = p.muted, italic = true })

-- Tags (HTML/XML/Svelte)
hl(0, "@tag", { fg = p.keyword })
hl(0, "@tag.attribute", { fg = p.string })
hl(0, "@tag.delimiter", { fg = p.operator })

-- Diff (treesitter)
hl(0, "@diff.plus", { fg = p.tertiary_60 })
hl(0, "@diff.minus", { fg = p.error_60 })
hl(0, "@diff.delta", { fg = p.primary_60 })

-- Legacy text groups (backward compat)
hl(0, "@text", { fg = p.fg })
hl(0, "@text.reference", { fg = p.keyword })
hl(0, "@text.todo.unchecked", { fg = p.muted })
hl(0, "@text.todo.checked", { fg = p.type })
hl(0, "@text.danger", { fg = p.red })
hl(0, "@text.warning", { fg = p.error_70 })
hl(0, "@text.note", { fg = p.keyword })
hl(0, "@text.emphasis", { italic = true })
hl(0, "@text.strong", { bold = true })
hl(0, "@text.strike", { strikethrough = true })
hl(0, "@text.uri", { fg = p.type, underline = true })
hl(0, "@text.literal", { fg = p.string })
hl(0, "@text.title", { fg = p.keyword, bold = true })
hl(0, "@text.quote", { fg = p.muted, italic = true })

-- Label
hl(0, "@label", { fg = p.keyword })
hl(0, "@none", {})

-- ── Diagnostics ────────────────────────────────────────────────

hl(0, "DiagnosticError", { fg = p.red })
hl(0, "DiagnosticWarn", { fg = p.error_70 })
hl(0, "DiagnosticInfo", { fg = p.primary_60 })
hl(0, "DiagnosticHint", { fg = p.secondary_60 })
hl(0, "DiagnosticOk", { fg = p.tertiary_60 })

hl(0, "DiagnosticSignError", { fg = p.red })
hl(0, "DiagnosticSignWarn", { fg = p.error_70 })
hl(0, "DiagnosticSignInfo", { fg = p.primary_60 })
hl(0, "DiagnosticSignHint", { fg = p.secondary_60 })
hl(0, "DiagnosticSignOk", { fg = p.tertiary_60 })

hl(0, "DiagnosticVirtualTextError", { fg = p.error_40, bg = p.error_10 })
hl(0, "DiagnosticVirtualTextWarn", { fg = p.error_70, bg = p.surface1 })
hl(0, "DiagnosticVirtualTextInfo", { fg = p.primary_60, bg = p.surface1 })
hl(0, "DiagnosticVirtualTextHint", { fg = p.primary_50, bg = p.primary_5 })
hl(0, "DiagnosticVirtualTextOk", { fg = p.tertiary_60, bg = p.surface1 })

hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = p.red })
hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = p.error_70 })
hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = p.primary_60 })
hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = p.secondary_60 })
hl(0, "DiagnosticUnderlineOk", { undercurl = true, sp = p.tertiary_60 })

hl(0, "DiagnosticFloatingError", { fg = p.red, bg = p.surface2 })
hl(0, "DiagnosticFloatingWarn", { fg = p.error_70, bg = p.surface2 })
hl(0, "DiagnosticFloatingInfo", { fg = p.primary_60, bg = p.surface2 })
hl(0, "DiagnosticFloatingHint", { fg = p.secondary_60, bg = p.surface2 })
hl(0, "DiagnosticFloatingOk", { fg = p.tertiary_60, bg = p.surface2 })

-- ── LSP ────────────────────────────────────────────────────────

hl(0, "LspReferenceText", { bg = p.surface3 })
hl(0, "LspReferenceRead", { bg = p.surface3 })
hl(0, "LspReferenceWrite", { bg = p.surface3, underline = true })
hl(0, "LspCodeLens", { fg = p.muted })
hl(0, "LspCodeLensSeparator", { fg = p.overlay })
hl(0, "LspSignatureActiveParameter", { fg = p.accent, bold = true })
hl(0, "LspInlayHint", { fg = p.muted, bg = "none", italic = true })

-- ── LSP Semantic Tokens ────────────────────────────────────────

hl(0, "@lsp.type.class", { fg = p.type })
hl(0, "@lsp.type.decorator", { fg = p.macro })
hl(0, "@lsp.type.enum", { fg = p.type })
hl(0, "@lsp.type.enumMember", { fg = p.type })
hl(0, "@lsp.type.function", { fg = p.func })
hl(0, "@lsp.type.interface", { fg = p.type })
hl(0, "@lsp.type.macro", { fg = p.macro })
hl(0, "@lsp.type.method", { fg = p.func })
hl(0, "@lsp.type.namespace", { fg = p.macro })
hl(0, "@lsp.type.parameter", { fg = p.subtle, italic = true })
hl(0, "@lsp.type.property", { fg = p.property })
hl(0, "@lsp.type.struct", { fg = p.type })
hl(0, "@lsp.type.type", { fg = p.type })
hl(0, "@lsp.type.typeParameter", { fg = p.type })
hl(0, "@lsp.type.variable", { fg = p.fg })
hl(0, "@lsp.type.keyword", { fg = p.keyword })
hl(0, "@lsp.type.comment", { fg = p.muted, italic = true })
hl(0, "@lsp.type.string", { fg = p.string })
hl(0, "@lsp.type.number", { fg = p.constant })
hl(0, "@lsp.type.regexp", { fg = p.keyword })
hl(0, "@lsp.type.operator", { fg = p.operator })
hl(0, "@lsp.mod.deprecated", { fg = p.muted, strikethrough = true })
hl(0, "@lsp.mod.readonly", { fg = p.constant })
hl(0, "@lsp.mod.static", { italic = true })
hl(0, "@lsp.typemod.function.defaultLibrary", { fg = p.keyword })
hl(0, "@lsp.typemod.variable.defaultLibrary", { fg = p.keyword })
hl(0, "@lsp.typemod.variable.readonly", { fg = p.constant })

-- ── Terminal Colors ────────────────────────────────────────────

vim.g.terminal_color_0 = "#304145"
vim.g.terminal_color_1 = "#614793"
vim.g.terminal_color_2 = "#865CC5"
vim.g.terminal_color_3 = "#815FC5"
vim.g.terminal_color_4 = "#8658C2"
vim.g.terminal_color_5 = "#644292"
vim.g.terminal_color_6 = "#84A1E7"
vim.g.terminal_color_7 = "#D5C4EA"
vim.g.terminal_color_8 = "#6E7A7D"
vim.g.terminal_color_9 = "#907EB3"
vim.g.terminal_color_10 = "#AA8DD6"
vim.g.terminal_color_11 = "#A78FD6"
vim.g.terminal_color_12 = "#AA8AD4"
vim.g.terminal_color_13 = "#937BB3"
vim.g.terminal_color_14 = "#A9BDEE"
vim.g.terminal_color_15 = "#E2D6F0"

-- ── Plugin: Telescope ──────────────────────────────────────────

hl(0, "TelescopeNormal", { fg = p.fg, bg = p.surface2 })
hl(0, "TelescopeBorder", { fg = p.overlay, bg = "none" })
hl(0, "TelescopeTitle", { fg = p.accent, bg = "none", bold = true })
hl(0, "TelescopePrompt", { fg = p.fg, bg = p.surface2 })
hl(0, "TelescopePromptBorder", { fg = p.overlay, bg = "none" })
hl(0, "TelescopePromptTitle", { fg = p.accent, bg = "none", bold = true })
hl(0, "TelescopePromptCounter", { fg = p.muted })
hl(0, "TelescopePromptPrefix", { fg = p.accent })
hl(0, "TelescopePromptMatch", { fg = p.accent, bg = p.surface3 })
hl(0, "TelescopeResults", { fg = p.fg, bg = p.surface1 })
hl(0, "TelescopeResultsBorder", { fg = p.overlay, bg = "none" })
hl(0, "TelescopeResultsTitle", { fg = p.accent, bg = "none" })
hl(0, "TelescopePreview", { fg = p.fg, bg = p.surface1 })
hl(0, "TelescopePreviewBorder", { fg = p.overlay, bg = "none" })
hl(0, "TelescopePreviewTitle", { fg = p.accent, bg = "none" })
hl(0, "TelescopeSelection", { fg = p.fg, bg = p.surface3 })
hl(0, "TelescopeSelectionCaret", { fg = p.accent })
hl(0, "TelescopeMatching", { fg = p.accent, bold = true })
hl(0, "TelescopeMultiSelection", { fg = p.accent2, bg = p.surface2 })
hl(0, "TelescopeMultiIcon", { fg = p.accent })
hl(0, "TelescopeFileIgnored", { fg = p.muted })

-- ── Plugin: Neo-tree ───────────────────────────────────────────

hl(0, "NeoTreeNormal", { fg = p.fg })
hl(0, "NeoTreeNormalNC", { fg = p.fg })
hl(0, "NeoTreeEndOfBuffer", { fg = p.muted })
hl(0, "NeoTreeCursorLine", { bg = p.surface2 })
hl(0, "NeoTreeCursorLineSign", { fg = p.accent, bg = p.surface2 })
hl(0, "NeoTreeSignColumn", { fg = p.muted })
hl(0, "NeoTreeIndentMarker", { fg = p.overlay })
hl(0, "NeoTreeRootName", { fg = p.accent, bold = true })
hl(0, "NeoTreeDirectoryName", { fg = p.fg })
hl(0, "NeoTreeDirectoryIcon", { fg = p.accent })
hl(0, "NeoTreeFileName", { fg = p.fg })
hl(0, "NeoTreeFileNameOpened", { fg = p.accent, bold = true })
hl(0, "NeoTreeFilterTerm", { fg = p.accent, bold = true })
hl(0, "NeoTreeFloatBorder", { fg = p.overlay })
hl(0, "NeoTreeFloatTitle", { fg = p.accent, bold = true })
hl(0, "NeoTreeGitAdded", { fg = p.tertiary_60 })
hl(0, "NeoTreeGitConflict", { fg = p.red, bold = true })
hl(0, "NeoTreeGitDeleted", { fg = p.error_60 })
hl(0, "NeoTreeGitIgnored", { fg = p.muted })
hl(0, "NeoTreeGitModified", { fg = p.primary_60 })
hl(0, "NeoTreeGitUnstaged", { fg = p.primary_60 })
hl(0, "NeoTreeGitUntracked", { fg = p.accent2 })
hl(0, "NeoTreeGitStaged", { fg = p.tertiary_60 })
hl(0, "NeoTreeHidden", { fg = p.muted })
hl(0, "NeoTreeDotfile", { fg = p.muted })
hl(0, "NeoTreeMessage", { fg = p.muted })
hl(0, "NeoTreeWindowsHidden", { fg = p.muted })
hl(0, "NeoTreeSymbolicLinkTarget", { fg = p.accent2 })

-- ── Plugin: Gitsigns ───────────────────────────────────────────

hl(0, "GitSignsAdd", { fg = p.tertiary_60 })
hl(0, "GitSignsChange", { fg = p.primary_60 })
hl(0, "GitSignsDelete", { fg = p.error_60 })
hl(0, "GitSignsCurrentLineBlame", { fg = p.muted })
hl(0, "GitSignsAddInline", { bg = p.surface3 })
hl(0, "GitSignsChangeInline", { bg = p.surface3 })
hl(0, "GitSignsDeleteInline", { bg = p.surface3 })
hl(0, "GitSignsAddLn", { bg = p.surface2 })
hl(0, "GitSignsChangeLn", { bg = p.surface2 })
hl(0, "GitSignsDeleteLn", { bg = p.surface2 })
hl(0, "GitSignsAddPreview", { fg = p.tertiary_60, bg = p.surface1 })
hl(0, "GitSignsDeletePreview", { fg = p.error_60, bg = p.surface1 })

-- ── Plugin: Blink.cmp ──────────────────────────────────────────

hl(0, "BlinkCmpDoc", { fg = p.fg, bg = p.surface2 })
hl(0, "BlinkCmpDocBorder", { fg = p.overlay })
hl(0, "BlinkCmpDocCursorLine", { bg = p.surface3 })
hl(0, "BlinkCmpGhostText", { fg = p.overlay })
hl(0, "BlinkCmpKind", { fg = p.subtle })
hl(0, "BlinkCmpKindText", { fg = p.fg })
hl(0, "BlinkCmpKindMethod", { fg = p.func })
hl(0, "BlinkCmpKindFunction", { fg = p.func })
hl(0, "BlinkCmpKindConstructor", { fg = p.type })
hl(0, "BlinkCmpKindField", { fg = p.property })
hl(0, "BlinkCmpKindVariable", { fg = p.fg })
hl(0, "BlinkCmpKindClass", { fg = p.type })
hl(0, "BlinkCmpKindInterface", { fg = p.type })
hl(0, "BlinkCmpKindModule", { fg = p.macro })
hl(0, "BlinkCmpKindProperty", { fg = p.property })
hl(0, "BlinkCmpKindUnit", { fg = p.macro })
hl(0, "BlinkCmpKindValue", { fg = p.constant })
hl(0, "BlinkCmpKindEnum", { fg = p.type })
hl(0, "BlinkCmpKindKeyword", { fg = p.keyword })
hl(0, "BlinkCmpKindSnippet", { fg = p.string })
hl(0, "BlinkCmpKindColor", { fg = p.constant })
hl(0, "BlinkCmpKindFile", { fg = p.subtle })
hl(0, "BlinkCmpKindReference", { fg = p.string })
hl(0, "BlinkCmpKindFolder", { fg = p.keyword })
hl(0, "BlinkCmpKindEnumMember", { fg = p.type })
hl(0, "BlinkCmpKindConstant", { fg = p.constant })
hl(0, "BlinkCmpKindStruct", { fg = p.type })
hl(0, "BlinkCmpKindEvent", { fg = p.keyword })
hl(0, "BlinkCmpKindOperator", { fg = p.operator })
hl(0, "BlinkCmpKindTypeParameter", { fg = p.type })

-- ── Plugin: Which-key ──────────────────────────────────────────

hl(0, "WhichKey", { fg = p.accent })
hl(0, "WhichKeyGroup", { fg = p.accent2 })
hl(0, "WhichKeyDesc", { fg = p.fg })
hl(0, "WhichKeySeperator", { fg = p.overlay })
hl(0, "WhichKeyBorder", { fg = p.overlay })
hl(0, "WhichKeyValue", { fg = p.muted })
hl(0, "WhichKeyNormal", { bg = p.surface2 })
hl(0, "WhichKeyTitle", { fg = p.accent, bold = true })

-- ── Plugin: Indent-blankline ───────────────────────────────────

hl(0, "IblIndent", { fg = p.overlay, nocombine = true })
hl(0, "IblWhitespace", { fg = p.overlay, nocombine = true })
hl(0, "IblScope", { fg = p.muted, nocombine = true })
hl(0, "IndentBlankline", { link = "IblIndent" })
hl(0, "IndentBlanklineChar", { link = "IblIndent" })
hl(0, "IndentBlanklineContextChar", { link = "IblScope" })
hl(0, "IndentBlanklineSpaceChar", { link = "IblWhitespace" })
hl(0, "IndentBlanklineSpaceCharBlankline", { link = "IblWhitespace" })

-- ── Plugin: Trouble ────────────────────────────────────────────

hl(0, "TroubleNormal", { fg = p.fg, bg = "none" })
hl(0, "TroubleText", { fg = p.fg })
hl(0, "TroubleCount", { fg = p.accent, bg = p.surface2 })
hl(0, "TroubleFile", { fg = p.accent })
hl(0, "TroubleFoldIcon", { fg = p.muted })
hl(0, "TroubleLocation", { fg = p.subtle })
hl(0, "TroubleSource", { fg = p.muted })
hl(0, "TroubleCode", { fg = p.subtle })
hl(0, "TroublePreview", { bg = p.surface3 })
hl(0, "TroubleIndent", { fg = p.overlay })

-- ── Plugin: Flash ──────────────────────────────────────────────

hl(0, "FlashBackdrop", { fg = p.muted })
hl(0, "FlashLabel", { fg = p.accent, bg = p.surface3, bold = true })
hl(0, "FlashMatch", { fg = p.accent2, bg = p.surface2 })
hl(0, "FlashCurrent", { fg = p.accent, bg = p.surface2 })
hl(0, "FlashCursor", { bg = p.accent })
hl(0, "FlashPrompt", { fg = p.fg })
hl(0, "FlashBorder", { fg = p.overlay })

-- ── Plugin: Todo-comments ──────────────────────────────────────

hl(0, "TodoFgFIX", { fg = p.red })
hl(0, "TodoFgTODO", { fg = p.primary_60 })
hl(0, "TodoFgHACK", { fg = p.error_70 })
hl(0, "TodoFgWARN", { fg = p.error_70 })
hl(0, "TodoFgPERF", { fg = p.accent2 })
hl(0, "TodoFgNOTE", { fg = p.tertiary_60 })
hl(0, "TodoFgTEST", { fg = p.secondary_60 })

hl(0, "TodoBgFIX", { fg = p.surface0, bg = p.error_50, bold = true })
hl(0, "TodoBgTODO", { fg = p.surface0, bg = p.primary_50, bold = true })
hl(0, "TodoBgHACK", { fg = p.surface0, bg = p.error_60, bold = true })
hl(0, "TodoBgWARN", { fg = p.surface0, bg = p.error_60, bold = true })
hl(0, "TodoBgPERF", { fg = p.surface0, bg = p.secondary_50, bold = true })
hl(0, "TodoBgNOTE", { fg = p.surface0, bg = p.tertiary_50, bold = true })
hl(0, "TodoBgTEST", { fg = p.surface0, bg = p.secondary_50, bold = true })

hl(0, "TodoSignFIX", { fg = p.error_50 })
hl(0, "TodoSignTODO", { fg = p.primary_50 })
hl(0, "TodoSignHACK", { fg = p.error_60 })
hl(0, "TodoSignWARN", { fg = p.error_60 })
hl(0, "TodoSignPERF", { fg = p.secondary_50 })
hl(0, "TodoSignNOTE", { fg = p.tertiary_50 })
hl(0, "TodoSignTEST", { fg = p.secondary_50 })

-- ── Plugin: Render-markdown ────────────────────────────────────

hl(0, "RenderMarkdownH1", { fg = p.accent, bold = true })
hl(0, "RenderMarkdownH2", { fg = p.accent2, bold = true })
hl(0, "RenderMarkdownH3", { fg = p.accent2, bold = true })
hl(0, "RenderMarkdownH4", { fg = p.primary_60, bold = true })
hl(0, "RenderMarkdownH5", { fg = p.secondary_60, bold = true })
hl(0, "RenderMarkdownH6", { fg = p.tertiary_60, bold = true })
hl(0, "RenderMarkdownH1Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownH2Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownH3Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownH4Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownH5Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownH6Bg", { bg = p.surface1 })
hl(0, "RenderMarkdownCode", { fg = p.fg, bg = p.surface1 })
hl(0, "RenderMarkdownCodeInfo", { fg = p.muted })
hl(0, "RenderMarkdownCodeLabel", { fg = p.subtle })
hl(0, "RenderMarkdownBullet", { fg = p.accent })
hl(0, "RenderMarkdownQuote", { fg = p.muted, italic = true })
hl(0, "RenderMarkdownDash", { fg = p.overlay })
hl(0, "RenderMarkdownLink", { fg = p.accent2 })
hl(0, "RenderMarkdownMath", { fg = p.accent2 })
hl(0, "RenderMarkdownTodo", { fg = p.accent })
hl(0, "RenderMarkdownCheckbox", { fg = p.muted })
hl(0, "RenderMarkdownTableHead", { fg = p.accent })
hl(0, "RenderMarkdownTableRow", { fg = p.overlay })
hl(0, "RenderMarkdownSuccess", { fg = p.tertiary_60 })
hl(0, "RenderMarkdownInfo", { fg = p.primary_60 })
hl(0, "RenderMarkdownHint", { fg = p.secondary_60 })
hl(0, "RenderMarkdownWarn", { fg = p.error_70 })
hl(0, "RenderMarkdownError", { fg = p.red })

-- ── Plugin: Snacks ─────────────────────────────────────────────

hl(0, "SnacksNotifierInfo", { fg = p.fg, bg = p.surface2 })
hl(0, "SnacksNotifierWarn", { fg = p.error_70, bg = p.surface2 })
hl(0, "SnacksNotifierError", { fg = p.red, bg = p.surface2 })
hl(0, "SnacksNotifierDebug", { fg = p.muted, bg = p.surface2 })
hl(0, "SnacksNotifierTrace", { fg = p.subtle, bg = p.surface2 })
hl(0, "SnacksNotifierBorderInfo", { fg = p.primary_60 })
hl(0, "SnacksNotifierBorderWarn", { fg = p.error_70 })
hl(0, "SnacksNotifierBorderError", { fg = p.red })
hl(0, "SnacksNotifierBorderDebug", { fg = p.muted })
hl(0, "SnacksNotifierBorderTrace", { fg = p.overlay })
hl(0, "SnacksNotifierTitleInfo", { fg = p.primary_60, bold = true })
hl(0, "SnacksNotifierTitleWarn", { fg = p.error_70, bold = true })
hl(0, "SnacksNotifierTitleError", { fg = p.red, bold = true })
hl(0, "SnacksNotifierTitleDebug", { fg = p.muted, bold = true })
hl(0, "SnacksNotifierTitleTrace", { fg = p.overlay, bold = true })
hl(0, "SnacksNotifierIconInfo", { fg = p.primary_60 })
hl(0, "SnacksNotifierIconWarn", { fg = p.error_70 })
hl(0, "SnacksNotifierIconError", { fg = p.red })
hl(0, "SnacksNotifierIconDebug", { fg = p.muted })
hl(0, "SnacksNotifierIconTrace", { fg = p.overlay })
hl(0, "SnacksDashboardHeader", { fg = p.accent })
hl(0, "SnacksDashboardDesc", { fg = p.fg })
hl(0, "SnacksDashboardKey", { fg = p.accent })
hl(0, "SnacksDashboardFooter", { fg = p.muted })
hl(0, "SnacksDashboardSpecial", { fg = p.accent2 })
hl(0, "SnacksDashboardDir", { fg = p.subtle })
hl(0, "SnacksDashboardIcon", { fg = p.accent })
hl(0, "SnacksIndent", { fg = p.overlay })
hl(0, "SnacksIndentScope", { fg = p.muted })
hl(0, "SnacksPickerMatch", { fg = p.accent, bold = true })
hl(0, "SnacksPickerDir", { fg = p.subtle })
hl(0, "SnacksPickerCursorLine", { bg = p.surface3 })

-- ── Plugin: Alpha ──────────────────────────────────────────────

hl(0, "AlphaHeader", { fg = p.accent })
hl(0, "AlphaHeaderLabel", { fg = p.accent })
hl(0, "AlphaButtons", { fg = p.fg })
hl(0, "AlphaShortcut", { fg = p.accent2 })
hl(0, "AlphaFooter", { fg = p.muted })
hl(0, "AlphaSubTitle", { fg = p.accent2 })

-- ── Plugin: Aerial ─────────────────────────────────────────────

hl(0, "AerialLine", { bg = p.surface3 })
hl(0, "AerialGuide", { fg = p.overlay })
hl(0, "AerialArrayIcon", { fg = p.accent2 })
hl(0, "AerialBooleanIcon", { fg = p.accent2 })
hl(0, "AerialClassIcon", { fg = p.accent2 })
hl(0, "AerialFunctionIcon", { fg = p.accent })
hl(0, "AerialMethodIcon", { fg = p.accent })
hl(0, "AerialModuleIcon", { fg = p.accent2 })
hl(0, "AerialConstantIcon", { fg = p.accent2 })
hl(0, "AerialEnumIcon", { fg = p.accent2 })
hl(0, "AerialPropertyIcon", { fg = p.fg })
hl(0, "AerialVariableIcon", { fg = p.fg })
hl(0, "AerialNamespaceIcon", { fg = p.accent2 })
hl(0, "AerialStructIcon", { fg = p.accent2 })
hl(0, "AerialInterfaceIcon", { fg = p.accent2 })
hl(0, "AerialTypeIcon", { fg = p.accent2 })
hl(0, "AerialStringIcon", { fg = p.accent2 })
hl(0, "AerialNumberIcon", { fg = p.accent2 })
hl(0, "AerialOperatorIcon", { fg = p.subtle })
hl(0, "AerialNullIcon", { fg = p.muted })

-- ── Plugin: Navic ──────────────────────────────────────────────

hl(0, "NavicSeparator", { fg = p.overlay })
hl(0, "NavicText", { fg = p.fg })
hl(0, "NavicIconsFile", { fg = p.fg })
hl(0, "NavicIconsModule", { fg = p.accent2 })
hl(0, "NavicIconsNamespace", { fg = p.accent2 })
hl(0, "NavicIconsPackage", { fg = p.accent2 })
hl(0, "NavicIconsClass", { fg = p.accent2 })
hl(0, "NavicIconsMethod", { fg = p.accent })
hl(0, "NavicIconsProperty", { fg = p.fg })
hl(0, "NavicIconsField", { fg = p.fg })
hl(0, "NavicIconsConstructor", { fg = p.accent2 })
hl(0, "NavicIconsEnum", { fg = p.accent2 })
hl(0, "NavicIconsInterface", { fg = p.accent2 })
hl(0, "NavicIconsFunction", { fg = p.accent })
hl(0, "NavicIconsVariable", { fg = p.fg })
hl(0, "NavicIconsConstant", { fg = p.accent2 })
hl(0, "NavicIconsString", { fg = p.accent2 })
hl(0, "NavicIconsNumber", { fg = p.accent2 })
hl(0, "NavicIconsBoolean", { fg = p.accent2 })
hl(0, "NavicIconsArray", { fg = p.accent2 })
hl(0, "NavicIconsObject", { fg = p.accent2 })
hl(0, "NavicIconsKey", { fg = p.accent })
hl(0, "NavicIconsNull", { fg = p.muted })
hl(0, "NavicIconsEnumMember", { fg = p.accent2 })
hl(0, "NavicIconsStruct", { fg = p.accent2 })
hl(0, "NavicIconsEvent", { fg = p.accent })
hl(0, "NavicIconsOperator", { fg = p.subtle })
hl(0, "NavicIconsTypeParameter", { fg = p.accent2 })

-- ── Plugin: DiffView ───────────────────────────────────────────

hl(0, "DiffViewNormal", { fg = p.fg, bg = p.surface1 })
hl(0, "DiffViewStatusLine", { fg = p.fg, bg = p.surface2 })
hl(0, "DiffViewStatusLineNC", { fg = p.muted, bg = p.surface1 })
hl(0, "DiffViewFilePanelTitle", { fg = p.accent, bold = true })
hl(0, "DiffViewFilePanelCounter", { fg = p.accent2 })
hl(0, "DiffViewFilePanelPath", { fg = p.subtle })
hl(0, "DiffViewFilePanelFileName", { fg = p.fg })
hl(0, "DiffViewFolderName", { fg = p.accent })
hl(0, "DiffViewFolderSign", { fg = p.accent })
hl(0, "DiffViewSignColumn", { fg = p.muted, bg = p.surface1 })

-- ── Plugin: Lazy ───────────────────────────────────────────────

hl(0, "LazyH1", { fg = p.surface0, bg = p.accent, bold = true })
hl(0, "LazyH2", { fg = p.accent, bold = true })
hl(0, "LazyButton", { fg = p.fg, bg = p.surface3 })
hl(0, "LazyButtonActive", { fg = p.surface0, bg = p.accent, bold = true })
hl(0, "LazySpecial", { fg = p.accent2 })
hl(0, "LazyReasonPlugin", { fg = p.accent2 })
hl(0, "LazyReasonCmd", { fg = p.accent })
hl(0, "LazyReasonEvent", { fg = p.accent2 })
hl(0, "LazyReasonKeys", { fg = p.subtle })
hl(0, "LazyReasonStart", { fg = p.tertiary_60 })
hl(0, "LazyValue", { fg = p.accent2 })
hl(0, "LazyDir", { fg = p.subtle })
hl(0, "LazyUrl", { fg = p.primary_60, underline = true })
hl(0, "LazyNoCond", { fg = p.error_60 })
hl(0, "LazyCommit", { fg = p.tertiary_60 })
hl(0, "LazyCommitIssue", { fg = p.accent })
hl(0, "LazyDimmmed", { fg = p.muted })
hl(0, "LazyProp", { fg = p.subtle })
hl(0, "LazyHandler", { fg = p.muted })

-- ── Plugin: Snacks Notifier ────────────────────────────────────

hl(0, "SnacksNotifierInfo", { bg = "none" })
hl(0, "SnacksNotifierWarn", { bg = "none" })
hl(0, "SnacksNotifierError", { bg = "none" })
hl(0, "SnacksNotifierDebug", { bg = "none" })
hl(0, "SnacksNotifierTrace", { bg = "none" })
hl(0, "SnacksNotifierMinimal", { bg = "none" })
hl(0, "SnacksNotifierHistory", { bg = "none" })

-- ── Filetype: Markdown ─────────────────────────────────────────

hl(0, "@markup.heading.1.marker.markdown", { fg = p.keyword })
hl(0, "@markup.heading.2.marker.markdown", { fg = p.keyword })
hl(0, "@markup.heading.3.marker.markdown", { fg = p.keyword })
hl(0, "@markup.heading.4.marker.markdown", { fg = p.keyword })
hl(0, "@markup.heading.5.marker.markdown", { fg = p.keyword })
hl(0, "@markup.heading.6.marker.markdown", { fg = p.keyword })
hl(0, "markdownCode", { fg = p.string, bg = p.surface1 })
hl(0, "markdownCodeBlock", { fg = p.string })
hl(0, "markdownH1", { fg = p.keyword, bold = true })
hl(0, "markdownH2", { fg = p.func, bold = true })
hl(0, "markdownH3", { fg = p.type, bold = true })
hl(0, "markdownH4", { fg = p.string })
hl(0, "markdownH5", { fg = p.macro })
hl(0, "markdownH6", { fg = p.constant })
hl(0, "markdownLinkText", { fg = p.keyword })
hl(0, "markdownUrl", { fg = p.type, underline = true })
hl(0, "markdownBold", { bold = true })
hl(0, "markdownItalic", { italic = true })
hl(0, "markdownBlockquote", { fg = p.muted, italic = true })
hl(0, "markdownListMarker", { fg = p.keyword })

-- ── Filetype: Lua ──────────────────────────────────────────────

hl(0, "@operator.lua", { fg = p.operator })
hl(0, "@field.lua", { fg = p.property })
hl(0, "@property.lua", { fg = p.property })
hl(0, "@constant.builtin.lua", { fg = p.keyword })
hl(0, "@variable.lua", { fg = p.fg })
hl(0, "@function.call.lua", { fg = p.func })
hl(0, "@lsp.type.namespace.lua", { fg = p.macro })
hl(0, "@lsp.type.parameter.lua", { fg = p.subtle, italic = true })

-- ── Lualine Theme ──────────────────────────────────────────────

pcall(function()
	local theme = {
		normal = {
			a = { fg = p.surface0, bg = p.accent, gui = "bold" },
			b = { fg = p.fg, bg = "none" },
			c = { fg = p.fg, bg = "none" },
		},
		insert = {
			a = { fg = p.surface0, bg = p.func, gui = "bold" },
			b = { fg = p.fg, bg = "none" },
			c = { fg = p.fg, bg = "none" },
		},
		visual = {
			a = { fg = p.surface0, bg = p.string, gui = "bold" },
			b = { fg = p.fg, bg = "none" },
			c = { fg = p.fg, bg = "none" },
		},
		replace = {
			a = { fg = p.surface0, bg = p.constant, gui = "bold" },
			b = { fg = p.fg, bg = "none" },
			c = { fg = p.fg, bg = "none" },
		},
		command = {
			a = { fg = p.surface0, bg = p.type, gui = "bold" },
			b = { fg = p.fg, bg = "none" },
			c = { fg = p.fg, bg = "none" },
		},
		inactive = {
			a = { fg = p.muted, bg = "none" },
			b = { fg = p.muted, bg = "none" },
			c = { fg = p.muted, bg = "none" },
		},
	}
	require("lualine").setup({ options = { theme = theme } })
end)
