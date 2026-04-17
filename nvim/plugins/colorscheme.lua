return {
    "navarasu/onedark.nvim",

    version = "v0.1.0",

    config = function()
        -- Change this to switch palettes. See `palettes` below for options.
        local active_palette = "onedark"

        -- Both palettes must define the same keys so switching between them
        -- fully resets colors. Keys missing from the target palette keep
        -- their previous value (onedark merges setup calls internally).
        local palettes = {
            onedark = {
                bg0    = "#1f2329",
                bg1    = "#282c34",
                bg2    = "#393f4a",
                bg3    = "#3b3f4c",
                bg_d   = "#181b20",
                fg     = "#c7cad9",
                grey   = "#5c6370",
                purple = "#c678dd",
                red    = "#e86671",
                yellow = "#e5c07b",
                green  = "#98c379",
                orange = "#d19a66",
                blue   = "#61afef",
                cyan   = "#56b6c2",
            },
            gruvbox = {
                -- Background colors match onedark for visual consistency when toggling
                bg0    = "#1f2329",
                bg1    = "#282c34",
                bg2    = "#393f4a",
                bg3    = "#3b3f4c",
                bg_d   = "#181b20",
                fg     = "#ebdbb2",
                grey   = "#7c6f64",
                purple = "#d3869b",
                red    = "#fb4934",
                yellow = "#fabd2f",
                green  = "#b8bb26",
                orange = "#fe8019",
                blue   = "#83a598",
                cyan   = "#8ec07c",
            },
        }

        require("onedark").setup({
            transparent = true,
            colors = palettes[active_palette],
            highlights = {
                Whitespace = { fg = "$bg2" },

                -- Transparent
                CursorLine = { bg = "$bg0" },
            },
        })

        require("onedark").load()
    end,
}
