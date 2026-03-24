require('neotest').setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(path)
        local file = vim.fn.expand('%:p')
        if string.find(file, "/packages/") then
          return string.match(file, "(.-/[^/]+/)src")
        end
        return vim.fn.getcwd()
      end,
      jestConfigFile = function()
        local file = vim.fn.expand('%:p')
        if string.find(file, "/packages/") then
          return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
        end

        return vim.fn.getcwd() .. "/jest.config.ts"
      end,
    }),
    require('neotest-phpunit')
  }
})
