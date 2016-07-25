{%- import_yaml "postfix/defaults.yaml" as postfix_defaults -%}
{%- set postfix = salt['pillar.get']('postfix', default=postfix_defaults.postfix, merge=True) -%}

# Postfix
#

{%- if postfix.managed is sameas true %}

postfix:
  pkg.installed: []
  service.running:
    - enable: True

{%- if postfix.strict_config is sameas true %}
postfix-config:
  file.managed:
    - name: /etc/postfix/main.cf
    - source: salt://postfix/files/main.cf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: postfix
{%- endif -%}

{%- endif -%}
