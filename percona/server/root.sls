{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- import_yaml "salt/defaults.yaml" as default_salt -%}
{%- set percona_server = salt['pillar.get']('percona_server', default=default_settings.percona_server, merge=True) -%}
{%- set salt_mysql = salt['pillar.get']('saltminion:mysql', default=default_salt.saltminion.mysql, merge=True) -%}
#
# Percona Server - set the root password
# This state will only run if salt_mysql.user is NOT root
#


{% if salt_mysql.user != 'root' %}

include:
  - percona.server.service
  - salt.minion.mysql


{# List of built-in hosts for MySQL root user #}
{% set hosts = ['localhost', '127.0.0.1', '::1'] %}

{% for host in hosts %}
percona-root@{{ host }}:
  mysql_user.present:
    - name: root
    - host: {{ host }}
    - password_hash: '{{ percona_server.root.password_hash }}'
    - require:
      - file: salt-minion-mysql
      - service: percona-server
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}
{%- endfor -%}

{%- endif -%}
