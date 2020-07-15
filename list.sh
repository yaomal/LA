#/bin/sh
find /var/www/html/ -type f -iname "*.php" -exec cp {} /opt/html/ ;
