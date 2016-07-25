{%- import_yaml "cis/paths.yaml" as paths -%}
{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# Sysctl options
#

# Note: Sysctl changes by CIS hardening cannot be undone without rebooting the minion

{% if cis.enable_cis_hardening == True %}

cis-sysctl:
  file.managed:
    - name: {{ paths.sysctl_file }}
    - source: {{ paths.sysctl_source }}
    - makedirs: True
    - dir_mode: 755

cis-sysctl-reload:
  cmd.wait:
    - name: /sbin/sysctl -p {{ paths.sysctl_file }}
    - watch:
      - file: cis-sysctl

{% else %}

cis-sysctl:
  file.absent:
    - name: {{ paths.sysctl_file }}

{% endif %}
