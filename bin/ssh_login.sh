#!/bin/bash
# cat /etc/ssh/sshd_config | grep PasswordAuthentication
# VAL="SQLTEST"
# sed -i "s/^\(central\.database\s*=\s*\).*\$/\1$VAL/" file.cfg
# sshRetValue=`sed -i "s/^\(\1$CENTRAL_DB_NAME\s*=\s*\).*\$/\1$CENTRAL_DB_VALUE/" /home/testing.txt`;
# sed -i "s/^\($CENTRAL_DB_NAME\s*=\s*\).*\$/\1$CENTRAL_DB_VALUE/" /home/testing.txt;
# sed_return_value=$?
# sed_return_value=$(ssh server <<EOF
#     sed -i "s/^\($CENTRAL_DB_NAME\s*=\s*\).*\$/\1$CENTRAL_DB_VALUE/" /home/testing.txt;
#     echo $?
# EOF
# )