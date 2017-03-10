# Minion configuration
#

include:
  - yumrepos.saltstack
{% if grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7' %}
  - base_install.dmidecode
{%- endif %}

salt-minion:
  pkg.installed:
    - require:
      - sls: yumrepos.saltstack
{% if grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7' %}
      - pkg: dmidecode
{%- endif %}
  service.running:
    - enable: True
    - watch:
      - pkg: salt-minion

salt-minion-backupmode:
  file.managed:
    - name: /etc/salt/minion.d/backupmode.conf
    - source: salt://salt/files/minion-backupmode.conf
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - service: salt-minion

salt-minion-hashtype:
  file.managed:
    - name: /etc/salt/minion.d/hash_type.conf
    - source: salt://salt/files/hash_type.conf
    - user: root
    - group: root
    - mode: 640
    - watch_in:
      - service: salt-minion
