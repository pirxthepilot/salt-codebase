{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7' -%}


{%- import_yaml "cis/defaults.yaml" as default_settings -%}
{%- set cis = salt['pillar.get']('cis', default=default_settings.cis, merge=True) -%}

# CIS Hardening
# Set daemon umask
#

# Note: Disabling CIS hardening will only remove
# the states

{% if cis.enable_cis_hardening == True %}

cis-daemon-umask:
  file.append:
    - name: /etc/sysconfig/init
    - text: 'umask 027'

{% endif %}


{# </CentOS 7> #}
{%- endif -%}
