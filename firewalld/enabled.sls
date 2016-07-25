{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


# Disable Firewalld but ensure it is installed
#

include:
  - firewalld

firewalld-enable:
  service.running:
    - name: firewalld
    - enable: True
    - require:
      - pkg: firewalld


{# </CentOS 7> #}
{%- endif -%}
