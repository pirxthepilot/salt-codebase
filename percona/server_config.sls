{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona = salt['pillar.get']('php', default=default_settings.percona, merge=True) -%}

{%- set hostname = salt['grains.get']('id') -%}

include:
  - percona.server
  - salt.minion_mysql


percona-remove-testdb:
  mysql_database.absent:
    - name: test
    - require:
      - file: salt-minion-mysql
      - service: percona-server

percona-restrict-root:
  mysql_user.absent:
    - name: root
    - host: {{ hostname }}
    - require:
      - file: salt-minion-mysql
      - service: percona-server

percona-remove-anonuser1:
  mysql_user.absent:
    - name: ''
    - host: localhost
    - require:
      - file: salt-minion-mysql
      - service: percona-server

percona-remove-anonuser2:
  mysql_user.absent:
    - name: ''
    - host: {{ hostname }}
    - require:
      - file: salt-minion-mysql
      - service: percona-server
