{# CentOS 6 and 7 support only #}
{%- if grains['os'] == 'CentOS' and (grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7') -%}


{%- import_yaml "yumrepos/defaults.yaml" as default_settings -%}
{%- set yumrepos = salt['pillar.get']('yumrepos', default=default_settings.yumrepos, merge=True) -%}


# CentOS repositories - base, updates and extras
# Note: Unlike the other repos, setting use_internal to True will
# rename CentOS-Base.repo to CentOS-Base.repo.off


  {%- if yumrepos.use_internal is sameas false %}

local-centos-base:
  pkgrepo.absent

local-centos-updates:
  pkgrepo.absent

local-centos-extras:
  pkgrepo.absent

CentOS-Base.repo:
  file.rename:
    - name: /etc/yum.repos.d/CentOS-Base.repo
    - source: /etc/yum.repos.d/CentOS-Base.repo.off
    - force: True
    - require:
      - pkgrepo: local-centos-base
      - pkgrepo: local-centos-updates
      - pkgrepo: local-centos-extras

  {% else %}

CentOS-Base.repo:
  file.rename:
    - name: /etc/yum.repos.d/CentOS-Base.repo.off
    - source: /etc/yum.repos.d/CentOS-Base.repo
    - force: True

local-centos-base:
  pkgrepo.managed:
    - humanname: CentOS-$releasever - Base
    - baseurl: {{ yumrepos.internal.repo_url_http }}/centos/$releasever/os/$basearch/
    - priority: 1
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
    - require:
      - file: CentOS-Base.repo

local-centos-updates:
  pkgrepo.managed:
    - humanname: CentOS-$releasever - Updates
    - baseurl: {{ yumrepos.internal.repo_url_http }}/centos/$releasever/updates/$basearch/
    - priority: 1
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
    - require:
      - pkgrepo: local-centos-base

local-centos-extras:
  pkgrepo.managed:
    - humanname: CentOS-$releasever - Extras
    - baseurl: {{ yumrepos.internal.repo_url_http }}/centos/$releasever/extras/$basearch/
    - priority: 1
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever
    - require:
      - pkgrepo: local-centos-base

  {% endif %}


{% endif %}
