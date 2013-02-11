#install vimrc
cp .vimrc ~
sudo cp .vimrc ~
#vim packages
sudo pacman -S vim-colorsamplerpack vim-supertab vim-ultisnips vim-ultisnips 

#bash colors
sudo cp etc/* /etc/

#ssh configurations
cp -r .ssh ~/.ssh
