{%- import_yaml "yumrepos/settings.yaml" as settings -%}

percona-repo:
  pkg.installed:
    - sources:
      - percona-release: {{ settings.yumrepos.percona }}
