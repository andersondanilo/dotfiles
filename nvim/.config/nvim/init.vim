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
Plug 'chrisbra/Colorizer'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
Plug 'andersondanilo/ale' " Plug 'dense-analysis/ale'
Plug 'nathunsmitty/nvim-ale-diagnostic'
Plug 'sonph/onehalf', { 'rtp': 'vim' } " theme
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'entrez/roku.vim'
Plug 'jamessan/vim-gnupg'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'andersondanilo/nvim-lspconfig'
Plug 'lambdalisue/suda.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'habamax/vim-godot'
" Plug 'tmux-focus-events.vim'
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
set signcolumn=yes
" colorscheme gruvbox
colorscheme onehalfdark
set fillchars+=vert:│
hi Normal guibg=NONE ctermbg=NONE

" Gruv box custom
" hi LineNr guibg=#3c3836
"
" onehalfdark custom " copy hi LineNr
hi SignColumn ctermfg=247 ctermbg=236 guifg=#919baa guibg=#282c34 


" Solarized custom
"hi VertSplit guibg=NONE guifg=#586e75
" NOT USED hi StatusLineNC guifg=#073642 guibg=#586e75
" let g:solarized_termcolors=256
" hi EndOfBuffer guifg=#002b36
" hi ALEErrorSign guibg=#073642 guifg=#dc322f
" hi ALEWarningSign guibg=#073642 guifg=#b58900
" hi SignColumn guifg=#657b83 guibg=#073642

" Editor KeyBindings
map <Leader>"  :split<CR>
map <Leader>%  :vsplit<CR>
map <Leader>ch :nohl<CR>
nmap  <Leader>s :w<CR>
imap <C-s> <C-[>:w<CR>
nmap <C-s> :w<CR>
map  <Leader>q :q<CR>
map  <Leader>x :qall<CR>
nmap <Leader>yf :let @+ = expand("%")<cr>

" faster c+[
set ttimeout
set ttimeoutlen=5

" Avoid Ctrl+C (Keyboard-Interrupt errors)
map <C-c> :echo "Ctrl+C temporary disabled use Ctrl+["<CR>
imap <C-c> <C-O>:echo "Ctrl+C temporary disabled use Ctrl+["<CR>
vmap <C-c> :echo "Ctrl+C temporary disabled use Ctrl+["<CR>

" Commands
command FormatJSON :%!jq .
command -range FormatJSONSel :<line1>,<line2>!jq .


" Plugin configuration
" ====================
" Airline (statusline)
let g:airline_theme='onehalfdark'
let g:airline_powerline_fonts = 0
let g:airline_solarized_dark_inactive_border = 1

" NerdTree
map <Leader>nt  :NERDTreeToggle<CR>
map <Leader>nf  :NERDTreeFind<CR>
let NERDTreeIgnore = ['__pycache__', '\.pyc$']
exec 'autocmd BufEnter,WinEnter NERD_tree_* set signcolumn=no'

" php refactoring
let g:vim_php_refactoring_use_default_mapping = 0
let g:vim_php_refactoring_auto_validate_sg = 1
let g:vim_php_refactoring_make_setter_fluent = 1

" Fzf
" let $FZF_DEFAULT_COMMAND = 'ag -g ""' " consider gitignore
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, { 'options': [ '-i' ] }, <bang>0) " Fzf case insensitive
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }
let g:fzf_colors =
  \ { 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'] }
nnoremap <silent> <expr> <Leader>p (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":GFiles --cached --others --exclude-standard\<cr>"

" ALE Linter
let g:ale_linters = {
\   'php': ['php', 'phpcs', 'phpstan', 'phpmd'],
\   'javascript': ['eslint'],
\   'python': ['flake8', 'mypy', 'pylint', 'pyright'],
\}
let g:ale_fixers = {
 \ 'php': ['php_cs_fixer'],
 \ 'javascript': ['eslint'],
 \ 'typescript': ['eslint', 'tslint', 'prettier', 'xo'],
 \ 'typescriptreact': ['eslint', 'tslint', 'prettier', 'xo'],
 \ 'rust': ['rustfmt'],
 \ 'brs': ['bsfmt_fixer'],
 \ 'python': ['autopep8'],
 \ }
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_php_cs_fixer_options = '--allow-risky=yes'
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpstan; fi; fi')
let g:ale_php_phpmd_executable = system('if ! type git &> /dev/null; then echo phpmd; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpmd; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpmd; fi; fi')
let g:ale_rust_cargo_use_clippy = 1

" deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" easy motion
" nmap  \| <Plug>(easymotion-overwin-f2)
nmap  <Leader>f <Plug>(easymotion-overwin-f)

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
nvim_lsp["phpactor"].setup { on_attach = on_attach }
nvim_lsp["brighterscript-ls"].setup { on_attach = on_attach }
nvim_lsp["gdscript"].setup { on_attach = on_attach }
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

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false
--     }
-- )

require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- vim.lsp.set_log_level("debug")
-- :lua print(vim.lsp.get_log_path())
-- ~/.cache/nvim/lsp.log
EOF


" Debug adapter protocols
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F6> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>

lua << EOF
-- lua code goes here
local dap = require('dap')

dap.set_log_level('trace')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Workspace/personal/test-debug/adapters/vscode-php-debug/out/phpDebug.js'},
}

dap.configurations.php = {
  {
      type = 'php',
      request = 'launch',
      name = 'Listen for xdebug',
      hostname = '0.0.0.0',
      stopOnEntry = false,
      log = true,
      serverSourceRoot = '/var/www/html/',
      localSourceRoot = vim.fn.getcwd() .. '/',
  },
}

dap.adapters.roku = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Workspace/personal/test-debug/adapters/roku-debug/dist/myRokuDebug.js'},
}

-- dap.configurations.brs = {
--   {
--       type = 'roku',
--       request = 'launch',
--       name = 'Roku debug',
--       log = true,
--       host = '192.168.0.118',
--       rootDir = vim.fn.getcwd(),
--       outDir = vim.fn.getcwd() .. '/out',
--       retainStagingFolder = true,
--   },
-- }

EOF
