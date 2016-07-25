{%- import_yaml "httpd/defaults.yaml" as default_settings -%}
{%- set httpd = salt['pillar.get']('httpd', default=default_settings.httpd, merge=True) -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set version = httpd.version_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set version = httpd.version_el6 -%}
{%- endif -%}


include:
  - httpd.config
  - httpd.mod_ssl

httpd:
  pkg.installed:
    - version: {{ version }}
    - watch_in:
      - service: httpd
  service.running:
    - enable: True
