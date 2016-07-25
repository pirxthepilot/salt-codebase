{%- import_yaml "app_filerepo/defaults.yaml" as default_settings -%}
{%- set filerepo = salt['pillar.get']('filerepo', default=default_settings.filerepo, merge=True) -%}

include:
  - httpd
  - app_filerepo.root_dir

filerepo_vhost_config:
  file.managed:
    - name: {{ filerepo.vhost_config }}
    - source: salt://app_filerepo/files/filerepo.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: filerepo-root-dir
    - watch_in:
      - service: httpd
