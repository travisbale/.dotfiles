require("neotest").setup({
    adapters = {
        require("neotest-python"),
        require("neotest-go"),
        require("neotest-rspec"),
        require("neotest-vim-test")({ ignore_filetypes = { "python", "go", "rb" } }),
    },
    icons = {
        child_indent = "│",
        child_prefix = "├",
        collapsed = "─",
        expanded = "╮",
        failed = "",
        final_child_indent = " ",
        final_child_prefix = "╰",
        non_collapsible = "─",
        passed = "",
        running = "",
        running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
        skipped = "",
        unknown = "",
        watching = "",
    },
})
