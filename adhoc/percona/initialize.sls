{%- import_yaml "salt/defaults.yaml" as default_salt -%}
{%- set salt_mysql = salt['pillar.get']('saltminion:mysql', default=default_salt.saltminion.mysql, merge=True) -%}
#
# Percona Server Initialization
# - Create 'saltadmin'@'localhost'
# - Security hardening steps
#
# NOTE: This state will only work if the 'root'@'localhost' password is blank

{%- set hostname = salt['grains.get']('id') %}

include:
  - percona.server.service
  - percona.server.config
  - salt.minion.mysql


saltadmin:
  mysql_user.present:
    - name: saltadmin
    - host: localhost
    - password_hash: '{{ pillar['percona_server']['saltadmin']['password_hash'] }}'
    - require:
      - file: salt-minion-mysql
      - file: percona-mycnf
      - service: percona-server
    - connection_port: {{ salt_mysql.port }}
    - connection_user: root
    - connection_pass: ''
  mysql_grants.present:
    - user: saltadmin
    - host: localhost
    - grant: 'all privileges'
    - grant_option: true
    - database: '*.*'
    - require:
      - file: salt-minion-mysql
      - file: percona-mycnf
      - service: percona-server
    - connection_port: {{ salt_mysql.port }}
    - connection_user: root 
    - connection_pass: ''


remove-testdb:
  mysql_database.absent:
    - name: test
    - require:
      - mysql_user: saltadmin
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}


restrict-root:
  mysql_user.absent:
    - name: root
    - host: {{ hostname }}
    - require:
      - mysql_user: saltadmin
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}

remove-anonuser1:
  mysql_user.absent:
    - name: ''
    - host: localhost
    - require:
      - mysql_user: saltadmin
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}

remove-anonuser2:
  mysql_user.absent:
    - name: ''
    - host: {{ hostname }}
    - require:
      - mysql_user: saltadmin
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}
