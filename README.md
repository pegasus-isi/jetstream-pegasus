# Sample setup to create a HTCondor pool for Pegasus workflows on Jetstream

First start a VM which will be you master. This is where HTCondor will manage
the pool and from where you will be submitting your workflows. The setup
consists of a set of SaltStack rules which will install CVMFS, HTCondor and 
Pegasus. It will also configure SaltStach and HTCondor.

_To bootstrap the master VM:_

  - Base OS should be CentOS 7
  
  - Log in to the VM as root using ssh-agent forwarding (ssh -A ...):
  
  ```
  ssh -A root@[ipaddress]
  ```
  
  - Check out this git repo into `/srv/jetstream-pegasus`

  ```
  cd /srv 
  git clone https://github.com/pegasus-isi/jetstream-pegasus.git
  cd jetstream-pegasus
  ./bootstrap-master.sh
  ```
  
_To bootstrap the worker VM:_

 -	Once the master has been bootstrapped, you may start worker VMs. To  bootstrap those,log into the master again, and from there run:
  
  ```
  ssh -A root@[Master's ipaddress]
  cd /srv/jetstream-pegasus
  ./bootstrap-worker.sh [WORKER'S ipaddress]
  ```
  
 - Exit and log in as user when your run the Pipeline
