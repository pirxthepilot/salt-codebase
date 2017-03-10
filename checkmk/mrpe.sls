{%- import_yaml "checkmk/defaults.yaml" as default_settings -%}
{%- set checkmk = salt['pillar.get']('checkmk', default=default_settings.checkmk, merge=True) -%}


{%- if checkmk.mrpe.config -%}

include:
  - checkmk.agent

mrpe-config:
  file.managed:
    - name: /etc/check-mk-agent/mrpe.cfg
    - source: salt://checkmk/files/mrpe.cfg.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: check-mk-agent-config

{%- endif -%}
