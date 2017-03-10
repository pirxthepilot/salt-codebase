{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona_server = salt['pillar.get']('percona_server', default=default_settings.percona_server, merge=True) -%}

#
# Percona Server Configuration
#

include:
  - percona.server.service


# my.cnf configuration

percona-mycnf:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://percona/files/my.cnf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: percona-server

# logrotate

percona-logrotate:
  file.managed:
    - name: /etc/logrotate.d/mysql
    - source: salt://percona/files/logrotated_mysql.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: percona-mycnf
