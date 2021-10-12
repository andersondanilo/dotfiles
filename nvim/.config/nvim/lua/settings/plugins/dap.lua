-- lua code goes here
local dap = require('dap')

dap.set_log_level('trace')

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Workspace/personal/test-debug/adapters/vscode-php-debug/out/phpDebug.js'},
}

dap.configurations.php = {
  {
      type = 'php',
      request = 'launch',
      name = 'Listen for xdebug',
      hostname = '0.0.0.0',
      stopOnEntry = false,
      log = true,
      serverSourceRoot = '/var/www/html/',
      localSourceRoot = vim.fn.getcwd() .. '/',
  },
}

dap.adapters.roku = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/Workspace/personal/test-debug/adapters/roku-debug/dist/myRokuDebug.js'},
}

-- dap.configurations.brs = {
--   {
--       type = 'roku',
--       request = 'launch',
--       name = 'Roku debug',
--       log = true,
--       host = '192.168.0.118',
--       rootDir = vim.fn.getcwd(),
--       outDir = vim.fn.getcwd() .. '/out',
--       retainStagingFolder = true,
--   },
-- }

