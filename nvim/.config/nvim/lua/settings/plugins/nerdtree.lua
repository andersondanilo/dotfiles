vim.cmd [=[let NERDTreeIgnore = ['__pycache__', '\.pyc$']]=]
vim.cmd [[let NERDTreeMapOpenInTab='<C-t>']]
vim.cmd [[let NERDTreeMapOpenSplit='<C-x>']]
vim.cmd [[let NERDTreeQuitOnOpen=1]]
vim.cmd [[exec 'autocmd BufEnter,WinEnter NERD_tree_* set signcolumn=no']]

vim.cmd [[
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:DevIconsDefaultFolderOpenSymbol='' " symbol for open folder (f07c)
  let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol='' " symbol for closed folder (f07b)
  let NERDTreeDirArrowExpandable = ""
  let NERDTreeDirArrowCollapsible = ""
]]

-- vim.cmd [[
--   function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
--     exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
--     exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s+.*'. a:extension .'$#'
--   endfunction
-- 
--   call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
--   call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
--   call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
--   call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
--   call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
--   call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
--   call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
--   call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
--   call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
--   call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
--   call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
--   call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
--   call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
-- ]]
