# Update Percona server, mariadb-server, or mysql55-mysql-server 
# and skip if package is not installed

# NOTE: mysql service is automatically restarted during the
# rpm update itself


{%- set packagelist = ["Percona-Server-server-55",
                       "Percona-Server-client-55",
                       "Percona-Server-shared-55",
                       "Percona-Server-server-56",
                       "Percona-Server-client-56",
                       "Percona-Server-shared-56",
                       "Percona-Server-server-57",
                       "Percona-Server-client-57",
                       "Percona-Server-shared-57",
                       "mysql-server",
                       "mariadb-server",
                       "mysql55-mysql-server"] %}

{% for pkg_name in packagelist %}

  {% if salt['cmd.retcode']('rpm -q ' ~ pkg_name, python_shell=True) == 0 %}

{{ pkg_name }}:
  pkg.latest: []

  {% endif %}

{% endfor -%}
