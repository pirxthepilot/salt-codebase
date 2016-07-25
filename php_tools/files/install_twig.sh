#!/bin/sh
# Twig installer: A Saltscript

PKGNAME='twig/Twig'

# Check first if twig is installed
/bin/pear info $PKGNAME

if [ "$?" -eq 0 ]; then

  echo
  echo "changed=no comment='Twig already installed'"

else

  /bin/pear channel-discover pear.twig-project.org
  /bin/pear install twig/Twig

  echo
  echo "changed=yes comment='Twig installed'"

fi
