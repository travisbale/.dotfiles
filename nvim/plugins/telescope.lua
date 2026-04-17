return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-telescope/telescope-fzy-native.nvim",
    },

    config = function()
        require("telescope").setup({
            extensions = {
                fzy_native = {
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
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

        require("telescope").load_extension("fzy_native")
    end,
}
