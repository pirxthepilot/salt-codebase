{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


# Install the composer binary

include:
  - php

composer:
  file.managed:
    - name: /usr/local/bin/composer
    - source: salt://php_tools/files/composer
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: php-packages


{# </CentOS 7> #}
{%- endif -%}

