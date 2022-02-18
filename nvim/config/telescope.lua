local telescope = require("telescope")

telescope.setup {
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        }
    }
}

telescope.load_extension('fzy_native')

