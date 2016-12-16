# Sample setup to create a HTCondor pool for Pegasus workflows on Jetstream

First start a VM which will be you master. This is where HTCondor will manage
the pool and from where you will be submitting your workflows. The setup
consists of a set of SaltStack rules which will install CVMFS, HTCondor and 
Pegasus. It will also configure SaltStach and HTCondor.

To bootstrap the master VM:

  - Base OS should be CentOS 7
  - Attached an extra volume if you need the disk space
  - Log in to the VM as root
  - Check out this git repo into /srv/jetstream-pegasus
  - ./bootstrap-master.sh

Once the master has been bootstrapped, you may start worker VMs. To bootstrap those,
log into the master again, and from there run:

  - Log in to the master, and use ssh-agent forwarding (ssh -A ...)
  - cd /srv/jetstream-pegasus
  - ./bootstrap-worker.sh [WORKERHOSTNAME]

