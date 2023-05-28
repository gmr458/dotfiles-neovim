local ok, config = pcall(require, "kommentary.config")
if not ok then
  vim.notify("kommentary.config could not be loaded")
  return
end

config.configure_language("default", { prefer_single_line_comments = true })
config.use_extended_mappings()
