return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        arg = "leetcode.nvim",
        lang = "python3",

        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
    },
}
