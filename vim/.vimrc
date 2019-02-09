set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
" Plugin 'kien/ctrlp.vim'
Plugin 'wincent/command-t'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'w0rp/ale'
Plugin 'elixir-editors/vim-elixir'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'easymotion/vim-easymotion'
Plugin 'phpactor/phpactor'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rhysd/vim-crystal'
Plugin 'SirVer/ultisnips'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'neovim/python-client'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'Shougo/deoplete.nvim'
Plugin 'kristijanhusak/deoplete-phpactor'
Plugin 'RRethy/vim-illuminate'
" Plugin 'Valloric/YouCompleteMe'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

" solarized theme
set background=dark
colorscheme solarized

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" always show status line
set laststatus=2
" customize vert split
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermbg=NONE
" fix urxvt color8
let g:solarized_termtrans = 1
hi Normal guibg=NONE ctermbg=NONE
" line number
set nu

" PLUGIN CONFIGURATIONS

" ControlP
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules|vendor|plugins)$'

" php-refactoring-toolbox
let g:vim_php_refactoring_use_default_mapping = 0
let g:vim_php_refactoring_make_setter_fluent = 1
nnoremap <unique> <Leader>cp :call PhpCreateProperty()<CR>
nnoremap <unique> <Leader>cgs :call PhpCreateSettersAndGetters()<CR>

" pdv
let g:pdv_template_dir = $HOME . "/.vim/bundle/pdv/templates_snip"
nnoremap <unique> <Leader>cdoc :call pdv#DocumentWithSnip()<CR>

" Syntastic
" ale lint engine
let g:ale_linters = {
\   'php': ['php', 'phpcs', 'phpmd'],
\}
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
highlight ALEErrorSign ctermbg=0 ctermfg=red
highlight ALEWarningSign ctermbg=0 ctermfg=yellow
highlight SignColumn ctermbg=0

" Powerline (vim statusline)
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set noshowmode

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)

" NerdTree
map <C-n>  :NERDTreeToggle<CR>

" Omnifunc
" set completeopt-=preview

" Deoplete
" let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" phpactor
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true
nmap <Leader>gtd :call phpactor#GotoDefinition()<CR>
nmap <Leader>u :call phpactor#UseAdd()<CR>
vmap <silent><Leader>exm :<C-U>call phpactor#ExtractMethod()<CR>
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" phpcsfixer
let g:php_cs_fixer_path = "~/.config/composer/vendor/bin/php-cs-fixer"
let g:php_cs_fixer_rules = "@PSR2,no_unused_imports"

" CommandT
let g:CommandTFileScanner = "git"
