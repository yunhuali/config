#!/bin/bash

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
if [ ! -d ~/.config/nvim/ ]; then
  mkdir ~/.config/nvim
fi
cp -a vim/* ~/.config/nvim/
sudo pip install neovim

# cat ./shell/bashrc >> ~/.bashrc
IFS=$'\n'
all=$(cat shell/bashrc)
for one in $all; do
    out=$(cat ~/.bashrc | grep "$one")
    if [ "$out" == "" ]; then
        echo "append '$one' to ~/.bashrc"
        echo $one >> ~/.bashrc
    fi
done
cp ./shell/tmux.conf ~/.tmux.conf

nvim +'PlugInstall' +qall
# (cd $HOME/.vim/plugged/YouCompleteMe; python3 ./install.py)

# for java
# nvim +'CocInstall coc-java' +qall
# sudo mkdir /usr/local/share/lombok
# sudo wget https://projectlombok.org/downloads/lombok.jar -o /usr/local/share/lombok/lombok.jar
# ( cd ~/.config/coc/extensions/coc-java-data/server; \
#    wget https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz; \
#    tar xvf jdt-language-server-0.57.0-202006172108.tar.gz )

# echo "Run source ./shell/bashrc then open vim and run :PlugInstall"
# echo "then cd $HOME/.vim/plugged/YouCompleteMe; python3 ./install.py"
