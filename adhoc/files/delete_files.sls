{%- import_yaml "adhoc/files/filelist.yaml" as filelist -%}
{%- set files = filelist.files -%}

# Delete files defined in filelist.yaml
#


{%- for file in files %}

{{ file }}:
  file.absent:
    - onlyif:
      - /usr/bin/test -f {{ file }}

{%- endfor -%}
