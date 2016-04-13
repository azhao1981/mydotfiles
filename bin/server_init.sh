#!/bin/bash 
# init a remote server ssh server 
SSHPUB="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8ontrCs2Ysm2IRUaPBbcO2DCN5GfgN6/dqXFQkLEX0yS3dwZeki4tfWVGLWQow0afMnLN36O0CBK2Om/qgrzSMo8CLFz7Z7go+HqsmpEL4kzcWTu1qXDhFI/cCO3qhqEHpK1CWXUtOg0IBkhN2qDfrvKNh0MP7h1sWCGTBO+E6HqnmbUq1lAbUJJHPeMp0pQOnyGqu/lJHFJAP1WQX6SM3X1rUvvj7r+nQHSsDxXkMZINKMwCjYVwI7x/cNN03y//qqqK0vWucNWrwvC4KhaSmhZ6YDtKZj1QzEaP/iwfVu19nF+v1P7LY6JA1SMBWK76H+pCCyX07RziQVwBsNVl azhao.1981@gmail.com"
if [[ $# = 0 ]]; then
  echo "need server name"
  echo "uage: server_init udxxx"
  exit 0
fi
ssh $1 "set -x \
    && mkdir -p ~/.ssh \
    && echo $SSHPUB > ~/.ssh/authorized_keys 
"