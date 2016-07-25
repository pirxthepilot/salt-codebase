{%- import_yaml "percona/defaults.yaml" as default_settings -%}
{%- set percona = salt['pillar.get']('php', default=default_settings.percona, merge=True) -%}

include:
  - yumrepos.percona


percona-shared:
  pkg.installed:
    - name: Percona-Server-shared-56
    - version: {{ percona.version }}
    - require:
      - pkg: percona-repo
