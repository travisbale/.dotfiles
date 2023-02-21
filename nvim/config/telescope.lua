require("telescope").setup({
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = true,
        },
        git_files = {
            show_untracked = true,
        },
    },
})
