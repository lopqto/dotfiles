-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Extend the global config so every server advertises cmp capabilities
vim.lsp.config('*', {
    capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.config['*'].capabilities or {},
        require('cmp_nvim_lsp').default_capabilities()
    ),
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- These are example language servers.

local function root_dir_from_markers(markers)
    return function(bufnr, on_dir)
        on_dir(vim.fs.root(bufnr, markers))
    end
end

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }, -- Recognize the vim global
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
            },
        },
    },
})

vim.lsp.config('gopls', {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
    root_dir = root_dir_from_markers({ 'go.mod', '.git' }),
})

vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 100,
                },
            },
        },
    },
})

vim.lsp.config('jsonls', {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_dir = root_dir_from_markers({ '.git', 'package.json' }),
})

vim.lsp.config('html', {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'htmldjango' },
    root_dir = root_dir_from_markers({ '.git', 'package.json' }),
})

vim.lsp.config('eslint', {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_dir = root_dir_from_markers({ '.git', 'package.json' }),
})

vim.lsp.config('dockerls', {
    cmd = { 'docker-langserver', '--stdio' },
    filetypes = { 'dockerfile' },
    root_dir = root_dir_from_markers({ '.git', 'Dockerfile' }),
})

vim.lsp.config('ansiblels', {
    cmd = { 'ansible-language-server', '--stdio' },
    filetypes = { 'yaml.ansible' },
    root_dir = root_dir_from_markers({ '.git', 'ansible.cfg' }),
})

vim.lsp.enable({ 'lua_ls', 'gopls', 'pylsp', 'jsonls', 'html', 'eslint', 'dockerls', 'ansiblels' })

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
})
