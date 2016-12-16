#!/bin/bash

set -e

yum install -y salt-master salt-minion

mkdir -p /etc/salt/minion.d /etc/salt/master.d

echo "master: "`hostname -f` >/srv/jetstream-pegasus/salt/salt/master.conf

cp /srv/jetstream-pegasus/salt/salt/*.conf /etc/salt/minion.d/

cp /srv/jetstream-pegasus/salt/salt/jetstream-pegasus-vm.conf /etc/salt/master.d/

hostname -f >/etc/salt/minion_id
systemctl restart salt-master

salt-call state.highstate >/dev/null 2>&1 || true
if [ -e /etc/salt/pki/master/minions_pre/$HOSTNAME ]; then
    mv /etc/salt/pki/master/minions_pre/$HOSTNAME /etc/salt/pki/master/minions/$HOSTNAME
fi
salt-call state.highstate

# once HTCondor is installed, create a pool password and where to find the master
condor_store_cred -p `uuidgen` -f /srv/jetstream-pegasus/salt/htcondor/pool_password
echo "CONDOR_HOST = $HOSTNAME" >/srv/jetstream-pegasus/salt/htcondor/50-master.conf

# do we have an extra volume attached?
if [ -e /vol1 ]; then
    # if so, let's move HTCondor's work space to it
    if [ ! -e /vol1/condor ]; then
        mv /var/lib/condor /vol1/
        ln -s /vol1/condor /var/lib/condor
    fi
    # also need somewhere for users to run workflows from
    mkdir -p /vol1/scratch
    chmod 1777 /vol1/scratch
fi

salt-call state.highstate

systemctl restart salt-minion

