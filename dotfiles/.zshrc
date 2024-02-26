# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/home/dudihazazi/.spicetify:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# powerlevel10k styling
ZLE_RPROMPT_INDENT=0

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Example aliases
alias bashconfig="micro ~/.bashrc"
alias zshconfig="micro ~/.zshrc"
alias p10kconfig="micro ~/.p10k.zsh"

# functions
function dotfilesBackup ()
{
	cp ~/.bashrc ~/Documents/codes/setup/dotfiles/
	cp ~/.zshrc ~/Documents/codes/setup/dotfiles/
	cp ~/.p10k.zsh ~/Documents/codes/setup/dotfiles/
	cp ~/.gitconfig ~/Documents/codes/setup/dotfiles/
}

# fnm
export PATH="/home/dudihazazi/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dudihazazi/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dudihazazi/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dudihazazi/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dudihazazi/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
