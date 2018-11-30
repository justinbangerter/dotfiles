# If not running interactively, don't do anything
case "$-" in *i*) ;; *) return;; esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f /usr/bin/mint-fortune ]; then /usr/bin/mint-fortune; fi
command -v ssh-add >/dev/null 2>&1 && ssh-add -l >/dev/null || echo "No Agent Identities"
source /usr/share/chruby/chruby.sh
chruby ruby-2.4.1
source /usr/share/chruby/auto.sh
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/share/gem_home/gem_home.sh
fi
