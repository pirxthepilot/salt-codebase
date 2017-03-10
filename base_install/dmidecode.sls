{# CentOS 6 and 7 support only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


# dmidecode
# - Required by salt-minion for proper hardware reporting
# - This state is separated from base_install so that minions
#   that do not use base_install can still apply this

include:
  - yumrepos.centos

dmidecode:
  pkg.installed:
    - require:
      - sls: yumrepos.centos
    - allow_updates: True


{%- endif -%}
