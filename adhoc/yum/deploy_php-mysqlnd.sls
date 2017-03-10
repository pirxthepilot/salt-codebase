{%- import_yaml "php/defaults.yaml" as default_settings -%}
{%- set php = salt['pillar.get']('php', default=default_settings.php, merge=True) -%}

# Install php55w-mysqlnd
# - php55w-mysql will be removed if it is installed
# - httpd will restart after install

include:
  - httpd

remove-php55w-mysql:
  pkg.removed:
    - name: php55w-mysql
    - onlyif: rpm -q php55w-mysql

php55w-mysqlnd:
  pkg.installed:
    - version: {{ php.version }}
    - require:
      - pkg: remove-php55w-mysql
    - watch_in:
      - service: httpd
