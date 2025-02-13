#!/bin/bash
# Script para fazer backup da configuração do Neovim (exceto pastas desnecessárias) no repositório DotFiles

# Diretórios:
DOTFILES_DIR="$HOME/DotFiles"         # Caminho do seu repositório DotFiles
NVIM_CONFIG_SRC="$HOME/.config/nvim"    # Diretório de configuração do Neovim
BACKUP_DEST="$DOTFILES_DIR/nvim"        # Local onde a configuração será armazenada no DotFiles

# Verifica se o repositório DotFiles existe
if [ ! -d "$DOTFILES_DIR/.git" ]; then
  echo "Repositório DotFiles não encontrado em $DOTFILES_DIR."
  echo "Certifique-se de ter clonado seu repositório DotFiles."
  exit 1
fi

# Cria o diretório de backup, se necessário
mkdir -p "$BACKUP_DEST"

echo "Copiando configurações do Neovim para o repositório DotFiles..."
# Copia usando rsync, excluindo as pastas 'bundle' e 'undo'
rsync -av --delete --exclude='bundle' --exclude='undo' "$NVIM_CONFIG_SRC/" "$BACKUP_DEST/"

# Navega até o repositório e realiza commit e push
cd "$DOTFILES_DIR" || exit
git add nvim
git commit -m "Backup das configurações do Neovim (exceto bundle e undo) - $(date)"
git push

echo "Backup concluído com sucesso!"

