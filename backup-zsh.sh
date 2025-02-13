#!/bin/bash
# backup_dotfiles.sh
# Script para salvar as configurações do Zsh e do Powerlevel10k no repositório DotFiles

# Defina o diretório do repositório DotFiles
DOTFILES_DIR="$HOME/DotFiles"

# Verifica se o diretório do DotFiles existe
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Diretório DotFiles não encontrado em $DOTFILES_DIR."
    echo "Certifique-se de que o repositório foi clonado."
    exit 1
fi

# Lista de arquivos a serem copiados
ARQUIVOS=("$HOME/.zshrc" "$HOME/.p10k.zsh")

# Copia os arquivos para o repositório
for arquivo in "${ARQUIVOS[@]}"; do
    if [ -f "$arquivo" ]; then
        cp "$arquivo" "$DOTFILES_DIR/"
        echo "Copiado $(basename "$arquivo") para o repositório."
    else
        echo "Arquivo $arquivo não encontrado, ignorando..."
    fi
done

# Realiza commit e push das alterações
cd "$DOTFILES_DIR" || exit
git add .
git commit -m "Backup das configurações do Zsh e Powerlevel10k - $(date)"
git push origin main  # ou 'master', dependendo da branch principal

echo "Backup concluído com sucesso!"

