#!/bin/bash
# Script para restaurar a configuração do Neovim a partir do repositório DotFiles

# Diretórios:
DOTFILES_DIR="$HOME/DotFiles"         # Caminho onde o repositório DotFiles será (ou está) clonado
NVIM_CONFIG_DEST="$HOME/.config/nvim"   # Local onde a configuração do Neovim será restaurada

echo "Restaurando configurações do Neovim..."
# Cria o diretório de destino se não existir e copia os arquivos do backup para ele
mkdir -p "$NVIM_CONFIG_DEST"
rsync -av --delete "$DOTFILES_DIR/nvim/" "$NVIM_CONFIG_DEST/"

echo "Configurações do Neovim restauradas com sucesso!"

