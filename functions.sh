deploy() {
  bundle exec cap $1 deploy
}

xbrew() {
	HOMEBREW_NO_AUTO_UPDATE=true brew $@ -vvv
}

ssht() {
set -x \
  & ssh $1 -C -f -N -g &
}

docker_env() {
  bash --login '/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
}
es_start () {
  # sudo elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml  -XX:-UseSuperWord -Xmx50m -Xms10m -d
  cd ~/udesk/elasticSearch
  docker_env 
  ~/udesk/elasticSearch/elasticsearch-ik-docker/start_es.sh
}

llp () {
  `pwd`/
}

kp () {
  ps aux | grep $1 | grep -v grep
  echo "Kill them all!!!!!!"
  kill -9 $(ps aux | grep $1 | grep -v grep | awk '{print $2}')
}


pzt(){
  OPTS=""
  if [ $# = 2 ]; then
    # OPTS="TESTOPTS=\"--name=test_$2\""
	OPTS="-n test_$2"
  fi
  echo "zeus test $1 $OPTS"
  zeus test $1 $OPTS
}

rt(){
  OPTS=""
  if [ $# = 2 ]; then
    # OPTS="TESTOPTS=\"--name=test_$2\""
	OPTS="-n test_$2"
  fi
  echo "./bin/rails test $1 $OPTS"
  ./bin/rails test $1 $OPTS
}

rtest(){
  OPTS=""
  if [ $# = 2 ]; then
    OPTS="TESTOPTS=\"--name=test_$2\""
  fi
  echo "./bin/rake test $1 $OPTS"
  ./bin/rake test $1 $OPTS
}

rtest5(){
  OPTS=""
  if [ $# = 2 ]; then
    OPTS="TESTOPTS=\"--name=test_$2\""
  fi
  echo "./bin/rails test $1 $OPTS"
  ./bin/rails test $1 $OPTS
}

rrun(){
  echo "./bin/rails runner $@"
  ./bin/rails runner $@
}

udesk(){
	if [[ $# = 0 ]]; then
		cd ~/udesk
	else
		cd ~/udesk/udesk_$1		
	fi
}

# py2(){
#   source ~/.py2/bin/activate
# }
# py3(){
#   source ~/.py3/bin/activate
# }
code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}
# Simple calculator
function calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
        -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//'   # remove trailing zeros
  else
    printf "$result"
  fi
  printf "\n"
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# Create a new file and enter it
function mkf() {
  touch "$@" && subl "$@" &
}

# Change working directory to the top-most Finder window location
function cdf() { # short for `cdfinder`
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
function targz() {
  local tmpFile="${@%/}.tar"
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  )

  local cmd=""
  if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli"
  else
    if hash pigz 2> /dev/null; then
      cmd="pigz"
    else
      cmd="gzip"
    fi
  fi

  echo "Compressing .tar using \`${cmd}\`…"
  "${cmd}" -v "${tmpFile}" || return 1
  [ -f "${tmpFile}" ] && rm "${tmpFile}"
  echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
  function diff() {
    git diff --no-index --color-words "$@"
  }
  function rsave() {
	git diff --color  | /usr/local/bin/diff-so-fancy
    git commit -a -m "$@"
    git push
  }
  function rco() {
    git pull
    git rebase
  }
  function gitff() {
    git merge --ff-only origin/`git name-rev --name-only HEAD`
  }
fi

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
function gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}


# Install Grunt plugins and add them as `devDependencies` to `package.json`
# Usage: `gi contrib-watch contrib-uglify zopfli`
function gi() {
  local IFS=,
  eval npm install --save-dev grunt-{"$*"}
}
