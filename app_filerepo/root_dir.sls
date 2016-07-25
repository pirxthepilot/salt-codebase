{%- import_yaml "app_filerepo/defaults.yaml" as default_settings -%}
{%- set filerepo = salt['pillar.get']('filerepo', default=default_settings.filerepo, merge=True) -%}

include:
  - httpd

filerepo-root-dir:
  file.directory:
    - name: {{ filerepo.root_dir }}
    - user: {{ filerepo.httpd_user }}
    - group: {{ filerepo.httpd_group }}
    - makedirs: True
    - recurse:
      - user
      - group
    - watch_in:
      - service: httpd
