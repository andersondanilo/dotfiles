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
Plug 'lifepillar/vim-solarized8'
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
set termguicolors
colorscheme solarized8
set fillchars+=vert:│
hi VertSplit guibg=NONE guifg=#586e75
" hi StatusLineNC guifg=#073642 guibg=#586e75
hi Normal guibg=NONE ctermbg=NONE
let g:solarized_termcolors=256
hi EndOfBuffer guifg=#002b36
hi ALEErrorSign guibg=#073642 guifg=#dc322f
hi ALEWarningSign guibg=#073642 guifg=#b58900
hi SignColumn guifg=#657b83 guibg=#073642

" Editor KeyBindings
map <Leader>"  :split<CR>
map <Leader>%  :vsplit<CR>
map <Leader>ch :nohl<CR>


" Plugin configuration
" ====================
" Airline (statusline)
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
let g:airline_solarized_dark_inactive_border = 1

" NerdTree
map <Leader>nt  :NERDTreeToggle<CR>
map <Leader>nf  :NERDTreeFind<CR>
let NERDTreeIgnore = ['__pycache__', '\.pyc$']

" Fzf
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, { 'options': [ '-i' ] }, <bang>0) " Fzf case insensitive
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
 \ 'typescriptreact': ['eslint', 'tslint', 'prettier', 'xo'],
 \ 'rust': ['rustfmt'],
 \ }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_php_cs_fixer_options = '--allow-risky=yes'
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpstan; fi; fi')
let g:ale_php_phpmd_executable = system('if ! type git &> /dev/null; then echo phpmd; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpmd; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpmd; fi; fi')
" highlight PMenu cterm=none ctermfg=darkblue ctermbg=black gui=none guifg=darkblue guibg=black
let g:ale_rust_cargo_use_clippy = 1

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" Language Server Protocal
" ===========================
" keybindings
nmap <Leader>gd :lua vim.lsp.buf.definition()<CR>
nmap <Leader>hv :lua vim.lsp.buf.hover()<CR>
nmap <Leader>rf :lua vim.lsp.buf.references()<CR>
nmap <Leader>ca :lua vim.lsp.buf.code_action()<CR>

" Language servers
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
nvim_lsp["tsserver"].setup { on_attach = on_attach }
nvim_lsp["jedi_language_server"].setup { on_attach = on_attach }
nvim_lsp["phpactor"].setup { on_attach = on_attach, cmd = {os.getenv("HOME") .. "/.config/composer/vendor/bin/phpactor", "language-server"} }
nvim_lsp["rls"].setup {
  on_attach = on_attach,
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- vim.lsp.set_log_level("debug")
-- :lua print(vim.lsp.get_log_path())
-- ~/.cache/nvim/lsp.log
EOF
