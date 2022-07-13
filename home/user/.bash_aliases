## Make sure that code appears in your ~/.bashrc file:
#
# if [ -e $HOME/.bash_aliases ]; then
#     source $HOME/.bash_aliases
# fi
#
## OR from Ubuntu
#
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi
#
## TO UPDATE:
# source ~/.bash_aliases
#
# . ~/.bashrc
#
# alias edit=vim
# alias edit=nano
# alias edit=gedit
#

### ALIASES ###

alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'

## Not work. Need a Bash function to pass a parameter !
# alias mkcd='mkdir -p -- "$1" && cd -- "$1"'

## Clear the screen. Or just Ctrl + L
alias c='clear'

# Changing "ls" to "exa"
# alias ll='ls -alF'
# covered because ll = exa occuiped
alias l='ls -alF'
alias ltt='ls --human-readable --size -1 -S --classify'
## MacOS / BSD
# alias lt='du -sh * | sort -h'
# alias ll='exa -alF'
#
alias ll='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ls='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

alias cat='bat'

# broot
alias br='br -dhp'
alias bs='br --sizes'

# adding flags
alias cp='cp -i'	# confirm before overwriting!
alias df='df -h'	# human-readable sizes
# alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss'

alias gh='history | grep '
alias left='ls -t -1'
alias count='find . -type f | wc -l'

# alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias mnt2='mount | grep -E ^/dev | column -t'

## Decompress
alias untar='tar -zxvf '

## Resume downloads
# alias wget='wget -C '

## Python
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

## Remove for recoverable
alias tcn='mv --force -t ~/.local/share/Trash'

## Copy with progress bar
alias cpv='rsync -ah --info=progress2'

## Simplify your Git workflow here ?

## install colordiff package :)
# alias diff='colordiff'

# alias h='history | less'
# alias j='jobs -l'

## Debian / Ubuntu and friends
# install with apt-get
# alias apt-get='sudo apt-get '
# alias updatey='sudo apt --yes '
# update on one command
alias update='sudo apt update && sudo apt upgrade'

## Pass reboot / halt / poweroff via sudo
# alias reboot='sudo /sbin/reboot'
# alias poweroff='sudo /sbin/poweroff'
# alias halt='sudo /sbin/halt'
# alias shutdown='sudo /sbin/shutdown'

alias ports='netstat -tulanp'

## shortcut  for iptables and pass it via sudo
alias ipt='sudo /sbin/iptables'

## display all rules
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

alias getpass='openssl rand -base64 20'
alias sha='shasum -a 256 '
#alias sha='sha256sum'
alias ping='ping -c 5'

alias speed='speedtest-cli --simple'
alias speeds='speedtest-cli --server 28431'

## IP external
alias ipe='curl ipinfo.io/ip ; echo'
# alias ipe2='curl -s https://checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'

## IP internal
## Ubuntu
alias ipi='hostname -I'
## MacOS
# alias ipi='ifconfig getifaddr en0'

alias psg='ps auwx | grep '

## ODP projects
alias tail_domain1='tail -f -n1000 $HOME/data/project/danut/payara5/glassfish/domains/domain1/logs/server.log'
alias tail_admincore='tail -f -n1000 $HOME/data/project/danut/payara5/glassfish/domains/admincore/logs/server.log'
