# export GOROOT=/srv/go
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:~/dotfiles/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export GOPATH=/srv/gopath
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_45.jdk/Contents/Home/jre
export M2_HOME=/srv/maven
export PATH=$M2_HOME/bin:$PATH

ssh-add ~/.ssh/id_rsa

# export GOROOT=/usr/local/Cellar/go/1.2
# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"  # you need -- before you define -
alias ll="ls -lh"

# unicore
# alias ustart="nohup bundle exec unicorn_rails -c config/unicorn.conf.rb > ./log/unicorn.log &"
# alias ustop="kill -9 `cat tmp/pids/unicorn.pid` ; rm -f tmp/pids/unicorn.pid"
# goc go in current dir
alias go="GOPATH=`pwd` go"

# sudo
# redo prew command use sudo 
alias sure="sudo !!"

# linode 
alias linc='ssh -t weizhao@lish-tokyo.linode.com main'
alias sock5='ssh lint -N -f &'
alias sock6='ssh bjt -N -f &'

# Manage dotfiles
alias er="source ~/.bash_profile"   # reload bash profile
alias eedit="mate ~/dotfiles && mate ~/dotfiles/aliases.sh"

# source tree
alias str='open -a SourceTree ' 

# sublime tools
alias sp="cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/"

alias edhost="sudo mate /etc/hosts"

# description rails db
alias desdb="cd ~/dev/description"
#rm
alias rmf="rm -f "
alias rmrf="rm -rf "
# svn
alias sup="svn up "
alias sst="svn st "
alias sci="svn ci -m "
alias sco="svn co "
alias svnd="svn co "
alias sadde="svn propset svn:executable on "
alias sic="svn propset svn:ignore \"*\" ."
alias si="svn propset svn:ignore "
alias se="svn propedit svn:ignore ."
alias sq="svn ci -m \"quick fix\" "
alias sinfo="svn info"
alias sug="svn upgrade"
alias surl="svn info | grep URL | awk {'print $2'}"
alias svng="svn log --stop-on-copy "
alias slog="svng -l 20|svn-slog"
# do not work
alias svnaddall="svn st | awk '{if ( $1 == \"?\") { print $2}}' | xargs svn add"

# redis
alias redisstart='sudo launchctl start io.redis.redis-server'
alias redisstop='sudo launchctl stop io.redis.redis-server'

# python
alias py='python'

# rvm
alias r21="rvm use 2.1"
alias r2="rvm use 2.0.0"
alias r19="rvm 1.9.3"
alias ree="rvm ree"

# rails
alias rec="rake pry:run"
alias epry="bundle exec pry"
alias migrate="bundle exec rake db:migrate"

# git
alias gc="git clone "
alias ga="git add . "
alias gc1="git clone --depth 1 "
alias gs="git status"
alias gq="git commit -a -m \"quick fix\""
alias gci="git commit -a -m "
alias gps="git push"
alias gpl="git pull"
alias giturl="git remote show origin"
alias gitl="git config --get remote.origin.url"
# I allway make a mistake to type this 
alias gti="git "
alias gst='git status'


# sysctl
alias symsl="sysctl net.inet.tcp.msl"
alias symslt="sudo sysctl -w net.inet.tcp.msl=1000"  #net.inet.tcp.msl: 15000 -> 1000
alias symslr="sudo sysctl -w net.inet.tcp.msl=15000"  #net.inet.tcp.msl: 1000 -> 15000

# rails 
alias mg="rake db:migration"
alias rt="touch tmp/restart.txt"
alias tl="tail -f log/development.log"
alias tlp="tail -f log/production.log"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dw="cd ~/work"
alias work="cd ~/work"
alias dev="cd ~/dev"
alias ror="cd /srv/rorapps"
alias p="cd ~/Projects"
alias odown="open ~/Downloads"
alias g="git"
alias h="history"
alias pg='ps -ef| grep '
# alias j="jobs"
alias v="vim"
alias m="mate ."
alias s="subl ."
alias o="open"
alias oo="open ."
alias movie="cd /Users/azhao/work/movie"
alias mbj="cd /Users/azhao/work/movie/bja2"
alias mbjv="cd /Users/azhao/work/movie/bjv1"
alias mtrunk="cd /Users/azhao/work/movie/trunk"
alias tdc="cd /Users/azhao/work/movie/bja2/ticket_data_center"
alias ttdc="cd /Users/azhao/work/movie/trunk/ticket_data_center"
alias tailf="tail -f "
# ruby 
alias me='magic_encoding'

# current work 
alias toc="cd /srv/rorapps/toc"
alias fgcc="cd /srv/rorapps/fgcc"
alias be="bundle exec "
alias ot="open http://toc.dev"
alias rmovie="cd /srv/rorapps/rmovie"
alias or="open http://rmovie.dev"
# open glass on localhost
alias ogjava="open -a firefox https://localhost:4850"
alias chfs="cd /Users/azhao/work/huafei/statistic"
alias hf="cd /Users/azhao/work/huafei"
alias r7d="cd /srv/go/src/github.com/azhao1981/route7"
# ssh config
alias sshc='subl ~/.ssh/config'


# admin command
alias ng="netstat -na| grep "
alias psg="ps aux | grep "

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd='ls -lF ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Gzip-enabled `curl`
alias gurl='curl --compressed'

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# Make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"
