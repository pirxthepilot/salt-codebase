{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


{%- import_yaml "php_tools/settings.yaml" as settings -%}
# Install the composer binary

include:
  - php.php_cli

composer:
  file.managed:
    - name: /usr/local/bin/composer
    - source: {{ settings.composer.source }}
    - source_hash: {{ settings.composer.source_hash }}
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: php-cli


{# </CentOS 6 and 7> #}
{%- endif -%}

