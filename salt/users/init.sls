

rynge:
  group.present: []
  user.present:
    - shell: /bin/bash
    - home: /home/rynge
    - remove_groups: False
    - groups:
      - rynge
      - users

/home/rynge/.ssh:
  file.directory:
    - user: rynge
    - group: rynge
    - mode: 755
    - makedirs: True
    - require:
      - user: rynge

#/home/rynge/.ssh/authorized_keys:
#  file.managed:
#    - user: rynge
#    - group: rynge
#    - mode: 644
#    - template: jinja
#    - source: salt://users/authorized_keys.rynge

#/root/.ssh:
#  file.directory:
#    - user: root
#    - group: root
#    - mode: 700
#    - makedirs: True
#
#/root/.ssh/authorized_keys:
#  file.managed:
#    - user: root
#    - group: root
#    - mode: 644
#    - template: jinja
#    - source: salt://users/authorized_keys.all


