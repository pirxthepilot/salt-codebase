{%- import_yaml "openssl/defaults.yaml" as default_settings -%}
{%- set openssl = salt['pillar.get']('openssl', default=default_settings.openssl, merge=True) -%}

openssl:
{%- if openssl.auto_update is sameas true %}
  pkg.latest: []
{%- else %}
  pkg.installed: []
{%- endif -%}
