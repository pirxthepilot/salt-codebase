{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


include:
  - httpd
  - php

# Default PHP settings
#

php-defaults-ini:
  file.managed:
    - name: /etc/php.d/00_defaults.ini
    - source: salt://php/files/00_defaults.ini.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - replace: False
    - require:
      - pkg: php-packages
    - watch_in:
      - service: httpd


{# </CentOS 6 and 7> #}
{%- endif -%}

