#!/bin/bash
# cat shell/bashrc >> ~/.bashrc
# cp shell/tmux.conf ~/.tmux.conf

NVIM=$(which nvim)
if [ "$NVIM" == "" ]; then
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
    sudo apt install -y fuse
fi

# vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# nodejs
curl -sL install-node.now.sh | sudo bash

sudo apt install -y silversearcher-ag
sudo apt install -y fzf
sudo apt install -y clangd
cp -a vim/* ~/.config/nvim/