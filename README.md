# Sample setup to create a HTCondor pool for Pegasus workflows on Jetstream

First start a VM which will be you master. This is where HTCondor will manage
the pool and from where you will be submitting your workflows. The setup
consists of a set of SaltStack rules which will install CVMFS, HTCondor and 
Pegasus. It will also configure SaltStach and HTCondor.

To bootstrap the master VM:

  1. Base OS should be CentOS 7
  2. Attached an extra volume if you need the disk space
  3. Log in to the VM as root (ssh -A root@...)
  4. Check out this git repo into /srv/jetstream-pegasus: `cd /srv; git clone https://github.com/pegasus-isi/jetstream-pegasus.git`
  5. `cd /srv/jetstream-pegasus && ./bootstrap-master.sh`

Once the master has been bootstrapped, you may start worker VMs. To bootstrap those,
log into the master again, and from there run:

  1. Log in to the master, and use ssh-agent forwarding (ssh -A root@...)
  2. Verify that your ssh key has been forwarded correctly: `ssh-add -L` should
     list your key.
  3. cd /srv/jetstream-pegasus
  4. ./bootstrap-worker.sh [WORKERHOSTNAME]

Alternatively, you can bootstrap the clients by logging in directly to them:

  1. As root on the worker, add the necessary packages: `yum install -y salt-minion`
  2. Create `/etc/salt/minion` and add the line `master: [masterhost]`
  3. Run: `salt-call state.highstate`
  4. On the master, run `ssh-key -A` and accept the new worker key
  5. On the worker, run `salt-call state.highstate` again

