require('onedark').setup {
    -- transparent = true,
    colors = {
        bg0 = '#1F2228',
        bg1 = '#24272E',
        bg_d = '#191b20',
    },
    highlights = {
        TSConstructor = { fmt = 'none' },
        TSParameter = { fg = '$fg' },
    },
}

require('onedark').load()
