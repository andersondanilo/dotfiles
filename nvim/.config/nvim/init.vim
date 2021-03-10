" Plugin installation
" ===================
call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive' " Git
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sleuth' " Detect indent
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'dense-analysis/ale'
Plug 'altercation/vim-colors-solarized'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'entrez/roku.vim'
Plug 'jamessan/vim-gnupg'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'andersondanilo/nvim-lspconfig'
Plug 'lambdalisue/suda.vim'
call plug#end()

" Generic nvim configuration
set tabstop=4
set shiftwidth=4
set expandtab
set fillchars+=vert:│
set nu
set nofoldenable

" Theme configuration
set background=dark
colorscheme solarized
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermbg=NONE
" fix urxvt color8
let g:solarized_termtrans = 1
hi Normal guibg=NONE ctermbg=NONE


" Plugin configuration
" ====================
" Airline (statusline)
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

" NerdTree
map <Leader>n  :NERDTreeToggle<CR>
let NERDTreeIgnore = ['__pycache__', '\.pyc$']

" Fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
let g:fzf_colors =
  \ { 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'] }
map <Leader>p  :Files<CR>

" ALE Linter
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
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_php_cs_fixer_options = '--allow-risky=yes'
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpstan; fi; fi')
let g:ale_php_phpmd_executable = system('if ! type git &> /dev/null; then echo phpmd; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpmd; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpmd; fi; fi')
highlight ALEErrorSign ctermbg=0 ctermfg=red
highlight ALEWarningSign ctermbg=0 ctermfg=yellow
highlight SignColumn ctermbg=0
highlight PMenu cterm=none ctermfg=darkblue ctermbg=black gui=none guifg=darkblue guibg=black

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview


" Language Server Protocal
" ===========================
" keybindings
nmap <Leader>gd :lua vim.lsp.buf.definition()<CR>
nmap <Leader>hv :lua vim.lsp.buf.hover()<CR>
nmap <Leader>rf :lua vim.lsp.buf.references()<CR>

" Language servers
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
nvim_lsp["tsserver"].setup { on_attach = on_attach }
nvim_lsp["jedi_language_server"].setup { on_attach = on_attach }
nvim_lsp["phpactor"].setup { on_attach = on_attach, cmd = {os.getenv("HOME") .. "/.config/composer/vendor/bin/phpactor", "language-server"} }
EOF
