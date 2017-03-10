{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}


{# Percona is supported on CentOS 6 and 7 only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}

  {%- if yumrepos.use_internal is sameas false %}

local-percona:
  pkgrepo.absent

local-percona-noarch:
  pkgrepo.absent

percona-release:
  pkg.installed:
    - sources:
      - percona-release: {{ yumrepos.external.percona }}
    - require:
      - pkgrepo: local-percona
      - pkgrepo: local-percona-noarch

  {% else %}

include:
  - ca_trust

percona-release:
  pkg.removed:
    - require:
      - sls: ca_trust

local-percona:
  pkgrepo.managed:
    - humanname: Percona-Release YUM repository - $basearch
    - baseurl: {{ yumrepos.internal.repo_url_https }}/percona/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/RPM-GPG-KEY-percona
    - failovermethod: priority
    - require:
      - pkg: percona-release

local-percona-noarch:
  pkgrepo.managed:
    - humanname: Percona-Release YUM repository - noarch
    - baseurl: {{ yumrepos.internal.repo_url_https }}/percona/$releasever/noarch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/RPM-GPG-KEY-percona
    - failovermethod: priority
    - require:
      - pkg: percona-release

  {% endif %}

{% endif -%}
