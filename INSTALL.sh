#!/bin/bash
echo "Installing Vim config..."
ln -s "$PWD"/vimfiles ~/.vim
ln -s "$PWD"/.vimrc ~/.vimrc
echo Make tmp dir for undofiles and such
mkdir ~/.vimtmp
echo Installing packages...
vim -c "BundleInstall!"
echo setting up fonts...
git clone https://github.com/powerline/fonts.git
cd fonts
chmod +x install.sh
bash install.sh

echo Done
