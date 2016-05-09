#!/bin/bash 
# init a remote server ssh server 
SSHPUB="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDa2+IQBGOYU1SavQhVQ84FdZgjUaynnv6pt8v+7EQnMaChtw/r+IRUy71fOQQNmZ6D4TLh4RrUkbayiOXXaYwa1ohXpcPYab+UQuX8WL9wYKTnh22kuSDUK8APbyc61MHEcSXtzE6dolqv6EqAMaUZ50tXZehGz81eaIPSlsZ681oWa+m30WL0NR+34jnCYVQYa0Jn3c/3XpakG6Jkue1QK1XuTnrycR6Bhmr64lDaGkPCQZgdfZUR99hmqxO6jTz2jPe4gQc7o+hxmTlV1HQhaRYauE2VWlJvbVmAFAVYKwm0JDZQjqjLIpiSRPTc2m6awLV7cfcC4Je+M81RDzN4ieJ9K/5QBdG/unrhGiOq1iaCLck5s0hkMHAcwSq3nh5kIkNpCYL+Pjy58F2N9bh/+ApsZ9uia4cDiF+8vOhfnqsPyxJFsoA/URNKOo4z+i5LLI/htolnqtxFE1mFVNkTnpViufoQI1u78f0kMAHMFjZkDF9gO0gewS+f3r+ee+HAIh/JW/u3rkDaXCGHqhlg8rlPfyoECWLI+Lq9uoWXDDiw6RoTOcRPoVowhh1Peercti+nRriQP2S83Y77mM/XxZptEszp7a+zyPEqzXLM++U3ty2Cmyox9YbgIvHsdF0KzPyR1HKAET+gyV+uPQ9DsNSsDWBEW3IAF1wxaEyeVQ== mingle5566@163.com"
if [[ $# = 0 ]]; then
  echo "need server name"
  echo "uage: server_init udxxx"
  exit 0
fi
ssh $1 "set -x \
    && mkdir -p ~/.ssh \
    && echo $SSHPUB >> ~/.ssh/authorized_keys \
    && cat ~/.ssh/authorized_keys  |grep ming -B 1
 "