{# <CentOS 6 and 7> #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


{%- import_yaml "php/defaults.yaml" as default_settings -%}
{%- set php = salt['pillar.get']('php', default=default_settings.php, merge=True) -%}
{%- set php_pear = salt['pillar.get']('php_pear', default=default_settings.php_pear, merge=True) -%}
{%- set php_pecl_igbinary = salt['pillar.get']('php_pecl_igbinary', default=default_settings.php_pecl_igbinary, merge=True) -%}
{%- set php_pecl_imagick = salt['pillar.get']('php_pecl_imagick', default=default_settings.php_pecl_imagick, merge=True) -%}

# PHP main
#


include:
  - php.php_cli
  - php.config
  - httpd

# Note: php-packages depends on php_cli.sls, which first installs the most basic
# PHP packages (php-cli and php-common)

php-packages:
  pkg.installed:
    - require:
      - pkg: php-cli
    - watch_in:
      - service: httpd
    - pkgs:
      - php55w: {{ php.version }}
      - php55w-bcmath: {{ php.version }}
      - php55w-devel: {{ php.version }}
      - php55w-gd: {{ php.version }}
      - php55w-imap: {{ php.version }}
      - php55w-mbstring: {{ php.version }}
      - php55w-mcrypt: {{ php.version }}
      # php-pear not included on purpose because it breaks version
      # locks for some reason. Instead it is implicitly installed as
      # a dependency of the php-pecl binaries
      #- php55w-pear: {{ php_pear.version }}
      - php55w-pdo: {{ php.version }}
      - php55w-process: {{ php.version }}
      - php55w-pecl-igbinary: {{ php_pecl_igbinary.version }}
      - php55w-pecl-imagick: {{ php_pecl_imagick.version }}
      - php55w-soap: {{ php.version }}
      - php55w-xml: {{ php.version }}
      - php55w-mysqlnd: {{ php.version }}


{# </CentOS 6 and 7> #}
{%- endif -%}
