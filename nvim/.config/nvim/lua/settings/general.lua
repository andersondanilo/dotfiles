local notify = vim.notify
vim.notify = function(msg, ...)
  -- ignored  notify messages
  if msg:match("lspconfig") and msg:match("utostart for") then 
      return
  end

  if msg:match("used_by is deprecated") then
    return
  end

  notify(msg, ...)
end

vim.cmd [[ 
  set tabstop=4
  set shiftwidth=4
  set expandtab
  set ttimeout
  set ttimeoutlen=5
  set completeopt=menuone,noinsert,noselect
  set shortmess+=c
  set nohidden
  set splitbelow
  set splitright
  set scrolloff=3
  let g:mapleader = "ç"
]]