# ~~~~~~~~~~~~~~~~~~~~
# Fish configuration
# github: https://github.com/jerryharim
# ~~~~~~~~~~~~~~~~~~~~


## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# set -x XDG_RUNTIME_DIR /var/run/user/(id -u) : used by pipewire si je ne me trompe pas

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
#if status --is-interactive
#   source ("/usr/bin/starship" init fish --print-full-init | psub)
#end

# ~~~~~~~~~~~~~~~~~~~~
# Function
# ~~~~~~~~~~~~~~~~~~~~

# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function pretty_csv
  cat "$argv[1]" | perl -pe 's/((?<=,)|(?<=^)),/ ,/g;' | column -t -s, | less -S
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


# ~~~~~~~~~~~~~~~~~
# Alias
# ~~~~~~~~~~~~~~~~~

alias noh="builtin history clear" # clear history

# O.S
alias sx="startx"
alias suspend='loginctl suspend'
alias reboot='loginctl reboot'
alias off='loginctl poweroff'
alias dmesg="dmesg --color=always "

# tools
alias running_services='systemctl --type=service --state=running'

# Dotfiles
alias dotfiles='git --git-dir=/mnt/store/customization/dotfiles-main/ --work-tree=$HOME '
alias dts='dotfiles status'
alias git-nvim="git --git-dir=$HOME/nvim-mark2/ --work-tree=$HOME/.config/nvim/ "

# Todoist
alias td="todoist-cli --color"
alias tdl="td list"

# brightness
alias sbls="sudo brightnessctl -s s "
alias sbj="sudo brightnessctl -s s 15%" 
alias sbk="sudo brightnessctl -s s 50%" 
alias sbl="sudo brightnessctl -s s 75%" 
alias sbm="sudo brightnessctl -s s 100%" 

# systemctl
alias mask="sudo systemctl mask "
alias unmask="sudo systemctl unmask "
alias start="sudo systemctl start "


# CODE
# ------

# Git
alias gs='git status'
alias gl='git lg'

# neovide
alias nv='neovide'



# Replace some more things with better alternatives
# -------------------------------------------------

# Replace ls with EXA
#alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
#alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
#alias ll='exa -l --color=always --group-directories-first --icons'  # long format
#alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
#alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"

# Replace cat with BAT 
alias cat='bat --style header --style rule --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru --bottomup'


# Common use
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions && sudo updatedb && sudo -H DIFFPROG=meld pacdiff'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB (expac must be installed)
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages

# Get fastest mirrors 
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" 
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist" 
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist" 
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist" 

# Help people new to Arch
alias helpme='cht.sh --shell'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# mount and unmount
alias mount='udisksctl mount -b '
alias unmount='udisksctl unmount -b '

# bluetooth
alias start_bluetooth='sudo systemctl start bluetooth'

# networking
alias restart_nm='sudo systemctl restart NetworkManager'
alias wifi="nmcli d wifi"

# BLENDER
alias blend='LIBGL_ALWAYS_SOFTWARE=1 blender'

# Zellij
alias zn="zellij"
alias zl="zellij list-sessions"
alias za="zellij attach"
alias zf="zellij -s free"



## Import colorscheme from 'wal' asynchronously
#if type "wal" >> /dev/null 2>&1
#   cat ~/.cache/wal/sequences
#end


## Run paleofetch if session is interactive
#if status --is-interactive
#   paleofetch
#end

# vim like
fish_vi_key_bindings
# fish_default_key_bindings


# ~~~~~~~~~~~~~~~~~~~~
# Key binding
# ~~~~~~~~~~~~~~~~~~~~

bind \ett peco_todoist_item
bind \etp peco_todoist_project
bind \etl peco_todoist_labels
bind \etc peco_todoist_close
bind \etd peco_todoist_delete


# ~~~~~~~~~~~~~~~~~~~~
# Environement
# ~~~~~~~~~~~~~~~~~~~~

set -x EDITOR (which nvim)
set -U fish_user_paths ~/.local/bin $fish_user_paths

# ~~~~~~~~~~~~~~~~~~~~
# Colorscheme
# ~~~~~~~~~~~~~~~~~~~~

# TokyoNight Color Palette
# -----------------------
set -l foreground c0caf5
set -l selection 33467C
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
    
# ~/.config/fish/config.fish

starship init fish | source

