{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


# Firewalld Configuration 
# Currently only supports enabling and disabling the service

firewalld:
  pkg.installed: []


{# </CentOS 7> #}
{%- endif -%}
