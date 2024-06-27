local tool = require("tool")
local vim = tool.vim

-- if true then return {} end

return {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    opts = function()
        vim.cmd([[colorscheme sonokai]])
    end,
}
