{# <CentOS 6> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}

ntp:
  pkg.installed:
    - name: ntp
  service.running:
    - enable: True
    - name: ntpd
    - require:
      - pkg: ntp

ntp-config:
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://time/files/ntp.conf.jinja
    - template: jinja
    - user: root
    - mode: 644
    - watch_in:
      - service: ntp

{# </CentOS 6> #}
{%- endif -%}
