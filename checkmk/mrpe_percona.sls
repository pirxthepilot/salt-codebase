{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '7' or grains['osmajorrelease'] == '6') -%}


include:
  - yumrepos.percona

percona-nagios-plugins:
  pkg.installed:
    - require:
      - sls: yumrepos.percona

percona-nagios-plugins-config:
  file.managed:
    - name: /etc/nagios/mysql.cnf
    - source: salt://checkmk/files/mysql.cnf
    - user: root
    - group: root
    - mode: 640
    - makedirs: True
    - replace: False
    - require:
      - pkg: percona-nagios-plugins


{%- endif -%}
