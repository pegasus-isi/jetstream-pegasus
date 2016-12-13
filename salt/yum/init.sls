
epel-release:
  pkg:
    - installed

/etc/yum.repos.d/osg.repo:
  file:
    - managed
    - source: salt://yum/osg.repo
    - require:
      - pkg: epel-release

/etc/yum.repos.d/htcondor.repo:
  file:
    - managed
    - source: salt://yum/htcondor.repo

/etc/yum.repos.d/pegasus.repo:
  file:
    - managed
    - source: salt://yum/pegasus.repo
  
osg-oasis:
  pkg:
    - installed
    - require:
      - file: /etc/yum.repos.d/osg.repo

pegasus:
  pkg:
    - installed
    - require:
      - file: /etc/yum.repos.d/pegasus.repo

vim-enhanced:
  pkg.installed

pigz:
  pkg.installed

