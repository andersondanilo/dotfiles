-- Editor KeyBindings
vim.cmd [[map <Leader>"  :split<CR>]]
vim.cmd [[map <Leader>%  :vsplit<CR>]]
vim.cmd [[map <Leader>h :nohl<CR>]]
vim.cmd [[nmap  <Leader>s :update<CR>]]
vim.cmd [[imap <C-s> <C-[>:update<CR>]]
vim.cmd [[nmap <C-s> :update<CR>]]
vim.cmd [[map  <Leader>q :close<CR>]]
vim.cmd [[nmap <Leader>yf :let @+ = expand("%")<cr>]]

-- tab commands
vim.cmd [[nmap <Leader>to :tabonly<CR> ]]
vim.cmd [[nmap <Leader>tn :tabn<CR> ]]
vim.cmd [[nmap <Leader>tp :tabp<CR> ]]
vim.cmd [[nmap <Leader>tc :tabclose<CR> ]]
vim.cmd [[noremap <leader>1 1gt]]
vim.cmd [[noremap <leader>2 2gt]]
vim.cmd [[noremap <leader>3 3gt]]
vim.cmd [[noremap <leader>4 4gt]]
vim.cmd [[noremap <leader>5 5gt]]
vim.cmd [[noremap <leader>6 6gt]]
vim.cmd [[noremap <leader>7 7gt]]
vim.cmd [[noremap <leader>8 8gt]]
vim.cmd [[noremap <leader>9 9gt]]

-- Avoid Ctrl+C (Keyboard-Interrupt errors)
vim.cmd [[map <C-c> :echo "Ctrl+C temporary disabled use Ctrl+["<CR>]]
vim.cmd [[imap <C-c> <C-O>:echo "Ctrl+C temporary disabled use Ctrl+["<CR>]]
vim.cmd [[vmap <C-c> :echo "Ctrl+C temporary disabled use Ctrl+["<CR>]]

-- paste default register in visual mode without overwriting itself
-- vim.cmd [[xnoremap p pgvy]]

-- Custom commands
vim.cmd [[command FormatJSON :%!jq .]]
vim.cmd [[command FormatXML :%!xmllint --format -]]
vim.cmd [[command -range FormatJSONSel :<line1>,<line2>!jq .]]
vim.cmd [[command LspStop :lua vim.lsp.stop_client(vim.lsp.get_active_clients())]]

-- others
vim.cmd [[map <Leader>nt  :NERDTreeToggle<CR>]]
vim.cmd [[map <Leader>nf  :NERDTreeFind<CR>]]
vim.cmd [[nnoremap <silent> <expr> <Leader>pf (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":NERDTreeClose\<cr>:GFiles --cached --others --exclude-standard\<cr>"]]
vim.cmd [[nnoremap <silent> <Leader>pl :BLines<CR>]]
vim.cmd [[nnoremap <silent> <Leader>pg :GGrep<CR>]]
vim.cmd [[nnoremap <silent> <Leader>ps :GGrepExact<CR>]]
vim.cmd [[nmap  <Leader>f <Plug>(easymotion-overwin-f)]]
vim.cmd [[nmap <Leader>gd :lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[nmap <Leader>gn :lua vim.diagnostic.goto_next()<CR>]]
vim.cmd [[nmap <Leader>gp :lua vim.diagnostic.goto_prev()<CR>]]
vim.cmd [[nmap <Leader>ge :TroubleToggle document_diagnostics<CR>]]
vim.cmd [[nmap <Leader>ga :lua vim.lsp.buf.code_action()<CR>]]
vim.cmd [[nmap <Leader>gh :lua lsp_show_hover_doc()<CR>]]
vim.cmd [[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd [[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]]
vim.cmd [[imap <silent> <c-n> <Plug>(completion_trigger)]]
vim.cmd [[nmap = <Plug>(PatternIncrement)]]
vim.cmd [[nmap - <Plug>(PatternDecrement)]]

-- test
vim.cmd [[nmap <Leader>ti :lua require("neotest").run.run()<CR>]]
vim.cmd [[nmap <Leader>tf :lua require("neotest").run.run(vim.fn.expand("%"))<CR>]]
vim.cmd [[nmap <Leader>ts :lua require("neotest").run.stop()<CR>]]

-- custom movements
-- vim.cmd [[noremap <leader>j :<C-U>call smoothie#downwards() <CR>]]
-- vim.cmd [[noremap <leader>k :<C-U>call smoothie#upwards() <CR>]]
