-- Vue 3's language server delegates TypeScript requests to vtsls. Resolve the
-- plugin through mise so the configuration follows the active tool version.
local plugins = {}
if vim.fn.executable('mise') == 1 then
  local result = vim.system({ 'mise', 'where', 'npm:@vue/typescript-plugin' }, {
    text = true,
  }):wait()
  local install = vim.trim(result.stdout or '')
  if result.code == 0 and vim.fn.isdirectory(install .. '/node_modules/@vue/typescript-plugin') == 1 then
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = install,
        languages = { 'vue' },
        configNamespace = 'typescript',
        enableForWorkspaceTypeScriptVersions = true,
      },
    }
  end
end

return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = plugins,
      },
    },
  },
}
