{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}

chrony:
  pkg.installed:
    - name: chrony
  service.running:
    - enable: True
    - name: chronyd
    - require:
      - pkg: chrony

chrony-config:
  file.managed:
    - name: /etc/chrony.conf
    - source: salt://time/files/chrony.conf.jinja
    - template: jinja
    - user: root
    - mode: 644
    - watch_in:
      - service: chrony

{# </CentOS 7> #}
{%- endif -%}
