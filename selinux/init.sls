{%- import_yaml "selinux/defaults.yaml" as default_settings -%}
{%- set selinux = salt['pillar.get']('selinux', default=default_settings.selinux, merge=True) -%}

include:
  - base_install

selinux_mode:
  selinux.mode:
    - name: {{ selinux.mode }}
    - require:
      - pkg: base-packages

selinux_mode_persist:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://selinux/files/config.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 600
