{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


{%- import_yaml "php/defaults.yaml" as default_settings -%}
{%- set php = salt['pillar.get']('php', default=default_settings.php, merge=True) -%}
{%- set php_pear = salt['pillar.get']('php_pear', default=default_settings.php_pear, merge=True) -%}
{%- set php_mysql = salt['pillar.get']('php_mysql', default=default_settings.php_mysql, merge=True) -%}


{# Option between using php55w-mysql and php55w-mysqlnd (MySQL native driver) #}
{%- if php_mysql.use_mysqlnd is sameas true -%}
{%- set php_mysql_pkg = "php55w-mysqlnd" -%}
{%- else -%}
{%- set php_mysql_pkg = "php55w-mysql" -%}
{%- endif %}

include:
  - yumrepos.webtatic
  - php.config
  - httpd

php-packages:
  pkg.installed:
    - require:
      - pkg: webtatic-repo
    - watch_in:
      - service: httpd
    - pkgs:
      - php55w: {{ php.version }}
      - php55w-bcmath: {{ php.version }}
      - php55w-cli: {{ php.version }}
      - php55w-common: {{ php.version }}
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
      - php55w-soap: {{ php.version }}
      - php55w-xml: {{ php.version }}
      - {{ php_mysql_pkg }}: {{ php.version }}


{# </CentOS 7> #}
{%- endif -%}
