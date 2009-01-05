#exports
PATH="$PATH:/sbin:/usr/sbin:/home/gogonkt/scripts:/home/gogonkt/.ies4linux/bin/:/usr/local/bin"
PAGER='less'
EDITOR='vim'

# completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# color module
autoload colors ; colors

# correction
setopt correctall

# prompt
autoload -U promptinit
promptinit
prompt gentoo

#history
export HISTSIZE=5000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history

setopt autocd
setopt extendedglob


# Aliases and functions {{{1

# Allow for use of =command to test for commands below, w/o error messages. 
setopt nomatch
 
alias df='df -hT -x none'
alias free='free -m'
alias cls=clear
# Do we have GNU ls of a new enough version for color?
(ls --help 2>/dev/null |grep -- --color=) >/dev/null && \
        alias ls='ls -b -CF --color=auto'
alias l=ls
alias ll='ls -lh'
alias la='ls -d .*'
alias ld='ls -ld *(-/DN)'
alias du='du -h'
alias dus='du -hs'
alias f=finger
alias edit=$EDITOR
alias e=$EDITOR
alias ftp=lftp
alias md=mkdir

alias j="jobs"                   # show all jobs
alias ..="cd .."                 # save 3 keystrokes...
alias diff="colordiff"           # pretty colors...
alias p="pwd"                    # more lazyness...
alias c="clear"                  # another quickie
alias sc="screen"                 # Starts screen
alias sr="screen -r"             # Screen Reattach
alias sd="screen -d"                 # Screen Detach
alias untar="tar xzfv"           # for tarballs
alias unbz2="tar xvfj"           # for .bz2 archives
alias killff="killall firefox-bin" # a grim necessity
alias grep='grep --color=auto'   # color grep
alias more="less"
alias nano="nano -w"
alias vim="vim -X"
alias man='LANG=en_US.UTF-8 man'

#alias cp='cp -i'                # Became too annoying for large copy/delete actions
##alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'                # Creates parent directories automatically

# Put alive hosts at the bottom.
alias ruptime='ruptime -rt'
alias rd=rmdir
alias k=killall
alias mtr='mtr --curses'
#[[ -x =reportbug ]] && alias bug='reportbug -b --no-check-available -x -M --mode=expert'
alias slrn='slrn -n'
alias menu=pdmenu
alias xchat='xchat -C'
alias stardate='date "+%y%m.%d/%H%M"'
#if [[ -x =ytalk ]]; then
#	alias ytalk='ytalk -x'
#	alias talk=ytalk
#fi

# I don't like the zsh builtin time command.
#[[ -x =time ]] && alias time='command time'
#alias dch="dch -p -D UNRELEASED"
alias bc='bc -l -q'
#alias ytalk='ytalk -x'

# Calculator
calc () { echo $* |bc -l }

# alias for daily use
alias gm="ssh -C gmwx.3322.org"
alias i="ssh -C gmwx.3322.org -t 'LANG=zh_CN.utf8;screen -RD gogonkt'"
alias s="screen -RD gogonkt"
alias m="wine ~/share/MultiBank\ Trader\ CN/terminal.exe 2>/dev/null&"
alias q="wine ~/.wine/drive_c/QQ/QQ.exe&>/dev/null&"
alias ie="wine ~/.wine/drive_c/Program\ Files/Internet\ Explorer/iexplore.exe&"
alias f="/opt/firefox/firefox-bin -P Forex -no-remote&"
alias vzsh="vi ~/.zshrc;source ~/.zshrc"
alias vawe="vi ~/.config/awesome/rc.lua"
alias pdf="acroread"
alias ssu="sudo su"
alias xsu="screen -t ssu sh -e 'sudo su'"
alias x="startx"
alias poeon="sudo pppoe-start"
alias xp="VBoxManage startvm xp-deep"

# Misc {{{1

# Force emacs editing mode.
bindkey -e
#[[ $TERM == "xterm" ]] && bindkey -e

# ctrl-s will no longer freeze the terminal.
#stty -ixon kill ^K
stty erase "^?"

# Turn on full-featured completion (needs 2.1) {{{2
if [[ "$ZSH_VERSION" == (3.1|4)* ]]; then
	autoload -U compinit
	compinit
	if [[ -e ~/.ssh/known_hosts ]]; then
		# Use .ssh/known_hosts for hostnames.
		hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
		zstyle ':completion:*:hosts' hosts $hosts 
	fi
fi


# Key bindings {{{1

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey '^K' kill-whole-line
bindkey -s '^L' "|less\n"		# ctrl-L pipes to less
bindkey -s '^B' " &\n"			# ctrl-B runs it in the background
bindkey "\e[1~" beginning-of-line	# Home (console)
bindkey "\e[H" beginning-of-line	# Home (xterm)
bindkey "\e[4~" end-of-line		# End (console)
bindkey "\e[F" end-of-line		# End (xterm)
bindkey "\e[2~" overwrite-mode		# Ins
bindkey "\e[3~" delete-char		# Delete
