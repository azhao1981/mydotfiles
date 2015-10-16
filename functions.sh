code () {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        open -a "Visual Studio Code" --args "$F"
    fi
}

# 打印文件的绝对路径
prp() {
    if [ $# -eq 0 ]; then
        perr 'usage: abs_path pname ...'
        return $(false)
    fi

    while [ $# -gt 0 ]; do
        pname=$1
        if [ -d "$pname" ]; then
            echo `cd "$pname" && pwd`
        else
            echo `cd $(dirname "$pname") && echo $PWD/$(basename "$pname")`
        fi
        shift
    done

    unset pname
    return $(true)
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
    git diff
    git commit -a -m "$@"
    git push
  }
  function rco() {
    git pull
    git rebase
  }
fi


# Compare original and gzipped file size
function gz() {
  local origsize=$(wc -c < "$1")
  local gzipsize=$(gzip -c "$1" | wc -c)
  local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
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

# All the dig info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
  printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo # newline
  fi
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo # newline
  fi
}

# Get a character’s Unicode code point
function codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo # newline
  fi
}

function svn
{
  # rebuild args to get quotes right
  CMD=
  for i in "$@"
  do
    if [[ "$i" =~ \  ]]
    then
      CMD="$CMD \"$i\""
    else
      CMD="$CMD $i"
    fi
  done

  # pad with spaces to strip --nocol
  CMD=" $CMD "
  CMDLEN=${#CMD}

  # parse disabling arg
  CMD="${CMD/ --nocol / }"

  # check if disabled
  test "$CMDLEN" = "${#CMD}"
  NOCOL=$?
  if [ "$SVN_COLOR" != "always" ] && ( [ $NOCOL = 1 ] || [ "$SVN_COLOR" = "never" ] || [ ! -t 1 ] )
  then
    eval $(which svn) $CMD
    return
  fi

  # supported svn actions for "status-like" output
  ACTIONS="add|checkout|co|cp|del|export|remove|rm|st"
  ACTIONS="$ACTIONS|merge|mkdir|move|mv|ren|sw|up"

  # actions that outputs "status-like" data
  if [[ "$1" =~ ^($ACTIONS) ]]
  then
    eval $(which svn) $CMD | while IFS= read -r RL
    do
      if   [[ $RL =~ ^\ ?M ]]; then C="\033[34m";
      elif [[ $RL =~ ^\ ?C ]]; then C="\033[41m\033[37m\033[1m";
      elif [[ $RL =~ ^A ]]; then C="\033[32m\033[1m";
      elif [[ $RL =~ ^D ]]; then C="\033[31m\033[1m";
      elif [[ $RL =~ ^X ]]; then C="\033[37m";
      elif [[ $RL =~ ^! ]]; then C="\033[43m\033[37m\033[1m";
      elif [[ $RL =~ ^I ]]; then C="\033[33m";
      elif [[ $RL =~ ^R ]]; then C="\033[35m";
      else C=
      fi

      echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
    done

  # actions that outputs "diff-like" data
  elif [[ "$1" =~ ^diff ]]
  then
    eval $(which svn) $CMD | while IFS= read -r RL
    do
      if   [[ $RL =~ ^Index:\  ]]; then C="\033[34m\033[1m";
      elif [[ $RL =~ ^@@ ]]; then C="\033[37m";

      # removed
      elif [[ $RL =~ ^-\<\<\< ]]; then C="\033[31m\033[1m";
      elif [[ $RL =~ ^-\>\>\> ]]; then C="\033[31m\033[1m";
      elif [[ $RL =~ ^-=== ]]; then C="\033[31m\033[1m";
      elif [[ $RL =~ ^- ]]; then C="\033[31m";

      # added
      elif [[ $RL =~ ^\+\<\<\< ]]; then C="\033[32m\033[1m";
      elif [[ $RL =~ ^\+\>\>\> ]]; then C="\033[32m\033[1m";
      elif [[ $RL =~ ^\+=== ]]; then C="\033[32m\033[1m";
      elif [[ $RL =~ ^\+ ]]; then C="\033[32m";

      else C=
      fi

      echo -e "$C${RL/\\/\\\\}\033[0m\033[0;0m"
    done
  else
    eval $(which svn) $CMD
  fi
}
