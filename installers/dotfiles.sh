#!/usr/bin/env zsh

##################################
# Configuration files (dotfiles) #
##################################

# Git
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore
ln -s $DIR/git/gitconfig $HOME/.gitconfig
ln -s $DIR/git/gitignore $HOME/.gitignore
$GUM style --padding "0 2" "Created symbolic link for Git config file..."

# Kitty
rm -rf $HOME/.config/kitty
ln -s $DIR/kitty $HOME/.config/kitty
$GUM style --padding "0 2" "Created symbolic link for Kitty config file..."

# zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.zprofile
rm -rf $HOME/.p10k.zsh
ln -s $DIR/zsh/zshrc $HOME/.zshrc
ln -s $DIR/zsh/zprofile $HOME/.zprofile
ln -s $DIR/zsh/p10k.zsh $HOME/.p10k.zsh
$GUM style --padding "0 2" "Created symbolic link for zsh config file..."

# Tmux
rm -rf $HOME/.tmux.conf
ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf
$GUM style --padding "0 2" "Created symbolic link for Tmux config file..."

# Emacs
rm -rf $HOME/.emacs.d
ln -s $DIR/emacs/emacs.d $HOME/.emacs.d
$GUM style --padding "0 2" "Created symbolic link for Emacs config file..."

# VIM
rm -rf $HOME/.vimrc
ln -s $DIR/vim/vimrc $HOME/.vimrc
$GUM style --padding "0 2" "Created symbolic link for VIM config file..."

# IdeaVIM
rm -rf $HOME/.ideavimrc
ln -s $DIR/vim/ideavimrc $HOME/.ideavimrc
$GUM style --padding "0 2" "Created symbolic link for IdeaVIM config file..."

# Neovim
rm -rf $HOME/.config/nvim
ln -s $DIR/nvim $HOME/.config/nvim
$GUM style --padding "0 2" "Created symbolic link for Neovim config file..."

# PHPactor
rm -rf $HOME/.config/phpactor
ln -s $DIR/phpactor $HOME/.config/phpactor
$GUM style --padding "0 2" "Created symbolic link for PHPactor config file..."

# Micro
rm -rf $HOME/.config/micro
ln -s $DIR/micro $HOME/.config/micro
$GUM style --padding "0 2" "Created symbolic link for Micro config file..."
