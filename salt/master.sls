# Master configuration
#

include:
  - yumrepos.saltstack

salt-master:
  pkg.installed:
    - require:
      - pkg: saltstack-repo
  service.running:
    - enable: True
    - watch:
      - pkg: salt-master

salt-master-hashtype:
  file.managed:
    - name: /etc/salt/master.d/hash_type.conf
    - source: salt://salt/files/hash_type.conf
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - service: salt-master
