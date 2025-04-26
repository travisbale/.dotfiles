return {
    "tpope/vim-fugitive",
    "rhysd/git-messenger.vim",

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- Load when editing files
        config = function()
            require("gitsigns").setup()
        end,
    },
}
