local cmd = { 'vue-language-server', '--stdio' }

-- Vue's unconstrained TypeScript peer can resolve to a version without the
-- tsserver API. Share vtsls's compatible SDK instead of that peer dependency.
if vim.fn.executable('mise') == 1 and vim.fn.executable('node') == 1 then
  local tool = vim.system({ 'mise', 'where', 'npm:@vtsls/language-server' }, {
    text = true,
  }):wait()
  if tool.code == 0 then
    local package = vim.trim(tool.stdout) .. '/node_modules/@vtsls/language-server/package.json'
    local script = [[
      const {createRequire} = require('node:module');
      const req = createRequire(require('node:fs').realpathSync(process.argv[1]));
      const service = createRequire(req.resolve('@vtsls/language-service'));
      console.log(require('node:path').dirname(service.resolve('typescript')));
    ]]
    local sdk = vim.system({ 'node', '-e', script, package }, { text = true }):wait()
    if sdk.code == 0 then
      table.insert(cmd, '--tsdk=' .. vim.trim(sdk.stdout))
    end
  end
end

return {
  cmd = cmd,
  filetypes = { 'vue' },
  root_markers = { 'package.json', '.git' },
}
