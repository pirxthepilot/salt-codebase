{%- import_yaml "yumrepos/settings.yaml" as settings -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set webtatic_release = settings.yumrepos.webtatic_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set webtatic_release = settings.yumrepos.webtatic_el6 -%}
{%- endif -%}

webtatic-repo:
  pkg.installed:
    - sources:
      - webtatic-release: {{ webtatic_release }}

webtatic-archive:
  pkgrepo.managed:
    - name: webtatic-archive
    - disabled: 0 
    - require:
      - pkg: webtatic-repo
