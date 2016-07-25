{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona = salt['pillar.get']('php', default=default_settings.percona, merge=True) -%}

include:
  - percona.shared


percona-client:
  pkg.installed:
    - name: Percona-Server-client-56
    - version: {{ percona.version }}
    - require:
      - pkg: percona-shared
