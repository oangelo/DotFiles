#!/bin/bash
# Script para restaurar a configuração do Neovim a partir do repositório DotFiles

# Diretórios:
DOTFILES_DIR="$HOME/DotFiles"         # Caminho onde o repositório DotFiles será (ou está) clonado
NVIM_CONFIG_DEST="$HOME/.config/nvim"   # Local onde a configuração do Neovim será restaurada

echo "Restaurando configurações do Neovim..."
# Cria o diretório de destino se não existir e copia os arquivos do backup para ele
mkdir -p "$NVIM_CONFIG_DEST"
rsync -av --delete "$DOTFILES_DIR/nvim/" "$NVIM_CONFIG_DEST/"

# Instala o parser de HTML com nvim-treesitter, se ainda não estiver instalado
nvim --headless +TSInstall\ html +qall

echo "Configurações do Neovim restauradas com sucesso!"

