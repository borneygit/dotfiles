-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

-- 模式切换
map("n", "v", "<C-v>") --切换视觉模式

-- 分屏快捷键
map("n", "sv", ":vsp<CR>") --水平增加窗口
map("n", "sh", ":sp<CR>") --垂直新增窗口

map("n", "sc", "<C-w>c") -- 关闭当前
map("n", "so", "<C-w>o") -- 关闭其他
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

-- 左右比例控制
map("n", "s,", ":vertical resize -20<CR>")
map("n", "s.", ":vertical resize +20<CR>")
-- 上下比例
map("n", "sj", ":resize +10<CR>")
map("n", "sk", ":resize -10<CR>")
-- 等比例
map("n", "s=", "<C-w>=")

-- visual模式下缩进代码
map("v", "<", "<gv")
map("v", ">", ">gv")
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv")
map("v", "K", ":move '<-2<CR>gv-gv")

-- 上下滚动浏览
map("n", "<C-j>", "4j")
map("n", "<C-k>", "4k")
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k")
map("n", "<C-d>", "9j")

-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP')

-- 退出
map("n", "q", ":q<CR>")
map("n", "qq", ":q!<CR>")
map("n", "Q", ":qa!<CR>")

-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I")
map("i", "<C-l>", "<ESC>A")

-------------rust-tools----------
map("n", "<C-e>", "<cmd>lua require'rust-tools'.expand_macro.expand_macro()<cr>", { desc = "Expand Macro" })