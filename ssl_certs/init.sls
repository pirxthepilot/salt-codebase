{%- import_yaml "ssl_certs/defaults.yaml" as default_settings -%}
{%- set ssl_certs = salt['pillar.get']('ssl_certs', default=default_settings.ssl_certs, merge=True) -%}

# SSL certs directory
#

include:
  - httpd

ssl-certs-dir:
  file.directory:
    - name: {{ ssl_certs.dir }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require:
      - pkg: httpd
