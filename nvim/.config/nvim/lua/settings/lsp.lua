local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- require "lsp_signature".on_attach({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   handler_opts = {
  --     border = "none",
  --     -- toggle_key = "<C-h>",
  --     padding = " "
  --   }
  -- }, bufnr)
  -- require'completion'.on_attach(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
  if client.resolved_capabilities.text_ then
    require'completion'.on_attach(client, bufnr)
  end
end

-- Setup custom linters
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

nvim_lsp.efm.setup {
  on_attach = function(client, ...)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    on_attach(client, ...)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}


-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
nvim_lsp["tsserver"].setup {
  on_attach = function(client, ...)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    on_attach(client, ...)
  end
}
nvim_lsp["jedi_language_server"].setup { on_attach = on_attach }
nvim_lsp["phpactor"].setup { on_attach = on_attach }
-- nvim_lsp["brighterscript-ls"].setup { on_attach = on_attach }
nvim_lsp["gdscript"].setup { on_attach = on_attach }
nvim_lsp["rls"].setup {
  on_attach = on_attach,
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false
--     }
-- )

-- require("nvim-ale-diagnostic")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)


require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss"
  },
}


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }

vim.lsp.set_log_level("debug")
-- :lua print(vim.lsp.get_log_path())
-- ~/.cache/nvim/lsp.log

vim.fn.sign_define("DiagnosticSignError",
    {text = "", texthl = "DiagnosticError"})
vim.fn.sign_define("DiagnosticSignWarning",
    {text = "", texthl = "DiagnosticWarning"})
vim.fn.sign_define("DiagnosticSignInformation",
    {text = "", texthl = "DiagnosticInformation"})
vim.fn.sign_define("DiagnosticSignHint",
    {text = "", texthl = "DiagnosticHint"})

--  function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--    opts = opts or {}
--  
--    bufnr = bufnr or 0
--    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--  
--    local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
--    if vim.tbl_isempty(line_diagnostics) then return end
--  
--    local diagnostic_message = ""
--    for i, diagnostic in ipairs(line_diagnostics) do
--      diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--      print(diagnostic_message)
--      if i ~= #line_diagnostics then
--        diagnostic_message = diagnostic_message .. "\n"
--      end
--    end
--    vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
--  end
--  
--  vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
