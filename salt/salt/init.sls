/etc/salt/minion.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/salt/master.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/salt/minion.d/master.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://salt/master.conf

/etc/salt/minion.d/jetstream-pegasus-vm.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://salt/jetstream-pegasus-vm.conf

/etc/salt/master.d/jetstream-pegasus-vm.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://salt/jetstream-pegasus-vm.conf

/etc/cron.d/salt:
  file.managed:
    - source: salt://salt/cron.salt
    - user: root
    - group: root
    - mode: 644
    - template: jinja


