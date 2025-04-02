return {
    "navarasu/onedark.nvim", -- Colorscheme

    config = function()
        require("onedark").setup({
            transparent = true,
            colors = {
                -- Onedark updates
                bg0 = "#1f2329",
                bg1 = "#282c34",
                bg_d = "#181b20",
                -- transparent
                fg = "#c7cad9",

                -- Gruvbox color palette
                -- fg = "#ebdbb2",
                -- bg0 = "#282828",
                -- bg1 = "#3c3836",
                -- bg2 = "#504945",
                -- bg3 = "#665c54",
                -- bg_d = "#1d2021",
                -- grey = "#7c6f64",
                -- purple = "#d3869b",
                -- red = "#fb4934",
                -- yellow = "#fabd2f",
                -- green = "#b8bb26",
                -- orange = "#fe8019",
                -- blue = "#83a598",
                -- cyan = "#8ec07c",
            },
            highlights = {
                TSConstructor = { fmt = "none" },
                TSParameter = { fg = "$fg" },
                TSPunctBracket = { fg = "$fg" },
                Whitespace = { fg = "$bg2" },

                -- Transparent
                CursorLine = { bg = "$bg0" },
            },
        })

        require("onedark").load()
    end,
}
