{%- import_yaml "cis/paths.yaml" as paths -%}
{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# Restrict Core Dumps
#


{% if cis.enable_cis_hardening == True %}

cis-coredumps:
  file.managed:
    - name: {{ paths.coredumps_file }}
    - source: {{ paths.coredumps_source }} 
    - user: root
    - group: root
    - mode: 644

{% else %}

cis-coredumps:
  file.absent:
    - name: {{ paths.coredumps_file }}

{% endif %}
