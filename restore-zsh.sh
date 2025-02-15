#!/bin/bash
# restore_dotfiles.sh
# Script para recuperar a configuração do Zsh a partir do repositório DotFiles
# e instalar o Zsh, Oh My Zsh, Powerlevel10k e plugins necessários.

# --- Variáveis de configuração ---
DOTFILES_REPO_URL="https://github.com/seu_usuario/DotFiles.git"  # Substitua com seu URL
DOTFILES_DIR="$HOME/DotFiles"

# Atualiza os repositórios e instala zsh e git (caso não estejam instalados)
sudo pacman -Syu --noconfirm zsh git curl bat

# Clona o repositório DotFiles, se ainda não existir
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
else
    echo "Repositório DotFiles já existe. Atualizando..."
    cd "$DOTFILES_DIR" && git pull
fi

# Copia as configurações para o diretório home
cp "$DOTFILES_DIR/.zshrc" "$HOME/"
cp "$DOTFILES_DIR/.p10k.zsh" "$HOME/"

echo "Configurações copiadas para $HOME."

# Instala o Oh My Zsh se não estiver instalado
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Define a variável de customização do Oh My Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Instala o tema Powerlevel10k (caso não exista)
if [ ! -d "${ZSH_CUSTOM}/themes/powerlevel10k" ]; then
    echo "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
fi

# Instala o plugin zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    echo "Instalando zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi

# Instala o plugin zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    echo "Instalando zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
fi

# Altera o shell padrão para zsh, se ainda não for
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Alterando shell padrão para zsh..."
    chsh -s "$(which zsh)"
fi

echo "Recuperação concluída com sucesso! Reinicie o terminal para as alterações entrarem em vigor."

