{%- import_yaml "httpd/defaults.yaml" as default_settings -%}
{%- set mod_ssl = salt['pillar.get']('mod_ssl', default=default_settings.mod_ssl, merge=True) -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set version = mod_ssl.version_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set version = mod_ssl.version_el6 -%}
{%- endif -%}


include:
  - httpd

mod_ssl:
  pkg.installed:
    - version: {{ version }}
    - require:
      - pkg: httpd
    - watch_in:
      - service: httpd
