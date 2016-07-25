{%- import_yaml "cis/paths.yaml" as paths -%}
{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

#
# CIS Hardening
# Disable mounting of specific filesystems
# and disallow uncommon network protocols
#


{% if cis.enable_cis_hardening == True %}

cis-blacklist-filesystems:
  file.managed:
    - name: {{ paths.fs_blacklist_file }}
    - source: {{ paths.fs_blacklist_source }}
    - user: root
    - group: root
    - mode: 644

cis-disallow-protocols:
  file.managed:
    - name: {{ paths.disallow_protocols_file }}
    - source: {{ paths.disallow_protocols_source }}
    - user: root
    - group: root
    - mode: 644

{% else %}

cis-blacklist-filesystems:
  file.absent:
    - name: {{ paths.fs_blacklist_file }}

cis-disallow-protocols:
  file.absent:
    - name: {{ paths.disallow_protocols_file }}

{% endif %}
