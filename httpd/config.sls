include:
  - httpd


# Default HTTPD settings
#

httpd-defaults:
  file.managed:
    - name: /etc/httpd/conf.d/00_defaults.conf
    - source: salt://httpd/files/00_defaults.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: httpd
    - watch_in:
      - service: httpd

httpd-ssl-defaults:
  file.managed:
    - name: /etc/httpd/conf.d/00_ssl_defaults.conf
    - source: salt://httpd/files/00_ssl_defaults.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: httpd
    - watch_in:
      - service: httpd
