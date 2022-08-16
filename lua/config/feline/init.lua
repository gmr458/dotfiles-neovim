local feline_loaded, feline = pcall(require, "feline")

if not feline_loaded then
    print("feline not loaded")
    return
end

local themes = {
    catppuccin = "catppuccin",
    kanagawa = "kanagawa",
}

local theme = themes.catppuccin

feline.setup({
    force_inactive = {
        filetypes = {
            "^NvimTree$",
            "^packer$",
            "^startify$",
            "^fugitive$",
            "^fugitiveblame$",
            "^qf$",
            "^help$",
            "^TelescopePrompt$",
            "^alpha$",
            "^lsp%-installer$",
            "^lspinfo$",
        },
        buftypes = {
            "^terminal$",
        },
        bufnames = {},
    },
    disable = { filetypes = { "^alpha$" } },
    theme = require("config.feline.themes." .. theme).palette(),
    components = require("config.feline.themes." .. theme).components(),
})
