# Update OpenSSL to latest
# Skip if not installed
#

{%- set pkg_name = "openssl" %}

{{ pkg_name }}:
  pkg.latest:
    - onlyif: rpm -q {{ pkg_name }}
