# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Se estiver usando Oh My Zsh:
export ZSH="$HOME/.oh-my-zsh"

# Defina o tema para powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Lista de plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Outras customizações do powerlevel10k (opcional)
# O assistente de configuração do powerlevel10k pode ser iniciado com:
# p10k configure

# Exemplo de customização para o zsh-autosuggestions:
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Caso queira ajustar o comportamento do zsh-syntax-highlighting, pode configurar aqui.

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
