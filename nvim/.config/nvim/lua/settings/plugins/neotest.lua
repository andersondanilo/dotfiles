require('neotest').setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
    require('neotest-phpunit')
  }
})
