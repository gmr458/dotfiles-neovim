local gitsigns_loaded, gitsigns = pcall(require, "gitsigns")

if not gitsigns_loaded then
    print("gitsigns not loaded")
    return
end

gitsigns.setup({
    signs = {
        delete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "契",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
    },
    attach_to_untracked = false,
})

-- require("scrollbar.handlers.gitsigns").setup()
