return {
    "iamcco/markdown-preview.nvim",
    cond = not require("config.profile").minimal,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
}
