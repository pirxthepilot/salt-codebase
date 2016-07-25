# Update glibc to fix occassional ssh
# login issues
# https://bugzilla.redhat.com/show_bug.cgi?id=1261023

# Skip if not installed
#

{%- set pkg_name = "glibc" %}

include:
  - openssh
  - realmd

{{ pkg_name }}:
  pkg.latest:
    - onlyif: rpm -q {{ pkg_name }}
    - watch_in:
      - service: sshd
      - service: sssd
