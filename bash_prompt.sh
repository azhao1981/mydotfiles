export CLICOLOR=1
export LSCOLORS=gxfxaxdxcxegedabagacad
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)$(parse_git_dirty)/"
}
function ruby_version() {
  # cat ~/.rbenv/version 2> /dev/null
  rbenv version | awk '{print $1}'
}
c_1="\[\e[0m\]"
c0="\[\e[30m\]"
c1="\[\e[31m\033[1m\]"
c2="\[\e[32m\033[1m\]"
c3="\[\e[33m\]"
c4="\[\e[34m\]"
c5="\[\e[35m\]"
c6="\[\e[36m\]"
c7="\[\e[37m\]"

PS1="$c1\u@\h $c2\w $c3\$(ruby_version) $c1\$(parse_git_branch)\n$c_1$ "

# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# PS1="$c1 \u: $c2\w $c3(\$(ruby_version)) $c1\$(parse_git_branch) \n$c_1~ "

