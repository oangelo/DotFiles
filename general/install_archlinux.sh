#install vimrc
cp .vimrc ~
sudo cp .vimrc ~
#vim packages
sudo pacman -Sy vim-colorsamplerpack vim-supertab vim-ultisnips vim-ultisnips colorgcc colordiff bash-completion pkgfile
sudo pkgfile --update
#git configuration
cp .gitconfig ~

#bash colors
sudo cp etc/* /etc/

#ssh configurations
cp  .ssh/* ~/.ssh/
