{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona = salt['pillar.get']('percona', default=default_settings.percona, merge=True) -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set servicename = 'mysqld' -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set servicename = 'mysql' -%}
{%- endif -%}


include:
  - percona.client


percona-server:
  pkg.installed:
    - require:
      - pkg: percona-client
    - pkgs:
      - Percona-Server-server-56: {{ percona.version }}
    - allow_updates: {{ percona.allow_updates }}
  service.running:
    - name: {{ servicename }}
    - enable: True
