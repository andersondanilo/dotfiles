vim.cmd [[let g:airline_theme='onehalfdark']]
vim.cmd [[let g:airline_powerline_fonts = 0]]
vim.cmd [[let g:airline_solarized_dark_inactive_border = 1]]

vim.cmd [[let g:airline#extensions#tabline#enabled = 1]]
vim.cmd [[let g:airline#extensions#tabline#formatter = 'default']]
vim.cmd [[let g:airline#extensions#tabline#show_splits = 0]]
vim.cmd [[let g:airline#extensions#tabline#show_buffers = 0]]
vim.cmd [[let g:airline#extensions#tabline#show_tabs = 1]]
vim.cmd [[let g:airline#extensions#tabline#show_tab_nr = 1]]
vim.cmd [[let g:airline#extensions#tabline#tab_nr_type = 1]]
vim.cmd [[let g:airline#extensions#tabline#tab_min_count = 2]]

--vim.cmd [[
--  function! AirlineInit()
--      let g:airline_section_z = airline#section#create('%#__accent_bold#%{zoom#statusline()}%3l%#__restore__#/%L :%3v')
--  endfunction
--  autocmd User AirlineAfterInit call AirlineInit()
--]]
