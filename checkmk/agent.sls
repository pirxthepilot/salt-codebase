{%- import_yaml "checkmk/defaults.yaml" as default_settings -%}
{%- set checkmk = salt['pillar.get']('checkmk', default=default_settings.checkmk, merge=True) -%}

include:
  - yumrepos.epel
  - xinetd
  - checkmk.mrpe

check-mk-agent:
  pkg.installed:
    - require:
      - sls: yumrepos.epel

check-mk-agent-config:
  file.replace:
    - name: /etc/xinetd.d/check-mk-agent
    - pattern: ^(\s*)#?\s*only_from\s+=.*$
    - repl: \1only_from = {{ checkmk.server_ip }}
    - watch_in:
      - service: xinetd
    - require:
      - pkg: check-mk-agent
