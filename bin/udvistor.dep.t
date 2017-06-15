#!/bin/bash
((!$#)) && echo 请指定版本号 udvistor.dep.t 6.15.1_notice, command ignored! && exit 1

VERSION=$1

ssh udt1 "cd /srv/www/udesk_vistor.go && ./scripts/update.sh $VERSION && ./server_ctl.sh restart"
ssh udt2 "cd /srv/www/udesk_vistor.go && ./scripts/update.sh $VERSION && ./server_ctl.sh restart"
ssh udt3 "cd /srv/www/udesk_vistor.go && ./scripts/update.sh $VERSION && ./server_ctl.sh restart"