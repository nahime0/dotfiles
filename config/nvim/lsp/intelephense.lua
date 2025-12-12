return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  settings = {
    intelephense = {
      files = {
        exclude = { '**/_laravel_idea/**' },
      },
    },
  },
}
