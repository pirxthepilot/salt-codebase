include:
  - time.timezone

{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '7'%}
  - time.chrony
{%- endif -%}

{%- if grains['os'] == 'CentOS' and grains['osmajorrelease'] == '6'%}
  - time.ntp
{%- endif -%}
