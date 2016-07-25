{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# Disallowed Packages
#

{% if cis.enable_cis_hardening == True %}

cis-disallowed-packages:
  pkg.removed:
    - pkgs: {{ cis.disallowed_packages }}

{% endif %}
