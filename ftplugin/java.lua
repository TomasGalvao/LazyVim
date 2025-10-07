local home = os.getenv('HOME')

local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1])
local proj_name = vim.fn.fnamemodify(root_dir, ':p:h:t')


require('jdtls').start_or_attach({
  cmd = {
    'jdtls',
    '-configuration', home .. '/.cache/jdtls/config',
    '-data', home .. '/.cache/jdtls/workspace/' .. proj_name
  },
  root_dir = root_dir,
  -- See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      codeGeneration = {
        generateComments = true,
      },
      jdt = {
        ls = {
          protoBufSupport = { enabled = true },
        }
      },
      referenceCodeLens = { enabled = true },
      signatureHelp = {
        enabled = true,
        description = { enabled = true }
      },
    },
  },
  init_options = {
  },
  on_attach = function()
    --jdtls.setup_dap({ hotcodereplace = 'auto' })
  end,
})
