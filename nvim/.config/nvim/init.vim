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
call plug#end()

" Generic nvim configuration
set tabstop=4
set shiftwidth=4
set expandtab
set fillchars+=vert:│
set nu

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
" nvim-lsp
lua << EOF
vim.lsp.set_log_level("debug")

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<Leader>g', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  -- end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
nvim_lsp["tsserver"].setup { on_attach = on_attach }
nvim_lsp["phpactor"].setup { on_attach = on_attach, cmd = {os.getenv("HOME") .. "/.config/composer/vendor/bin/phpactor", "language-server"} }
EOF
