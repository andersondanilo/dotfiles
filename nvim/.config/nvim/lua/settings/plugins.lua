vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- can manage itself

    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'scrooloose/nerdtree'
    use 'tpope/vim-fugitive'
    use 'junegunn/fzf.vim'
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-sleuth'
    use 'leafgarland/typescript-vim'
    use 'peitalin/vim-jsx-typescript'
    use 'chrisbra/Colorizer'
    use 'adoy/vim-php-refactoring-toolbox'
    --use '2072/php-indenting-for-vim'
    use {'vim-scripts/php.vim', as = 'php-indent'}
    use {'stanangeloff/php.vim', as = 'php-syntax'}
    use {
        'sonph/onehalf',
        rtp = 'vim',
        config = function() 
            vim.cmd [[colorscheme onehalfdark]]
        end
    }
    use 'posva/vim-vue'
    use 'mxw/vim-jsx'
    use 'entrez/roku.vim'
    use 'jamessan/vim-gnupg'
    use 'easymotion/vim-easymotion'
    use 'rafaelsq/completion-nvim'
    use 'neovim/nvim-lspconfig'
    use 'lambdalisue/suda.vim'
    use 'mfussenegger/nvim-dap'
    use 'habamax/vim-godot'
    use 'vim-crystal/vim-crystal'
    use 'junegunn/vader.vim'
    use 'psliwka/vim-smoothie'
    use 'nvim-lua/plenary.nvim'
    use 'folke/todo-comments.nvim'
    use 'vim-scripts/LargeFile'
    use 'jparise/vim-graphql'
    use 'cespare/vim-toml'
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        vim.cmd(':TSUpdate') 
      end,
      config = function()
        require"settings/plugins/treesitter"
      end,
    }
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'kyazdani42/nvim-web-devicons'
    use 'folke/trouble.nvim'
    use {
      'zegervdv/nrpattern.nvim',
      config = function()
        -- Basic setup
        local patterns = require"settings/plugins/nrpattern"
        require"nrpattern".setup(patterns)
      end,
    }
    -- use 'airblade/vim-gitgutter'
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        local config = require"settings/plugins/gitsigns"
        require('gitsigns').setup(config)
      end
    }
    -- use {
    --    'NTBBloodbath/rest.nvim',
    --    requires = { "nvim-lua/plenary.nvim" },
    --    config = function()
    --      require"settings/plugins/rest-nvim"
    --    end
    -- }
    -- use { 'nicwest/vim-http' }

    use { 'rust-lang/rust.vim' }
    use { 'ryanoasis/vim-devicons' }
    use {
      'windwp/nvim-projectconfig',
      config = function()
        require('nvim-projectconfig').setup()
      end
    }
    -- use {
    --   'Pocco81/auto-save.nvim',
    --   config = function()
    --     require('auto-save').setup(
    --       {
    --         enabled = false,
    --         execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    --         events = {"InsertLeave", "TextChanged"},
    --         conditions = {
    --             exists = true,
    --             filename_is_not = {},
    --             filetype_is_not = {},
    --             modifiable = true
    --         },
    --         write_all_buffers = false,
    --         on_off_commands = true,
    --         clean_command_line_interval = 0,
    --         debounce_delay = 135
    --       }
    --     )
    --   end
    -- }
    use {
      'rmagatti/auto-session',
      config = function()
        local patterns = {
          '~/Workspace/*/*',
          '~/Workspace/*/scripts/*',
          '~/Workspace/*/playground/*',
        }

        local auto_session_allowed_dirs = {}

        for _, pattern in ipairs(patterns) do
          local paths = vim.fn.expand(pattern, false, true)
          for _, path in ipairs(paths) do
            table.insert(auto_session_allowed_dirs, path)
          end
        end

        require('auto-session').setup {
          log_level = 'error',
          auto_session_allowed_dirs = auto_session_allowed_dirs,
          auto_session_enabled = true,
          auto_save_enabled = true,
          auto_restore_enabled = true,
          auto_session_create_enabled = true,
          pre_save_cmds = {"tabdo NERDTreeClose"}
        }

        vim.o.sessionoptions="tabpages,winsize,winpos"
      end
    }
    use { 'tpope/vim-markdown' }
    use { 'dhruvasagar/vim-zoom' }
    use { 'github/copilot.vim', config = function() require('settings/plugins/copilot') end }
    --use {
    --  'wikitopian/hardmode',
    --  config = function()
    --    vim.api.nvim_exec([[autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()]], false)
    --  end
    --}
    -- use { 'vwxyutarooo/nerdtree-devicons-syntax' }
    -- use { 'tiagofumo/vim-nerdtree-syntax-highlight' }

    --use {
    --    'oberblastmeister/neuron.nvim',
    --    config = function()
    --        require'settings/plugins/neuron'
    --    end
    --}
    --use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use { "johmsalas/text-case.nvim",
      config = function()
        require('textcase').setup {}
      end
    }
    use 'tpope/vim-surround'
    use { 'tpope/vim-unimpaired' }
    use 'tpope/vim-repeat'

    use {
      "nvim-neotest/neotest",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "haydenmeade/neotest-jest",
        "olimorris/neotest-phpunit"
      },
      config = function() require"settings/plugins/neotest" end
    }
end)
