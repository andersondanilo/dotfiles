-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/anderson/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/anderson/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/anderson/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/anderson/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/anderson/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["AutoSave.nvim"] = {
    config = { "\27LJ\2\nþ\2\0\0\a\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0'\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2&\3\4\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0004\4\0\0=\4\r\0034\4\0\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\15conditions\20filetype_is_not\20filename_is_not\1\0\2\vexists\2\15modifiable\2\vevents\1\3\0\0\16InsertLeave\16TextChanged\22execution_message\r%H:%M:%S\rstrftime\afn\bvim\24AutoSave: saved at \1\0\5 clean_command_line_interval\3\0\20on_off_commands\2\22write_all_buffers\1\19debounce_delay\3‡\1\fenabled\1\nsetup\rautosave\frequire\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/AutoSave.nvim",
    url = "https://github.com/Pocco81/AutoSave.nvim"
  },
  Colorizer = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/Colorizer",
    url = "https://github.com/chrisbra/Colorizer"
  },
  LargeFile = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/LargeFile",
    url = "https://github.com/vim-scripts/LargeFile"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\n‚\4\0\0\17\0\17\0(5\0\0\0004\1\0\0006\2\1\0\18\4\0\0B\2\2\4X\5\18€6\a\2\0009\a\3\a9\a\4\a\18\t\6\0+\n\1\0+\v\2\0B\a\4\0026\b\1\0\18\n\a\0B\b\2\4X\v\5€6\r\5\0009\r\6\r\18\15\1\0\18\16\f\0B\r\3\1E\v\3\3R\vù\127E\5\3\3R\5ì\1276\2\a\0'\4\b\0B\2\2\0029\2\t\0025\4\n\0=\1\v\0045\5\f\0=\5\r\4B\2\2\0016\2\2\0009\2\14\2'\3\16\0=\3\15\2K\0\1\0\28tabpages,winsize,winpos\19sessionoptions\6o\18pre_save_cmds\1\2\0\0\24tabdo NERDTreeClose\30auto_session_allowed_dirs\1\0\5 auto_session_create_enabled\2\25auto_restore_enabled\2\25auto_session_enabled\2\22auto_save_enabled\2\14log_level\tinfo\nsetup\17auto-session\frequire\vinsert\ntable\vexpand\afn\bvim\vipairs\1\4\0\0\20~/Workspace/*/*\28~/Workspace/*/scripts/*\31~/Workspace/*/playground/*\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/completion-nvim",
    url = "https://github.com/rafaelsq/completion-nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n`\0\0\4\0\4\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\rgitsigns\30settings/plugins/gitsigns\frequire\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/scrooloose/nerdtree"
  },
  ["nrpattern.nvim"] = {
    config = { "\27LJ\2\nb\0\0\4\0\4\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\14nrpattern\31settings/plugins/nrpattern\frequire\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nrpattern.nvim",
    url = "https://github.com/zegervdv/nrpattern.nvim"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-projectconfig"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23nvim-projectconfig\frequire\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-projectconfig",
    url = "https://github.com/windwp/nvim-projectconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  onehalf = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\28colorscheme onehalfdark\bcmd\bvim\0" },
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/onehalf/vim",
    url = "https://github.com/sonph/onehalf"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["php-indent"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/php-indent",
    url = "https://github.com/vim-scripts/php.vim"
  },
  ["php-syntax"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/php-syntax",
    url = "https://github.com/stanangeloff/php.vim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["roku.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/roku.vim",
    url = "https://github.com/entrez/roku.vim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  ["vader.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vader.vim",
    url = "https://github.com/junegunn/vader.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-crystal"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-crystal",
    url = "https://github.com/vim-crystal/vim-crystal"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gnupg"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-gnupg",
    url = "https://github.com/jamessan/vim-gnupg"
  },
  ["vim-godot"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-godot",
    url = "https://github.com/habamax/vim-godot"
  },
  ["vim-http"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-http",
    url = "https://github.com/nicwest/vim-http"
  },
  ["vim-jsx"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-jsx",
    url = "https://github.com/mxw/vim-jsx"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript",
    url = "https://github.com/peitalin/vim-jsx-typescript"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/tpope/vim-markdown"
  },
  ["vim-php-refactoring-toolbox"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-php-refactoring-toolbox",
    url = "https://github.com/adoy/vim-php-refactoring-toolbox"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-vue",
    url = "https://github.com/posva/vim-vue"
  },
  ["vim-zoom"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-zoom",
    url = "https://github.com/dhruvasagar/vim-zoom"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/home/anderson/.local/share/nvim/site/pack/packer/start/onehalf/vim"
time([[Runtimepath customization]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
try_loadstring("\27LJ\2\n‚\4\0\0\17\0\17\0(5\0\0\0004\1\0\0006\2\1\0\18\4\0\0B\2\2\4X\5\18€6\a\2\0009\a\3\a9\a\4\a\18\t\6\0+\n\1\0+\v\2\0B\a\4\0026\b\1\0\18\n\a\0B\b\2\4X\v\5€6\r\5\0009\r\6\r\18\15\1\0\18\16\f\0B\r\3\1E\v\3\3R\vù\127E\5\3\3R\5ì\1276\2\a\0'\4\b\0B\2\2\0029\2\t\0025\4\n\0=\1\v\0045\5\f\0=\5\r\4B\2\2\0016\2\2\0009\2\14\2'\3\16\0=\3\15\2K\0\1\0\28tabpages,winsize,winpos\19sessionoptions\6o\18pre_save_cmds\1\2\0\0\24tabdo NERDTreeClose\30auto_session_allowed_dirs\1\0\5 auto_session_create_enabled\2\25auto_restore_enabled\2\25auto_session_enabled\2\22auto_save_enabled\2\14log_level\tinfo\nsetup\17auto-session\frequire\vinsert\ntable\vexpand\afn\bvim\vipairs\1\4\0\0\20~/Workspace/*/*\28~/Workspace/*/scripts/*\31~/Workspace/*/playground/*\0", "config", "auto-session")
time([[Config for auto-session]], false)
-- Config for: AutoSave.nvim
time([[Config for AutoSave.nvim]], true)
try_loadstring("\27LJ\2\nþ\2\0\0\a\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0'\3\4\0006\4\5\0009\4\6\0049\4\a\4'\6\b\0B\4\2\2&\3\4\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0004\4\0\0=\4\r\0034\4\0\0=\4\14\3=\3\15\2B\0\2\1K\0\1\0\15conditions\20filetype_is_not\20filename_is_not\1\0\2\vexists\2\15modifiable\2\vevents\1\3\0\0\16InsertLeave\16TextChanged\22execution_message\r%H:%M:%S\rstrftime\afn\bvim\24AutoSave: saved at \1\0\5 clean_command_line_interval\3\0\20on_off_commands\2\22write_all_buffers\1\19debounce_delay\3‡\1\fenabled\1\nsetup\rautosave\frequire\0", "config", "AutoSave.nvim")
time([[Config for AutoSave.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\4\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\rgitsigns\30settings/plugins/gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-projectconfig
time([[Config for nvim-projectconfig]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\23nvim-projectconfig\frequire\0", "config", "nvim-projectconfig")
time([[Config for nvim-projectconfig]], false)
-- Config for: nrpattern.nvim
time([[Config for nrpattern.nvim]], true)
try_loadstring("\27LJ\2\nb\0\0\4\0\4\0\n6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\14nrpattern\31settings/plugins/nrpattern\frequire\0", "config", "nrpattern.nvim")
time([[Config for nrpattern.nvim]], false)
-- Config for: onehalf
time([[Config for onehalf]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\28colorscheme onehalfdark\bcmd\bvim\0", "config", "onehalf")
time([[Config for onehalf]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
