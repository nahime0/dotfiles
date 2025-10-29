#!/usr/bin/env zsh

##################################
# Configuration files (dotfiles) #
##################################

# Hammerspoon
rm -rf $HOME/.hammerspoon
ln -s $DIR/config/hammerspoon $HOME/.hammerspoon
gum style --padding "0 2" "Created symbolic link for Hammerspoon config file..."

# Git
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignore
ln -s $DIR/config/git/gitconfig $HOME/.gitconfig
ln -s $DIR/config/git/gitignore $HOME/.gitignore
gum style --padding "0 2" "Created symbolic link for Git config file..."

# Kitty
rm -rf $HOME/.config/kitty
ln -s $DIR/config/kitty $HOME/.config/kitty
gum style --padding "0 2" "Created symbolic link for Kitty config file..."

# Ghostty
rm -rf $HOME/.config/ghostty
ln -s $DIR/config/ghostty $HOME/.config/ghostty
gum style --padding "0 2" "Created symbolic link for Ghostty config file..."

# Alacritty
rm -rf $HOME/.config/alacritty
ln -s $DIR/config/alacritty $HOME/.config/alacritty
gum style --padding "0 2" "Created symbolic link for Alacritty config file..."

# zsh
rm -rf $HOME/.zshrc
rm -rf $HOME/.zprofile
rm -rf $HOME/.p10k.zsh
ln -s $DIR/config/zsh/zshrc $HOME/.zshrc
ln -s $DIR/config/zsh/zprofile $HOME/.zprofile
ln -s $DIR/config/zsh/p10k.zsh $HOME/.p10k.zsh
gum style --padding "0 2" "Created symbolic link for zsh config file..."

# Tmux
rm -rf $HOME/.tmux.conf
ln -s $DIR/config/tmux/tmux.conf $HOME/.tmux.conf
gum style --padding "0 2" "Created symbolic link for Tmux config file..."

# IdeaVIM
rm -rf $HOME/.ideavimrc
ln -s $DIR/config/ideavim/ideavimrc $HOME/.ideavimrc
gum style --padding "0 2" "Created symbolic link for IdeaVIM config file..."

# Neovim
rm -rf $HOME/.config/nvim
ln -s $DIR/config/nvim $HOME/.config/nvim
gum style --padding "0 2" "Created symbolic link for Neovim config file..."

# Cursor
rm -rf $HOME/Library/Application\ Support/Cursor/User/settings.json
rm -rf $HOME/Library/Application\ Support/Cursor/User/keybindings.json
ln -s $DIR/config/cursor/settings.json $HOME/Library/Application\ Support/Cursor/User/settings.json
ln -s $DIR/config/cursor/keybindings.json $HOME/Library/Application\ Support/Cursor/User/keybindings.json
gum style --padding "0 2" "Created symbolic link for Cursor config file..."

# Visual Studio Code
rm -rf $HOME/Library/Application\ Support/Code/User/settings.json
rm -rf $HOME/Library/Application\ Support/Code/User/keybindings.json
ln -s $DIR/config/code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $DIR/config/code/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
gum style --padding "0 2" "Created symbolic link for Visual Studio Code config file..."

# PHPactor
rm -rf $HOME/.config/phpactor
ln -s $DIR/config/phpactor $HOME/.config/phpactor
gum style --padding "0 2" "Created symbolic link for PHPactor config file..."

# Micro
rm -rf $HOME/.config/micro
ln -s $DIR/config/micro $HOME/.config/micro
gum style --padding "0 2" "Created symbolic link for Micro config file..."
