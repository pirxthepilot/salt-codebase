{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}

{# OS Versioning #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'-%}
  {%- set saltstack_release = yumrepos.external.saltstack_el7 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'-%}
  {%- set saltstack_release = yumrepos.external.saltstack_el6 -%}
{%- elif grains['os'] == 'CentOS' and grains['osmajorrelease'] == '5'-%}
  {%- set saltstack_release = yumrepos.external.saltstack_el5 -%}
{%- endif -%}


{# Local repos supported on CentOS 6 and 7 only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}

include:
  - yumrepos.epel


  {%- if yumrepos.use_internal is sameas false %}

local-salt:
  pkgrepo.absent

local-salt-2016_3:
  pkgrepo.absent

salt-repo:
  pkg.installed:
    - sources:
      - salt-repo: {{ saltstack_release }}
    - require:
      - pkgrepo: local-salt
      - pkgrepo: local-salt-2016_3
      - sls: yumrepos.epel

  {% else %}

salt-repo:
  pkg.removed

local-salt:
  pkgrepo.managed:
    - humanname: SaltStack Latest Release Channel for RHEL/Centos $releasever
    - baseurl: {{ yumrepos.internal.repo_url_https }}/salt/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/SALTSTACK-GPG-KEY.pub
    - failovermethod: priority
    - require:
      - pkg: salt-repo
      - sls: yumrepos.epel

local-salt-2016_3:
  pkgrepo.managed:
    - humanname: SaltStack 2016.3 Release Channel for RHEL/Centos $releasever
    - baseurl: {{ yumrepos.internal.repo_url_https }}/salt/2016.3/$releasever/$basearch/
    - gpgcheck: 1
    - gpgkey: {{ yumrepos.internal.rpm_gpg_url }}/SALTSTACK-GPG-KEY.pub
    - failovermethod: priority
    - require:
      - pkg: salt-repo
      - sls: yumrepos.epel

  {% endif %}

{% endif -%}


{# For CentOS 5 #}
{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '5' -%}

salt-repo:
  pkg.installed:
    - sources:
      - salt-repo: {{ saltstack_release }}

{% endif -%}
