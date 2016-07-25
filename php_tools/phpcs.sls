{# <CentOS 7> #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}


{%- import_yaml "php_tools/settings.yaml" as settings -%}
# Install phpcs from git repo
# (because the PEAR version is broken)

include:
  - php


phpcs-version-check:
  cmd.script:
    - source: salt://php_tools/files/check_phpcs_version.sh.jinja
    - template: jinja
    - user: root
    - stateful: True

phpcs-git:
  git.latest:
    - name: {{ settings.phpcs.git_repo }}
    - rev: {{ settings.phpcs.version }}
    - branch: {{ settings.phpcs.version }}
    - target: {{ settings.phpcs.target_dir }}
    - force_clone: True
    - force_reset: {{ settings.phpcs.git_force_reset }}
    - require:
      - pkg: php-packages
    - onchanges:
      - cmd: phpcs-version-check

phpcs-install:
  cmd.wait:
    - name: |
        /bin/pear uninstall PHP_CodeSniffer
        /bin/pear install package.xml
    - cwd: {{ settings.phpcs.target_dir }}
    - require:
      - git: phpcs-git
    - watch:
      - cmd: phpcs-version-check


{# </CentOS 7> #}
{%- endif -%}
