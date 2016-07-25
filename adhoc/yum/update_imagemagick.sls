# Update ImageMagick to latest
# Skip if not installed
#

{%- set pkg_name = "ImageMagick" %}

{{ pkg_name }}:
  pkg.latest:
    - onlyif: rpm -q {{ pkg_name }}
