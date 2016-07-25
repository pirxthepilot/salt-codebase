{%- import_yaml "yumrepos/settings.yaml" as settings -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set saltstack_release = settings.yumrepos.saltstack_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set saltstack_release = settings.yumrepos.saltstack_el6 -%}
{%- endif -%}

saltstack-repo:
  pkg.installed:
    - sources:
      - salt-repo: {{ saltstack_release }}
