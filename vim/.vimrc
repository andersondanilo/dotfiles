set nocompatible              " be iMproved, required
filetype off                  " required

if getcwd() =~# '^\(/home/anderson/Workspace/\)'
  " https://vimtricks.com/p/local-vimrc-files/
  set secure exrc
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
" Plugin 'kien/ctrlp.vim'
Plugin 'wincent/command-t'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-sleuth'
Plugin 'leafgarland/typescript-vim'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
" Plugin 'w0rp/ale'
Plugin 'dense-analysis/ale'
Plugin 'elixir-editors/vim-elixir'
Plugin 'adoy/vim-php-refactoring-toolbox'
Plugin 'easymotion/vim-easymotion'
Plugin 'phpactor/phpactor'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-crystal/vim-crystal'
Plugin 'SirVer/ultisnips'
Plugin 'tobyS/vmustache'
Plugin 'tobyS/pdv'
Plugin 'neovim/python-client'
Plugin 'RRethy/vim-illuminate'
Plugin 'jwalton512/vim-blade'
Plugin 'posva/vim-vue'
Plugin 'mxw/vim-jsx'
Plugin 'cakebaker/scss-syntax.vim'
" Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'davidhalter/jedi-vim'
Plugin 'entrez/roku.vim'
Plugin 'jamessan/vim-gnupg'
" Plugin 'vim-gradle'
" Plugin 'ycm-core/YouCompleteMe'

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
" no fold
set nofoldenable

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
\   'php': ['php', 'phpcs', 'phpstan', 'phpmd'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
 \ 'php': ['php_cs_fixer'],
 \ 'javascript': ['eslint'],
 \ 'typescript': ['eslint', 'tslint', 'prettier', 'xo'],
 \ 'typescriptreact': ['eslint', 'tslint', 'prettier', 'xo']
 \ }
let g:ale_fix_on_save = 1
" let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
" let g:ale_php_cs_fixer_options = '--config=./.php_cs --allow-risky=yes'
let g:ale_php_cs_fixer_options = '--allow-risky=yes'
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpstan; fi; fi')
let g:ale_php_phpmd_executable = system('if ! type git &> /dev/null; then echo phpmd; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpmd; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpmd; fi; fi')
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
let NERDTreeIgnore = ['__pycache__', '\.pyc$']

" Jedi (Python)
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>gtd"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
autocmd FileType python setlocal completeopt-=preview
let g:jedi#show_call_signatures = "0"

" Omnifunc
" set completeopt-=preview

" phpactor
autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true

autocmd FileType php nmap <Leader>gtd :call phpactor#GotoDefinition()<CR>
autocmd FileType php nmap <Leader>u :call phpactor#UseAdd()<CR>
autocmd FileType php vmap <silent><Leader>exm :<C-U>call phpactor#ExtractMethod()<CR>
autocmd FileType php nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" tsuquyomi
let g:tsuquyomi_disable_quickfix = 1
autocmd FileType typescript,typescriptreact nmap <Leader>gtd :TsuDefinition<CR>
" typescript syntax
let g:typescript_indent_disable = 1

" phpcsfixer
let g:php_cs_fixer_enable_default_mapping = 1
let g:php_cs_fixer_path = system('if ! type git &> /dev/null; then echo php-cs-fixer; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/php-cs-fixer; if [ -x "$PSE" ]; then echo -n $PSE; else echo php-cs-fixer; fi; fi')
let g:php_cs_fixer_rules = "@PSR2,no_unused_imports"
autocmd FileType php nmap <Leader>pcf :call PhpCsFixerFixFile()<CR>

" CommandT
let g:CommandTFileScanner = "git"
let g:CommandTGitIncludeUntracked = 1
autocmd FileType crystal nmap <Leader>gtd :CrystalDef<CR>

" Crystal
let g:crystal_auto_format = 1

" Java
let g:JavaComplete_EnableDefaultMappings = 0
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" let g:ale_java_eclipselsp_path = "/opt/eclipselsp"

" Custom bindings
map <Leader>"  :split<CR>
map <Leader>%  :vsplit<CR>
