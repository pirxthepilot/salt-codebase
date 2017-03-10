{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


{%- import_yaml "php/defaults.yaml" as default_settings -%}
{%- set php = salt['pillar.get']('php', default=default_settings.php, merge=True) -%}

include:
  - yumrepos.webtatic

php-cli:
  pkg.installed:
    - require:
      - sls: yumrepos.webtatic
    - pkgs:
      - php55w-cli: {{ php.version }}
      - php55w-common: {{ php.version }}


{# </CentOS 6 and 7> #}
{%- endif -%}
