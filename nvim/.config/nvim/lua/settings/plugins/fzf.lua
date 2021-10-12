vim.cmd [[let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5, 'highlight': 'Comment' } }]]
vim.cmd [[let g:fzf_colors =
  \ { 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'] }]]
vim.cmd [[command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, { 'options': [ '-i' ] }, <bang>0)]]
vim.cmd [[command! -bang -nargs=* BLines
           \ call fzf#vim#buffer_lines(<q-args>,{'options': ['--layout=reverse','-i','--info=inline']}, <bang>0)]]
vim.cmd [[command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number --ignore-case -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 3..', 'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)]]
