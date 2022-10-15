local mason_loaded, mason = pcall(require, "mason")

if not mason_loaded then
    print("mason not loaded")
    return
end

mason.setup({
    ui = {
        border = {
            "┌",
            "─",
            "┐",
            "│",
            "┘",
            "─",
            "└",
            "│",
        },
    },
    -- max_concurrent_installers = 1,
})
