require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "go", "bash", "yaml", "make", "json", "toml",
        "rust", "haskell", "sql", "dockerfile", "csv", "zig" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
