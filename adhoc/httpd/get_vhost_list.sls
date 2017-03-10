# Run script that gets a list of vhosts
#

{%- if grains['osmajorrelease'] == '6' or grains['osmajorrelease'] == '7'%}

salt://adhoc/httpd/files/get_vhosts.sh:
  cmd.script:
    - onlyif:
      - test -f /usr/sbin/httpd
      - test -f /usr/bin/php

{%- endif -%}
