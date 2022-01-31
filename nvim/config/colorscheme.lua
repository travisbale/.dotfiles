require('onedark').setup {
    --transparent = true,
    colors = {
        bg0 = '#1F2228',
        bg1 = '#24272E',
    },
    highlights = {
        TSConstructor = { fmt = 'none' },
        TSParameter = { fg = '$fg' },
    },
}

require('onedark').load()
