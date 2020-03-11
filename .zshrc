setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt AUTO_PARAM_KEYS
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST
setopt share_history
setopt noflowcontrol

#fpath=(~/.zsh/functions/Completion ${fpath})
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -Uz compinit; compinit
autoload -U colors
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=100000
bindkey -e

#display git branch
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}


#PROMPT='%{[36m%}%m[%n]$ %{[m%}'
#PROMPT='%{[36m%}dev[%n]%1v$ %{[m%}'
PROMPT='%6Fdev[%n]%f%6F%1v%f%6F$ %f'


#PROMPT=$'%2Fdev[%n]%f %3F%~%f%1v% %$ '

RPROMPT='%{[36m%}%~%{[m%}'

# path
export PATH="/usr/local/opt:/usr/local/bin:$PATH"


# php
# export PATH=/usr/local/php5/bin:$PATH
# export PATH="$(brew --prefix homebrew/php/php72)/bin:$PATH"
export PATH=/usr/local/opt/php/bin:$PATH

# composer
export PATH="/Users/taketani/bin:/Users/taketani/.composer/vendor/bin:$PATH"

# scala 
export SCALA_HOME="$HOME/bin/scala"
export PATH="$PATH:/$SCALA_HOME/bin"
export PATH="$PATH:/$HOME/bin/activator-minimal"

# go
export GOPATH="$HOME/opt/go"
export PATH="/usr/local/go/bin:$PATH"

# empbulk
export PATH="$HOME/.embulk/bin:$PATH"

export LESS='-R'
export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'

alias ls="ls -F"
alias gitdiff="git diff -p --color | diff-highlight | less"
alias dcc="docker-compose"

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>="

# php-env
#export PATH="/home/hoge/.phpenv/bin:$PATH"
#eval "$(phpenv init -)"

#node npm
export NVM_DIR=$HOME/.nvm
export PATH=$PATH:$HOME/bin:/usr/lib/fluent/ruby/bin

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/shims:${PATH} && \
  eval "$(rbenv init -)"

# chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# openssl
export PATH="/usr/local/Cellar/openssl/1.0.2q/bin:$PATH"

# history search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

test -f $NVM_DIR/nvm.sh && source $NVM_DIR/nvm.sh

if [ "$TERM" = "screen" ]; then
    chpwd () { echo -n "_`dirs`\\" }
    preexec() {
        # see [zsh-workers:13180]
        # http://www.zsh.org/mla/workers/2000/msg03993.html
        emulate -L zsh
        local -a cmd; cmd=(${(z)2})
        case $cmd[1] in
            fg)
                if (( $#cmd == 1 )); then
                    cmd=(builtin jobs -l %+)
                else
                    cmd=(builtin jobs -l $cmd[2])
                fi
                ;;
            %*)
                cmd=(builtin jobs -l $cmd[1])
                ;;
            cd)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            lv)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            less)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            vi)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            vim)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            agvim)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            yssh)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            ssh)
                if (( $#cmd == 2)); then
                    cmd[1]=$cmd[2]
                fi
                ;&
            *)
                echo -n "k$cmd[1]:t\\"
                return
                ;;
        esac

        local -A jt; jt=(${(kv)jobtexts})

        $cmd >>(read num rest
            cmd=(${(z)${(e):-\$jt$num}})
            echo -n "k$cmd[1]:t\\") 2>/dev/null
    }
    chpwd
fi

# The next line updates PATH for the Google Cloud SDK.
#source '/Users/taketani/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
#source '/Users/taketani/google-cloud-sdk/completion.zsh.inc'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/taketani/bin/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/taketani/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taketani/bin/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/taketani/bin/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ -f /Users/taketani/.travis/travis.sh ] && source /Users/taketani/.travis/travis.sh
