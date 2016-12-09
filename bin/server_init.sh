#!/bin/bash 
# init a remote server ssh server 
if [[ $# = 0 ]]; then
  echo "need server name"
  echo "uage: server_init udxxx"
  exit 0
fi
ssh $1 "set -x \
    && mkdir -p ~/.ssh \
    && echo $SSHPUB > ~/.ssh/authorized_keys 
"