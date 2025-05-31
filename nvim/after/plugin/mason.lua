require("mason").setup()
require("mason-lspconfig").setup {
    automatic_enable = true,
    ensure_installed = {
        'lua_ls',
        'gopls',
        'pylsp',
        'jsonls',
        'html',
        'eslint',
        'dockerls',
        'ansiblels',
    },
}
