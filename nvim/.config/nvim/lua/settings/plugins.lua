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
    use 'tpope/vim-surround'
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
    use {'nvim-treesitter/nvim-treesitter', run = function() vim.cmd(':TSUpdate') end}
    use 'kyazdani42/nvim-web-devicons'
    use 'folke/trouble.nvim'
end)
