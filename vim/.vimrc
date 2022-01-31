" Instal vim plugin manager
let need_to_install_plugins = 0
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PluginInstall --sync | source $VIMRC
    let need_to_install_plugins = 1
endif

" Load plugins
call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" File browser with git indicators
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" git indicator in editor
Plug 'airblade/vim-gitgutter'

" Status bar
Plug 'itchyny/lightline.vim'

" Color theme
Plug 'joshdick/onedark.vim'

"Tabs
Plug 'ap/vim-buftabline'

" Telescope file finder / picker
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Neovim language things
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Nicer LSP UI
Plug 'glepnir/lspsaga.nvim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

call plug#end()

" Don't try to be vi compatible
set nocompatible
set mouse=a

" Security
set modelines=0

" Color scheme
set termguicolors

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ECEFF4", "cterm": "145", "cterm16": "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
    autocmd ColorScheme * call onedark#set_highlight("Identifier", { "fg": s:white })
  augroup END
endif

colorscheme onedark

" Lightline customizations
let g:lightline = { 
    \ 'colorscheme': 'onedark',
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\}

" Show line numbers
set number
highlight LineNr ctermfg=darkgray

" Whitespace
set nowrap
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround
set smartindent
set listchars=tab:→\ ,trail:·,lead:·,nbsp:␣,multispace:·
set list

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Git
autocmd Filetype gitcommit setlocal spell textwidth=72

" NERDTree configuration
let NERDTreeShowHidden=1

" Close NERDTree if it is the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <Leader>T :NERDTreeToggle<CR>
nnoremap <Leader>t :NERDTreeFind<CR>

nnoremap <Leader><space> :noh<CR>

" Language Sever Configuration
luafile ~/.vim/lsp_config.lua

sign define LspDiagnosticsSignError text=🔴
sign define LspDiagnosticsSignWarning text=🟠
sign define LspDiagnosticsSignInformation text=🔵
sign define LspDiagnosticsSignHint text=🟢

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ge <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
xmap <silent> <leader>a <cmd>lua vim.lsp.buf.range_code_action()<CR>

" Fuzzy Finder Configuration
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

" Autocomplete configuration
set completeopt=menu,menuone,noselect
