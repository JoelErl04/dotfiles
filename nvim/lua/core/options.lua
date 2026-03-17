vim.g.mapleader = " "       -- space as leader; must be set before lazy loads
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line numbers
opt.number = true           -- show absolute number on current line
opt.relativenumber = true   -- relative numbers on all other lines (fast navigation)

-- Indentation
opt.tabstop = 4             -- tab character renders as 4 spaces
opt.shiftwidth = 4          -- >> and << indent by 4 spaces
opt.expandtab = true        -- insert spaces instead of tab characters
opt.smartindent = true      -- auto-indent new lines based on syntax

-- Search
opt.ignorecase = true       -- case-insensitive by default
opt.smartcase = true        -- case-sensitive when query contains uppercase

-- Appearance
opt.termguicolors = true    -- 24-bit colour (required by most themes)
opt.signcolumn = "yes"      -- always show sign column so text doesn't jump
opt.cursorline = true       -- highlight current line
opt.scrolloff = 8           -- keep 8 lines visible above/below cursor
opt.wrap = false            -- don't wrap long lines

-- Splits
opt.splitright = true       -- vertical splits open to the right
opt.splitbelow = true       -- horizontal splits open below

-- Files
opt.undofile = true         -- persist undo history across sessions
opt.swapfile = false        -- no swap files; undofile + git is enough
opt.backup = false

-- Misc
opt.updatetime = 250        -- faster CursorHold events (used by LSP hover)
opt.timeoutlen = 300        -- ms before which-key popup appears
opt.mouse = "a"             -- enable mouse in all modes
opt.clipboard = "unnamedplus" -- sync with system clipboard (needs wl-clipboard)
