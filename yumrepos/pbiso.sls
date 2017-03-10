{# PBIS is supported only on CentOS 6 #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6' -%}


{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}

pbiso:
  pkgrepo.managed:
    - humanname: PBISO- local packages for $basearch
    - baseurl: {{ yumrepos.external.pbiso.baseurl }}
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.external.pbiso.gpgkey }}
    - failovermethod: priority


{% endif -%}
