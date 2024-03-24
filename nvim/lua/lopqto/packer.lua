-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { "bluz71/vim-nightfly-colors", as = "nightfly" }
    use { "folke/tokyonight.nvim", as = "tokyonight" }
    use { "ellisonleao/gruvbox.nvim", as = "gruvbox" }
    use { "savq/melange-nvim", as = "melange" }
    use { 'nyoom-engineering/oxocarbon.nvim', as = 'oxocarbon' }
    use { "sainnhe/sonokai", as = "sonokai" }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use { 'theprimeagen/harpoon' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    use { 'github/copilot.vim' }
end)
