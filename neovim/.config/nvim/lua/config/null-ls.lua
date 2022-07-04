local M = {}

function M.setup()
  local null_ls = require('null-ls')
  local sources = {
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.nixfmt,
    null_ls.builtins.formatting.rustfmt
  }
  null_ls.setup({ sources = sources })
end

return M
