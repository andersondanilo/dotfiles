local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
end

-- Setup custom linters
local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {
     "%f(%l,%c): %tarning %m",
     "%f(%l,%c): %rror %m"
  },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

nvim_lsp.efm.setup {
  -- handle formatting a lot of linters, see $HOME/.config/efm-langserver/config.yaml
  on_attach = on_attach,
  --on_attach = function(client, ...)
  --  --client.server_capabilities.documentFormattingProvider = true
  --  on_attach(client, ...)
  --end,
  root_dir = function()
    return vim.fn.getcwd()
  end
}


-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
nvim_lsp["tsserver"].setup {
  on_attach = function(client, ...)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, ...)
  end
}
nvim_lsp["jedi_language_server"].setup { on_attach = on_attach }
nvim_lsp["phpactor"].setup { on_attach = on_attach }
nvim_lsp["bright_script"].setup { on_attach = on_attach }
nvim_lsp["gdscript"].setup { on_attach = on_attach }
nvim_lsp["rust_analyzer"].setup {
  on_attach = on_attach,
  settings = {
      ['rust-analyzer'] = {
          checkOnSave = {
              allFeatures = true,
              overrideCommand = {
                  'cargo', 'clippy', '--workspace', '--message-format=json',
                  '--all-targets', '--all-features'
              }
          }
      }
  }
}
nvim_lsp["ruff_lsp"].setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
    }
  }
}
--nvim_lsp["rls"].setup {
--  on_attach = on_attach,
--  settings = {
--    rust = {
--      unstable_features = true,
--      build_on_save = false,
--      all_features = true,
--    },
--  },
--}

local original_on_publish_diagnostics = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = function (...)
  pcall(original_on_publish_diagnostics, ...)
end


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
-- ~/.local/state/nvim/lsp.log

vim.fn.sign_define("DiagnosticSignError",
    {text = "", texthl = "DiagnosticError"})
-- vim.fn.sign_define("DiagnosticSignWarning",
--     {text = "", texthl = "DiagnosticWarning"})
vim.fn.sign_define("DiagnosticSignWarn",
    {text = "", texthl = "DiagnosticWarning"})
vim.fn.sign_define("DiagnosticSignInformation",
    {text = "", texthl = "DiagnosticInformation"})
vim.fn.sign_define("DiagnosticSignHint",
    {text = "", texthl = "DiagnosticHint"})

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold * lua lsp_show_hover_diagnostics()]]

local lsp_timer_can_show_hover = vim.loop.new_timer()
local lsp_timer_hover_delay = vim.loop.new_timer()

lsp_can_show_hover_diagnostics = true

function lsp_show_hover_diagnostics()
  --lsp_timer_hover_delay:start(500, 0, vim.schedule_wrap(function()
    if lsp_can_show_hover_diagnostics then
      vim.diagnostic.open_float(0, {
        scope="line",
        focusable=false,
        --  silent=true,
        --  close_events={"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "BufLeave"}
      })
      --vim.lsp.diagnostic.show_line_diagnostics({
      --  focusable=false,
      --  silent=true,
      --  close_events={"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "BufLeave"}
      --})
    end
  --end))
end

function lsp_show_hover_doc()
  lsp_can_show_hover_diagnostics = false
  vim.lsp.buf.hover()
  lsp_timer_can_show_hover:start(1000, 0, vim.schedule_wrap(function()
    lsp_can_show_hover_diagnostics = true
  end))
end
