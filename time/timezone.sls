{%- import_yaml "time/defaults.yaml" as default_settings -%}
{%- set timezone = salt['pillar.get']('timezone', default=default_settings.timezone, merge=True) -%}

timezone:
  timezone.system:
    - name: {{ timezone.name }}
    - utc: {{ timezone.utc }}

tzdata:
  pkg.latest
