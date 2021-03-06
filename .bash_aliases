# .bash_aliases
# Sourced by .bash_profile

# Easy upgrade
alias upgrade="sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y"

# Easier navigation
alias ~="cd ~" # Home
alias -- -="cd -" # Last used dir
alias tree="tree -a -I 'venv|.git'"

# Source virtualenv
alias venv="source ./venv/bin/activate"

# Weeknumber
alias week='date +%V'

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

# List all files colorized in long format
alias ll="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Always highlight grep'ed search term 
alias grep="grep --color"

# Taskwarrior aliases
#alias t="task"
#alias tl="task list"
#alias ta="task add"

# AlgoVPN (Wireguard)
alias vpnstart="sudo systemctl start wg-quick@wg0"
alias vpnstop="sudo systemctl stop wg-quick@wg0"
alias vpnstatus="sudo systemctl status wg-quick@wg0"
