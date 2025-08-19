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
# Prompt
# =====================================================================

# Function to show current git branch
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# %n = username, %m = hostname, %* = time, %~ = cwd, $(parse_git_branch) = git branch
if [[ $EUID == 0 ]]; then
    # Root prompt in red/magenta
    PROMPT='%F{magenta}%B[ZSH]%b%f  %B%F{red}%n@%m%f %F{magenta}[%*]%f %F{white}%~%f%b
$> '
else
    # Normal user prompt in green/yellow + git branch
    PROMPT='%F{magenta}%B[ZSH]%b%f  %F{green}%n@%m%f %F{magenta}[%*]%f %B%F{yellow}%~%f%b%F{red}$(parse_git_branch)%f
$> '
fi

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

# =====================================================================
# Environment variables
# =====================================================================

. "$HOME/.cargo/env"            # Load Rust cargo environment

export PATH=/usr/local/texlive/2024/bin/x86_64-linux/:$PATH  # TeXLive
export PATH=$PATH:/usr/local/go/bin                          # Go
export PATH=$PATH:$(go env GOPATH)/bin                       # Go workspace
