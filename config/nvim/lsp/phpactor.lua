return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  init_options = {
    ['language_server_phpstan.enabled'] = false,
    ['language_server_psalm.enabled'] = false,
  },
}
