{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- import_yaml "salt/defaults.yaml" as default_salt -%}
{%- set percona_users = salt['pillar.get']('percona_server:users', default=default_settings.percona_server.users, merge=True) -%}
{%- set salt_mysql = salt['pillar.get']('saltminion:mysql', default=default_salt.saltminion.mysql, merge=True) -%}

{# Set the output file #}
{%- set output_file = '/tmp/mysql_tzinfo_to_sql.result' -%}
#
# Percona - load the timezone tables
# This state executes only if the file declared in
# the output_file variable does not yet exist in the minion
#

{% if not salt['file.file_exists'](output_file) %}

{%- set tz_query = salt['cmd.run']('/usr/bin/mysql_tzinfo_to_sql /usr/share/zoneinfo')|string -%}

include:
  - percona.server.service
  - salt.minion.mysql


percona-timezone-tables:
  mysql_query.run:
    - database: mysql
    - query: "{{ tz_query }}"
    - output: "{{ output_file }}"
    - unless: test -f {{ output_file }}
    - require:
      - file: salt-minion-mysql
      - service: percona-server
    - connection_port: {{ salt_mysql.port }}
    - connection_user: {{ salt_mysql.user }}
    - connection_pass: {{ salt_mysql.pass }}

{%- endif -%}
