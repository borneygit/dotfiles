-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local tool = require("tool")
local vim = tool.vim
local opt = tool.vim.opt

vim.g.mapleader = " "


--默认的字符编码
opt.encoding = "utf-8"
opt.fileencoding = 'utf-8'

opt.number = true         --显示行号
opt.relativenumber = true --相对行号

vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

opt.tabstop = 4           --设置缩进宽度为4
opt.softtabstop = 4
opt.shiftround = false
opt.shiftwidth = 4   --设置位移宽度为4
opt.expandtab = true --将缩进替换为空格
vim.o.list = true
vim.o.listchars = "eol:↵,lead:‧,space:·"

--防止包裹
opt.wrap = false

--光标行
opt.cursorline = true

--启动鼠标
opt.mouse:append("a")

--系统剪贴板
opt.clipboard:append("unnamedplus")

--默认窗口右和下
opt.splitright = true
opt.splitbelow = true

--搜索
opt.ignorecase = true
opt.smartcase = true

--外观
opt.termguicolors = true
opt.signcolumn = 'yes'