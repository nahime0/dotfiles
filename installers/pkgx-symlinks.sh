#!/usr/bin/env zsh

##########################
# pkgx: https://pkgx.sh/ #
##########################

# Gum
rm -rf $HOME/bin/gum
ln -s $DIR/bin/pkgx/gum/gum $HOME/bin/gum
$GUM style --padding "0 2" "Created symbolic link for gum..."

# Ripgrep (rg): https://github.com/BurntSushi/ripgrep
rm -rf $HOME/bin/rg
ln -s $DIR/bin/pkgx/ripgrep/rg $HOME/bin/rg
$GUM style --padding "0 2" "Created symbolic link for ripgrep..."

# fzf: https://github.com/junegunn/fzf
rm -rf $HOME/bin/fzf
ln -s $DIR/bin/pkgx/fzf/fzf $HOME/bin/fzf
$GUM style --padding "0 2" "Created symbolic link for fzf..."

# bun: https://bun.sh/
rm -rf $HOME/bin/bun
rm -rf $HOME/bin/bunx
ln -s $DIR/bin/pkgx/bun/bun $HOME/bin/bun
ln -s $DIR/bin/pkgx/bun/bunx $HOME/bin/bunx
$GUM style --padding "0 2" "Created symbolic link for bun..."

# git
rm -rf $HOME/bin/git
rm -rf $HOME/bin/git-credential-osxkeychain
rm -rf $HOME/bin/git-cvsserver
rm -rf $HOME/bin/git-receive-pack
rm -rf $HOME/bin/git-shell
rm -rf $HOME/bin/git-upload-archive
rm -rf $HOME/bin/git-upload-pack
rm -rf $HOME/bin/scalar
ln -s $DIR/bin/pkgx/git-scm/git $HOME/bin/git
ln -s $DIR/bin/pkgx/git-scm/git-credential-osxkeychain $HOME/bin/git-credential-osxkeychain
ln -s $DIR/bin/pkgx/git-scm/git-cvsserver $HOME/bin/git-cvsserver
ln -s $DIR/bin/pkgx/git-scm/git-receive-pack $HOME/bin/git-receive-pack
ln -s $DIR/bin/pkgx/git-scm/git-shell $HOME/bin/git-shell
ln -s $DIR/bin/pkgx/git-scm/git-upload-archive $HOME/bin/git-upload-archive
ln -s $DIR/bin/pkgx/git-scm/git-upload-pack $HOME/bin/git-upload-pack
ln -s $DIR/bin/pkgx/git-scm/scalar $HOME/bin/scalar
$GUM style --padding "0 2" "Created symbolic link for git..."

# Python
rm -rf $HOME/bin/python
ln -s $DIR/bin/pkgx/python/python $HOME/bin/python
$GUM style --padding "0 2" "Created symbolic link for python..."

# Pip
rm -rf $HOME/bin/pip
ln -s $DIR/bin/pkgx/python/pip $HOME/bin/pip
$GUM style --padding "0 2" "Created symbolic link for pip..."

# pipx
rm -rf $HOME/bin/pipx
ln -s $DIR/bin/pkgx/python/pipx $HOME/bin/pipx
$GUM style --padding "0 2" "Created symbolic link for pipx..."

# Youtube-dl
rm -rf $HOME/bin/youtube-dl
ln -s $DIR/bin/pkgx/youtube-dl/youtube-dl $HOME/bin/youtube-dl
$GUM style --padding "0 2" "Created symbolic link for youtube-dl..."

# NeoVim
rm -rf $HOME/bin/nvim
ln -s $DIR/bin/pkgx/neovim/nvim $HOME/bin/nvim
$GUM style --padding "0 2" "Created symbolic link for NeoVim..."

# Node
rm -rf $HOME/bin/node
rm -rf $HOME/bin/npm
rm -rf $HOME/bin/npx
ln -s $DIR/bin/pkgx/nodejs/node $HOME/bin/node
ln -s $DIR/bin/pkgx/nodejs/npm $HOME/bin/npm
ln -s $DIR/bin/pkgx/nodejs/npx $HOME/bin/npx
$GUM style --padding "0 2" "Created symbolic link for Node..."

# PHP
rm -rf $HOME/bin/pear
rm -rf $HOME/bin/pecl
rm -rf $HOME/bin/phar
rm -rf $HOME/bin/php
rm -rf $HOME/bin/php-cgi
rm -rf $HOME/bin/php-config
rm -rf $HOME/bin/phpdbg
rm -rf $HOME/bin/phpize
ln -s $DIR/bin/pkgx/php/pear $HOME/bin/pear
ln -s $DIR/bin/pkgx/php/pecl $HOME/bin/pecl
ln -s $DIR/bin/pkgx/php/phar $HOME/bin/phar
ln -s $DIR/bin/pkgx/php/php $HOME/bin/php
ln -s $DIR/bin/pkgx/php/php-cgi $HOME/bin/php-cgi
ln -s $DIR/bin/pkgx/php/php-config $HOME/bin/php-config
ln -s $DIR/bin/pkgx/php/phpdbg $HOME/bin/phpdbg
ln -s $DIR/bin/pkgx/php/phpize $HOME/bin/phpize
$GUM style --padding "0 2" "Created symbolic link for PHP..."

# PHP / Composer
rm -rf $HOME/bin/composer
rm -rf $HOME/bin/composer.phar
ln -s $DIR/bin/pkgx/composer/composer $HOME/bin/composer
ln -s $DIR/bin/pkgx/composer/composer.phar $HOME/bin/composer.phar
$GUM style --padding "0 2" "Created symbolic link for PHP / Composer..."

# Mailpit
rm -rf $HOME/bin/mailpit
ln -s $DIR/bin/pkgx/mailpit/mailpit $HOME/bin/mailpit
$GUM style --padding "0 2" "Created symbolic link for Mailpit..."

# Tmux
rm -rf $HOME/bin/tmux
ln -s $DIR/bin/pkgx/tmux/tmux $HOME/bin/tmux
$GUM style --padding "0 2" "Created symbolic link for Tmux..."

# Micro
rm -rf $HOME/bin/micro
ln -s $DIR/bin/pkgx/micro/micro $HOME/bin/micro
$GUM style --padding "0 2" "Created symbolic link for Micro..."

# Erlang
rm -rf $HOME/bin/ct_run
rm -rf $HOME/bin/dialyzer
rm -rf $HOME/bin/epmd
rm -rf $HOME/bin/erl
rm -rf $HOME/bin/erlc
rm -rf $HOME/bin/escript
rm -rf $HOME/bin/run_erl
rm -rf $HOME/bin/to_erl
rm -rf $HOME/bin/typer
ln -s $DIR/bin/pkgx/erlang/ct_run $HOME/bin/ct_run
ln -s $DIR/bin/pkgx/erlang/dialyzer $HOME/bin/dialyzer
ln -s $DIR/bin/pkgx/erlang/epmd $HOME/bin/epmd
ln -s $DIR/bin/pkgx/erlang/erl $HOME/bin/erl
ln -s $DIR/bin/pkgx/erlang/erlc $HOME/bin/erlc
ln -s $DIR/bin/pkgx/erlang/escript $HOME/bin/escript
ln -s $DIR/bin/pkgx/erlang/run_erl $HOME/bin/run_erl
ln -s $DIR/bin/pkgx/erlang/to_erl $HOME/bin/to_erl
ln -s $DIR/bin/pkgx/erlang/typer $HOME/bin/typer
$GUM style --padding "0 2" "Created symbolic link for Erlang..."

# Elixir
rm -rf $HOME/bin/elixir
rm -rf $HOME/bin/elixirc
rm -rf $HOME/bin/iex
rm -rf $HOME/bin/mix
ln -s $DIR/bin/pkgx/elixir/elixir $HOME/bin/elixir
ln -s $DIR/bin/pkgx/elixir/elixirc $HOME/bin/elixirc
ln -s $DIR/bin/pkgx/elixir/iex $HOME/bin/iex
ln -s $DIR/bin/pkgx/elixir/mix $HOME/bin/mix
$GUM style --padding "0 2" "Created symbolic link for Elixir..."

# Quotes
rm -rf $HOME/.quotes.txt
ln -s $DIR/quotes/quotes.txt $HOME/.quotes.txt
