return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "debugloop/telescope-undo.nvim"
    },
    event = "VeryLazy",
    keys = {
        { "<leader>ud", ":Telescope undo<cr>", desc = "Undo" },
    },
    opts = function ()
        require("telescope").setup({
            pickers = {
                -- Built-in pickers configuration
                find_files = {
                    -- Find files for skinning, supported parameters are: dropdown, cursor, ivy
                    -- theme = "dropdown",
                    hidden = false,
                },
            },
            extensions = {
                undo = {
                    side_by_side = true,
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_height = 0.8,
                    },
                },
                fzf = {
                    fuzzy = true,                 -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,  -- override the file sorter
                    case_mode = "smart_case",     -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            }
        })
        require("telescope").load_extension("undo")
    end,
}