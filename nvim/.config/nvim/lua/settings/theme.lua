vim.cmd [[ set fillchars+=vert:│ ]]
vim.cmd [[ set number relativenumber cursorline termguicolors ]]
vim.cmd [[ set background=dark ]]
vim.cmd [[ set signcolumn=yes ]]

function setup_theme()
  vim.cmd('colorscheme onehalfdark')
  vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
  vim.cmd('hi SignColumn ctermfg=247 ctermbg=236 guifg=#919baa guibg=#282c34')
  vim.cmd('hi Pmenu ctermfg=236 ctermbg=247 guifg=#B4C1D4 guibg=#373e49')
  vim.cmd('hi PmenuSel ctermfg=236 ctermbg=247 guifg=#1F2329 guibg=#98c379')
  vim.cmd('hi PmenuSbar ctermfg=236 ctermbg=247 guifg=#98c379 guibg=#2c323a')
  vim.cmd('hi PmenuThumb ctermfg=236 ctermbg=247 guifg=#2c323a guibg=#98c379')
  vim.cmd('hi LspDiagnosticsDefaultError guifg=#e06c75')
  vim.cmd('hi LspDiagnosticsDefaultWarning guifg=#e5c07b')
  vim.cmd('hi LspDiagnosticsDefaultInformation guifg=#61afef')
  vim.cmd('hi LspDiagnosticsDefaultHint guifg=#56b6c2')
  vim.cmd('hi DiagnosticError guifg=#e06c75')
  vim.cmd('hi DiagnosticWarning guifg=#e5c07b')
  vim.cmd('hi DiagnosticInformation guifg=#61afef')
  vim.cmd('hi DiagnosticHint guifg=#56b6c2')
  vim.cmd('call airline#load_theme()')
end

vim.cmd [[ autocmd VimEnter * lua setup_theme() ]]
