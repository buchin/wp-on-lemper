#!/bin/bash

echo "start installing WordPress for LEMPER"
echo "creating directories for your_domain.com"
mkdir -p /srv/www /srv/www/your_domain.com /srv/www/your_domain.com/public /srv/www/your_domain.com/logs

echo "creating nginx.conf for domain"
touch /srv/www/your_domain.com/public/nginx.conf

echo "downloading wordpress"
curl http://wordpress.org/latest.zip > /srv/www/your_domain.com/public/latest.zip

echo "uncompress wordpress"
unzip /srv/www/your_domain.com/public/latest.zip -d /srv/www/your_domain.com/public > /dev/null
mv /srv/www/your_domain.com/public/wordpress/* /srv/www/your_domain.com/public
rmdir /srv/www/your_domain.com/public/wordpress
rm /srv/www/your_domain.com/public/latest.zip

echo "change wordpress permissions"
chown www-data:www-data /srv/www/your_domain.com/public/ -R

echo "copying basic config file for your_domain.com" 
mv  domain.conf /etc/nginx/sites-available/your_domain.com

echo "enabling site"
ln -s /etc/nginx/sites-available/your_domain.com /etc/nginx/sites-enabled/your_domain.com

echo "restarting nginx"
/etc/init.d/nginx start 