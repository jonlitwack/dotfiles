# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
ZSH_CUSTOM=$HOME/.oh-my-zsh/oh-my-zsh-custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias tmux="TERM=screen-256color-bce tmux -2"
alias nvim="NVIM_TUI_ENABLE_TRUE_COLOR=1  nvim"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

#Added this in to remove the annoying pre-text at the prompt
DEFAULT_USER=jonlitwack

# Set CLICOLOR if you want Ansi Colors in iTerm2
#export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
# Turning this off for now: export TERM=xterm-256color
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git node)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin
alias ls='ls -G'
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH
export PATH=/usr/local/bin:$PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.dotfiles/lib/zsh-autoenv/autoenv.zsh
