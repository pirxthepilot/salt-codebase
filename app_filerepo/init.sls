{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7' -%}


include:
  - app_filerepo.root_dir
  - app_filerepo.httpd_vhost


{# </CentOS 7> #}
{%- endif -%}
