{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# rsyslog config 
#

# Note: Disabling CIS hardening will only remove
# the states, and will not roll back files or dirs

{% if cis.enable_cis_hardening == True %}

cis-rsyslog:
  pkg.installed:
    - name: rsyslog
  service.running:
    - name: rsyslog
    - enable: True

{% endif %}
