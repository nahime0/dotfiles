return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html', 'css', 'scss', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'vue', 'heex',
  },
  root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'package.json', '.git' },
  init_options = {
    userLanguages = {
      heex = 'html',
    },
  },
}
