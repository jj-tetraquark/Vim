#!/bin/bash
echo "Installing Neovim"
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

echo "Installing necessarry python stuff"
sudo apt-get install python-dev python-pip python3-dev python3-pip
pip install --user neovim
pip3 install --user neovim

echo "Installing Neovim config..."
ln -s "$PWD"/vimfiles ~/.vim
ln -s "$PWD"/.vimrc ~/.vimrc
echo Make tmp dir for undofiles and such
mkdir ~/.vimtmp
echo "Setup NeoVim"

mkdir -p ~/.config/nvim
cp "$PWD"/init.vim ~/.config/nvim/

echo Installing packages...
nvim -c "PlugInstall"

echo "Alias nvim to vim"
echo "alias vim=nvim" >> ~/.bashrc

echo "Done! (Remember to source your bashrc file)"
