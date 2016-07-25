{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


# Disable Firewalld but ensure it is installed
#

include:
  - firewalld

firewalld-disable:
  service.dead:
    - name: firewalld
    - enable: False
    - require:
      - pkg: firewalld


{# </CentOS 7> #}
{%- endif -%}
