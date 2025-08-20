# =====================================================================
# Oh my zsh
# =====================================================================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="jonathan2"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 5

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# =====================================================================
# SSH Agent & Key Auto-Load
# =====================================================================

# Start ssh-agent if not already running
if [[ -z "$SSH_AUTH_SOCK" ]] ; then
  eval "$(ssh-agent -s)" > /dev/null
fi

# List of SSH keys to load
ssh_keys=(
  ~/.ssh/id_rsa
)

eval $(keychain --eval --quiet $ssh_keys)

# =====================================================================
# History configuration
# =====================================================================

HISTFILE=~/.zsh_history        # File where command history is saved
HISTSIZE=100000                # Number of history lines kept in memory
SAVEHIST=200000                # Number of history lines saved to file

setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate commands from history
setopt APPEND_HISTORY          # Append history lines instead of overwriting the file
setopt HIST_IGNORE_SPACE       # Do not record commands starting with a space
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks from history lines
setopt HIST_FIND_NO_DUPS       # Prevent duplicate matches when searching history

# =====================================================================
# Shell behavior
# =====================================================================

setopt BEEP                    # Beep on errors (may be annoying, disable if unwanted)
setopt EXTENDED_GLOB           # Enable advanced globbing operators (#, ~, ^, etc.)
setopt NOMATCH                 # Show error if a glob pattern has no matches
setopt NOTIFY                  # Notify when background jobs finish

setopt SHARE_HISTORY           # Share history across multiple shells
setopt INC_APPEND_HISTORY      # Immediately append commands to the history file

setopt AUTO_PUSHD              # Automatically push old dir onto stack when using cd
setopt CDABLE_VARS             # Allow `cd varname` if varname is set as a path
unsetopt AUTO_CD               # Require explicit "cd" command (avoid accidental cd)

setopt AUTO_LIST               # List choices when tab-completion has multiple matches
setopt PROMPT_SUBST            # Allow command substitution in the prompt string

# =====================================================================
# Completion system
# =====================================================================

autoload -Uz compinit          # Load completion system
compinit

# Enable interactive completion menu when multiple choices are available
zstyle ':completion:*' menu select

# =====================================================================
# Aliases
# =====================================================================

alias l='ls --color'           # List files, simple
alias ls='ls -A --color'       # List all except . and ..
alias ll='ls -Al --color'      # Detailed list with hidden files
alias ..='cd ..'               # Quick change to parent dir
alias grep='grep --color=always -nI'  # Grep with colors and line numbers
alias gr='grep'                # Shortcut for grep
alias ack='ack --color'        # Ack with colors
alias alert='notify-send --urgency=low -i "$( [ $? = 0 ] && echo terminal || echo error )" "$(history | tail -n1 | sed -E "s/^[[:space:]]*[0-9]+[[:space:]]*//; s/[;&|][[:space:]]*alert\$//")"'
                               # Desktop notification for long-running commands
alias dirs='dirs -v'           # Show directory stack in numbered format

# =====================================================================
# Functions
# =====================================================================

# Create a temporary directory and cd into it
ncd() {
    cd "$(mktemp -d /tmp/${1}XXXXX)"
}

# Show which package installed a command
who-installed() {
    dpkg -S "$(command -v "$1")"
}

# ------------------------------------
# Interactive directory stack selector
# ------------------------------------

# Function to jump to a directory from stack
bd() {
    local choice
    if [[ -n $1 ]]; then
        # Expand tilde and cd
        cd "${1/#\~/$HOME}" || echo "Directory not found: $1"
    else
        # Build directory stack without numbers
        local dirs_list
        dirs_list=("${(@f)$(dirs -v | awk '{$1=""; print substr($0,2)}')}")
        # Interactive selection using fzf (or your choice)
        choice=$(printf "%s\n" "${dirs_list[@]}" | fzf --height 10 --reverse --prompt="Select dir> ")
        [[ -n $choice ]] && cd "${choice/#\~/$HOME}"
    fi
}

# Function to list directories in the stack
_bd_menu() {
    # Get the list of directories from 'dirs -v'
    local dirs_list
    # Remove the index numbers from dirs -v output
    dirs_list=("${(@f)$(dirs -v | awk '{$1=""; print substr($0,2)}')}")
    # Provide completions for bd
    compadd -U -M 'r:|=0' -- "${dirs_list[@]}"
}

# Enable menu selection style for bd
zstyle ':completion:*:bd:*' menu select

# Associate _bd_menu function with bd command
compdef _bd_menu bd

# =====================================================================
# Environment variables
# =====================================================================

. "$HOME/.cargo/env"            # Load Rust cargo environment

export PATH=/usr/local/texlive/2024/bin/x86_64-linux/:$PATH  # TeXLive
export PATH=$PATH:/usr/local/go/bin                          # Go
export PATH=$PATH:$(go env GOPATH)/bin                       # Go workspace
export PATH="$HOME/.local/bin:$PATH"
