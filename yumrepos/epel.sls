{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}

# EPEL repository
# Supports CentOS 5, 6 and 7

{# Local repos supported on CentOS 6 and 7 only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}

  {%- if yumrepos.use_internal is sameas false %}

local-epel:
  pkgrepo.absent

epel-release:
  pkg.installed:
    - require:
        - pkgrepo: local-epel

  {% else %}

include:
  - ca_trust

epel-release:
  pkg.removed:
    - require:
      - sls: ca_trust

local-epel:
  pkgrepo.managed:
    - humanname: Extra Packages for Enterprise Linux $releasever - $basearch
    - baseurl: {{ yumrepos.internal.repo_url_https }}/epel/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/RPM-GPG-KEY-EPEL-$releasever
    - failovermethod: priority
    - require:
      - pkg: epel-release

  {% endif %}

{% endif %}


{# For CentOS 5 #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '5' -%}

epel-release:
  pkg.installed

{% endif -%}
