{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- import_yaml "salt/defaults.yaml" as default_salt -%}
{%- set percona_users = salt['pillar.get']('percona_server:users', default=default_settings.percona_server.users, merge=True) -%}
{%- set salt_mysql = salt['pillar.get']('saltminion:mysql', default=default_salt.saltminion.mysql, merge=True) -%}
#
# Percona Users
#

# NOTES
#
# - This state only creates (and grants access to) users;
#   it DOES NOT remove users that are not defined by the pillar!
#   Unwanted users must be manually deleted.
#
# - To generate the password_hash, login to MySQL and run:
#       select PASSWORD('mypassword');

{%- if percona_users %}

include:
  - percona.server.service
  - percona.server.config
  - salt.minion.mysql


  {% for user, params in percona_users.items() %}

percona_user-{{ user }}:
  mysql_user.present:
    - name: {{ user }}
    - host: {{ params.host }}
    - password_hash: '{{ params.password_hash }}'
    - require:
      - file: salt-minion-mysql
      - file: percona-mycnf
      - service: percona-server
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}
  mysql_grants.present:
    - user: {{ user }}
    - host: {{ params.host }}
    - grant: '{{ params.grant }}'
    - grant_option: {{ params.grant_option | default(false) }}
    - database: '{{ params.database }}'
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}
    
  {%- endfor -%}
{%- endif -%}
