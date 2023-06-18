local ok, luasnip, from_vscode, cmp, types

ok, luasnip = pcall(require, "luasnip")
if not ok then
  vim.notify("luasnip could not be loaded")
  return
end

require("luasnip.config").setup({
  history = true,
  region_check_events = "InsertEnter",
  delete_check_events = "TextChanged,InsertLeave",
})

local custom_snippets_path = vim.fn.stdpath("config") .. "/custom-snippets"
local data_path = vim.fn.stdpath("data")

ok, from_vscode = pcall(require, "luasnip.loaders.from_vscode")
if not ok then
  vim.notify("luasnip.loaders.from_vscode could not be loaded")
  return
end
from_vscode.lazy_load({
  paths = {
    custom_snippets_path,
    data_path .. "/lazy/friendly-snippets",
    data_path .. "/lazy/vscode-react-javascript-snippets",
  },
})

ok, cmp = pcall(require, "cmp")
if not ok then
  vim.notify("cmp could not be loaded")
  return
end

local function border(hl_name)
  return {
    { "┌", hl_name },
    { "─", hl_name },
    { "┐", hl_name },
    { "│", hl_name },
    { "┘", hl_name },
    { "─", hl_name },
    { "└", hl_name },
    { "│", hl_name },
  }
end

ok, types = pcall(require, "cmp.types")
if not ok then
  vim.notify("cmp.types could not be loaded")
  return
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_kinds = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

cmp.setup({
  preselect = types.cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = types.cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  confirmation = { default_behavior = types.cmp.ConfirmBehavior.Replace },
  window = {
    completion = {
      border = border("CmpMenuBorder"),
      winhighlight = "Normal:CmpMenu,CursorLine:CmpMenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"),
      winhighlight = "Normal:CmpDoc",
    },
  },
  formatting = {
    fields = { "kind", "abbr" },
    format = function(_, vim_item)
      vim_item.kind = cmp_kinds[vim_item.kind] or ""
      return vim_item
    end,
  },
})

luasnip.filetype_extend("django-html", { "html" })
luasnip.filetype_extend("ejs", { "html" })
luasnip.filetype_extend("handlebars", { "html" })
luasnip.filetype_extend("hbs", { "html" })
luasnip.filetype_extend("htmldjango", { "html" })
-- luasnip.filetype_extend("javascript", { "html" })
-- luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("pug", { "html" })
-- luasnip.filetype_extend("typescript", { "html" })
-- luasnip.filetype_extend("typescriptreact", { "html" })
