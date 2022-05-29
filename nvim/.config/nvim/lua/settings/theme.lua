vim.cmd [[ set fillchars+=vert:│ ]]
vim.cmd [[ set number relativenumber cursorline termguicolors ]]
vim.cmd [[ set background=dark ]]
vim.cmd [[ set signcolumn=yes ]]

function setup_theme()
  local colorscheme = "onehalfdark"
  vim.cmd('colorscheme ' .. colorscheme)

  vim.cmd [[
    hi Normal guibg=NONE ctermbg=NONE
    hi SignColumn ctermfg=247 ctermbg=236 guifg=#919baa guibg=#282c34
    hi Pmenu ctermfg=236 ctermbg=247 guifg=#B4C1D4 guibg=#373e49
    hi PmenuSel ctermfg=236 ctermbg=247 guifg=#1F2329 guibg=#98c379
    hi PmenuSbar ctermfg=236 ctermbg=247 guifg=#98c379 guibg=#2c323a
    hi PmenuThumb ctermfg=236 ctermbg=247 guifg=#2c323a guibg=#98c379
    hi clear CursorLineNr
    hi def link CursorLineNr LineNr
    hi clear NERDTreeFlags
    hi def link NERDTreeFlags Comment
  ]]

  local signs = {
    Error = { guifg = "#e06c75" },
    Warning = { guifg = "#e5c07b" },
    Information = { guifg = "#61afef" },
    Hint = { guifg = "#56b6c2" },
  }

  for sign_name, sign_config in pairs(signs) do
    vim.cmd('hi LspDiagnosticsDefault'..sign_name..' guifg='..sign_config['guifg'])
    vim.cmd('hi LspDiagnosticsSign'..sign_name..' guifg='..sign_config['guifg'])
    vim.cmd('hi Diagnostic'..sign_name..' guifg='..sign_config['guifg'])
  end

  vim.fn.sign_define("DiagnosticSignError",
      {text = "", texthl = "DiagnosticError"})
  vim.fn.sign_define("DiagnosticSignWarn",
      {text = "", texthl = "DiagnosticWarning"})
  vim.fn.sign_define("DiagnosticSignInformation",
      {text = "", texthl = "DiagnosticInformation"})
  vim.fn.sign_define("DiagnosticSignHint",
      {text = "", texthl = "DiagnosticHint"})

  vim.cmd [[let g:airline#extensions#nvimlsp#error_symbol = " "]]
  vim.cmd [[let g:airline#extensions#nvimlsp#warning_symbol = " "]]

  local colorscheme = 'onehalfdark'

  local diags_colors = {
    error = { bg = { signs['Error']['guifg'], "233" }, fg = { "#282c34", "203"} },
    warning = { bg = { signs['Warning']['guifg'], "233" }, fg = { "#282c34", "208" } }
  }

  local airline_styles = { 'normal', 'insert', 'visual', 'replace', 'inactive' }
  local airline_styles_mod = { "", "_modified" }

  for error_type, error_style in pairs(diags_colors) do
    for _, airline_style in ipairs(airline_styles) do
      for _, airline_style_mod in ipairs(airline_styles_mod) do
        vim.cmd(string.format(
           "let g:airline#themes#%s#palette.%s%s.airline_%s = [\"%s\", \"%s\", \"%s\", \"%s\"]",
           colorscheme,
           airline_style,
           airline_style_mod,
           error_type,
           error_style["fg"][1],
           error_style["bg"][1],
           error_style["fg"][2],
           error_style["bg"][2]
        ))
      end
    end
  end

  vim.cmd('call airline#load_theme()')
end

vim.cmd [[ autocmd VimEnter * lua setup_theme() ]]
