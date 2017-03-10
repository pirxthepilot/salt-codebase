{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona = salt['pillar.get']('percona', default=default_settings.percona, merge=True) -%}

include:
  - yumrepos.percona


percona-shared:
  pkg.installed:
    - name: Percona-Server-shared-56
    - version: {{ percona.version }}
    - allow_updates: {{ percona.allow_updates }}
    - require:
      - sls: yumrepos.percona

percona-client:
  pkg.installed:
    - name: Percona-Server-client-56
    - version: {{ percona.version }}
    - allow_updates: {{ percona.allow_updates }}
    - require:
      - pkg: percona-shared
