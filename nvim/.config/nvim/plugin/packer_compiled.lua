-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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

  _G._packer = _G._packer or {}
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
  local success, result = pcall(loadstring(s))
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
  Colorizer = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/Colorizer"
  },
  LargeFile = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/LargeFile"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  fzf = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  nerdtree = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  onehalf = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/onehalf/vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["roku.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/roku.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["todo-comments.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ["vader.vim"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vader.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-crystal"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-crystal"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gnupg"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-gnupg"
  },
  ["vim-godot"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-godot"
  },
  ["vim-graphql"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-graphql"
  },
  ["vim-jsx"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-jsx"
  },
  ["vim-jsx-typescript"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-jsx-typescript"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/home/anderson/.local/share/nvim/site/pack/packer/start/vim-vue"
  }
}

time([[Defining packer_plugins]], false)
-- Runtimepath customization
time([[Runtimepath customization]], true)
vim.o.runtimepath = vim.o.runtimepath .. ",/home/anderson/.local/share/nvim/site/pack/packer/start/onehalf/vim"
time([[Runtimepath customization]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
