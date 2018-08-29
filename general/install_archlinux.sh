#install vimrc
cp .vimrc ~
sudo cp .vimrc ~
#vim packages
sudo pacman -Sy gvim vim-colorsamplerpack vim-supertab vim-ultisnips vim-ultisnips colorgcc colordiff bash-completion pkgfile powerline powerline-fonts python-argparse cscope  
#yaourt -S powerline-shell-git python-powerline-gitstatus --noconfirm
sudo pkgfile --update
#git configuration
cp .gitconfig ~

#bash colors
sudo cp etc/* /etc/

#ssh configurations
cp  .ssh/* ~/.ssh/
mkdir -p ~/.ssh/connections
