# vim:fileencoding=utf-8:foldmethod=marker:filetype=toml:

# : Manager {{{

[mgr]
cwd = { fg = "$color6" }

# Find
find_keyword = { fg = "$foreground", bold = true, italic = true, underline = true }
find_position = { fg = "$color1", bg = "reset", bold = true, italic = true }

# Marker
marker_copied = { fg = "$color2", bg = "$color2" }
marker_cut = { fg = "$color1", bg = "$color1" }
marker_marked = { fg = "$color6", bg = "$color6" }
marker_selected = { fg = "$color5", bg = "$color5" }

# Count
count_copied = { fg = "$background", bg = "$color2" }
count_cut = { fg = "$background", bg = "$color2" }
count_selected = { fg = "$background", bg = "$color5" }

# Border
border_symbol = "│"
border_style = { fg = "$color8" }

# : }}}


# : Tabs {{{

[tabs]
active = { fg = "$background", bg = "$color6", bold = true }
inactive = { fg = "$color6", bg = "$color0" }

# : }}}


# : Mode {{{

[mode]
normal_main = { fg = "$background", bg = "$color6", bold = true }
normal_alt = { fg = "$color6", bg = "$color0" }

# Select mode
select_main = { fg = "$background", bg = "$color3", bold = true }
select_alt = { fg = "$color3", bg = "$color0" }

# Unset mode
unset_main = { fg = "$background", bg = "$color1", bold = true }
unset_alt = { fg = "$color1", bg = "$color0" }

# : }}}


# : Status bar {{{

[status]
# Permissions
perm_sep = { fg = "$color8" }
perm_type = { fg = "$color6" }
perm_read = { fg = "$color3" }
perm_write = { fg = "$color4" }
perm_exec = { fg = "$color2" }

# Progress
progress_label = { fg = "$foreground", bold = true }
progress_normal = { fg = "$color2", bg = "$color8" }
progress_error = { fg = "$color1", bg = "$color4" }

# : }}}


# : Pick {{{

[pick]
border = { fg = "$color6" }
active = { fg = "$color1", bold = true }
inactive = {}

# : }}}


# : Input {{{

[input]
border = { fg = "$color6" }
title = {}
value = {}
selected = { reversed = true }

# : }}}


# : Completion {{{

[cmp]
border = { fg = "$color6" }

# : }}}


# : Tasks {{{

[tasks]
border = { fg = "$color6" }
title = {}
hovered = { fg = "$color1", bold = true }

# : }}}


# : Which {{{

[which]
mask = { bg = "$color0" }
cand = { fg = "$color6" }
rest = { fg = "$color0" }
desc = { fg = "$color1" }
separator = "  "
separator_style = { fg = "$color8" }

# : }}}


# : Help {{{

[help]
on = { fg = "$color6" }
run = { fg = "$color1" }
hovered = { reversed = true, bold = true }
footer = { fg = "$foreground", bg = "$background" }

# : }}}


# : Spotter {{{

[spot]
border = { fg = "$color6" }
title = { fg = "$color6" }
tbl_col = { fg = "$color3" }
tbl_cell = { fg = "$color1", bg = "$color0" }

# : }}}


# : Notification {{{

[notify]
title_info = { fg = "$color2" }
title_warn = { fg = "$color3" }
title_error = { fg = "$color1" }

# : }}}

[indicator]
padding = { open = "▐", close = "▌" }

# : File-specific styles {{{

[filetype]
rules = [
  # Image
  { mime = "image/*", fg = "$color6" },
  # Media
  { mime = "{audio,video}/*", fg = "$color3" },
  # Archive
  { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "$color4" },
  # Document
  { mime = "application/{pdf,doc,rtf}", fg = "$color2" },
  # Virtual file system
  { mime = "vfs/{absent,stale}", fg = "$color0" },
  # Fallback
  { url = "*", fg = "$foreground" },
  { url = "*/", fg = "$color6" },
]

# : }}}

[icon]
dirs = [
  { name = ".config", text = "", fg = "$color4" },
  { name = ".git", text = "", fg = "$color1" },
  { name = ".github", text = "", fg = "$color6" },
  { name = ".npm", text = "", fg = "$color6" },
  { name = "Desktop", text = "", fg = "$color3" },
  { name = "Development", text = "", fg = "$color3" },
  { name = "Documents", text = "", fg = "$color3" },
  { name = "Downloads", text = "", fg = "$color3" },
  { name = "Library", text = "", fg = "$color3" },
  { name = "Movies", text = "", fg = "$color3" },
  { name = "Music", text = "", fg = "$color3" },
  { name = "Pictures", text = "", fg = "$color3" },
  { name = "Public", text = "", fg = "$color3" },
  { name = "Videos", text = "", fg = "$color3" },
]
conds = [
  # Special files
  { if = "orphan", text = "", fg = "$foreground" },
  { if = "link", text = "", fg = "$color8" },
  { if = "block", text = "", fg = "$color3" },
  { if = "char", text = "", fg = "$color3" },
  { if = "fifo", text = "", fg = "$color3" },
  { if = "sock", text = "", fg = "$color3" },
  { if = "sticky", text = "", fg = "$color3" },
  { if = "dummy", text = "", fg = "$color1" },
  # Fallback
  { if = "dir & hovered", text = "", fg = "$color6" },
  { if = "dir", text = "", fg = "$color6" },
  { if = "exec", text = "", fg = "$color2" },
  { if = "!dir", text = "", fg = "$foreground" },
]
