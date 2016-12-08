#!/bin/bash

set -e

TARGET_HOST=$1
if [ "x$TARGET_HOST" = "x" ]; then
    echo "Please specify the host you are trying to bootstrap"
    exit 1 
fi

ssh $TARGET_HOST "yum install -y salt-minion"

ssh $TARGET_HOST "mkdir -p /etc/salt/minion.d"

scp /srv/jetstream-pegasus/salt/salt/*.conf $TARGET_HOST:/etc/salt/minion.d/

ssh $TARGET_HOST "salt-call state.highstate >/dev/null 2>&1" || true

# get the minion id so we can authorized the node
MINION_ID=`ssh $TARGET_HOST "cat /etc/salt/minion_id"`
if [ -e /etc/salt/pki/master/minions_pre/$MINION_ID ]; then
    mv /etc/salt/pki/master/minions_pre/$MINION_ID /etc/salt/pki/master/minions/$MINION_ID
fi

ssh $TARGET_HOST "salt-call state.highstate" 

ssh $TARGET_HOST "/etc/init.d/salt-minion restart"

