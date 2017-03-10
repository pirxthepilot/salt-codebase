# Additional setup for MySQL Salt States
# for minions
#

include:
  - misc_installs.mysql_python
  - salt.minion

salt-minion-mysql:
  file.managed:
    - name: /etc/salt/minion.d/mysql.conf
    - source: salt://salt/files/minion-mysql.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 640
    #- replace: False
    - require:
      - pkg: mysql-python
    #- watch_in:
    #  - service: salt-minion   # salt-minion does not need to restart :)
