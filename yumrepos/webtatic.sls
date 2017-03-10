{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set webtatic_release = yumrepos.external.webtatic_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set webtatic_release = yumrepos.external.webtatic_el6 -%}
{%- endif -%}


{# Webtatic is supported on CentOS 6 and 7 only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}

include:
  - yumrepos.epel


  {%- if yumrepos.use_internal is sameas false %}

local-webtatic:
  pkgrepo.absent

local-webtatic-archive:
  pkgrepo.absent

webtatic-release:
  pkg.installed:
    - sources:
      - webtatic-release: {{ webtatic_release }}
    - require:
      - pkgrepo: local-webtatic
      - pkgrepo: local-webtatic-archive
      - sls: yumrepos.epel

webtatic-archive:
  file.replace:
    - name: /etc/yum.repos.d/webtatic-archive.repo
    - pattern: ^(\s*)#?\s*enabled\s*=.*$
    - repl: \1enabled=1
    - require:
      - pkg: webtatic-release

webtatic-archive-debuginfo-remove:
  pkgrepo.absent:
    - name: webtatic-archive-debuginfo
    - require:
      - file: webtatic-archive

webtatic-archive-source-remove:
  pkgrepo.absent:
    - name: webtatic-archive-source
    - require:
      - file: webtatic-archive

  {% else %}

webtatic-release:
  pkg.removed

local-webtatic:
  pkgrepo.managed:
    - humanname: Webtatic Repository EL$releasever - $basearch 
    - baseurl: {{ yumrepos.internal.repo_url_https }}/webtatic/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/RPM-GPG-KEY-webtatic-el$releasever
    - failovermethod: priority
    - require:
      - pkg: webtatic-release
      - sls: yumrepos.epel

local-webtatic-archive:
  pkgrepo.managed:
    - humanname: Webtatic Repository EL$releasever - $basearch - Archive
    - baseurl: {{ yumrepos.internal.repo_url_https }}/webtatic/archive/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/RPM-GPG-KEY-webtatic-el$releasever
    - failovermethod: priority
    - require:
      - pkgrepo: local-webtatic

  {% endif %}

{% endif -%}
