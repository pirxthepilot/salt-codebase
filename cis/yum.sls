{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

#
# CIS Hardening
# Verify that gpgcheck is Globally Activated
#

{% if cis.enable_cis_hardening == True %}

cis-yum-options:
  file.line:
    - name: /etc/yum.conf
    - match: gpgcheck=0
    - content: gpgcheck=1
    - mode: replace

{% endif %}
