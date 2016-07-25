{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


include:
  - php

pear-twig:
  cmd.script:
    - source: salt://php_tools/files/install_twig.sh
    - cwd: /root
    - user: root
    - stateful: True
    - require:
      - pkg: php-packages


{# </CentOS 7> #}
{%- endif -%}
