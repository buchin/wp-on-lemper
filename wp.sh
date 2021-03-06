#!/bin/bash

#thanks for the tutorial on http://c3mdigital.com/2011/07/22/wordpress-performance-server/5/ by c3mdigital
echo "in what domain wordpress should be installed?"
read domain
echo "what is the username of the database?"
read db_user
echo "what is the password of the database?"
read db_password

mkdir "$domain"
cd "$domain"
echo "configuring installer"
sed "s/your_domain.com/$domain/g" ../install.sh > install.sh

echo "configuring domain config"
sed "s/your_domain.com/$domain/g" ../domain.conf > domain.conf

echo "configuring database installer"

sed "s/db_user/$db_user/g" ../db.sql > db.sql
sed "s/db_password/$db_password/g" db.sql > db.sql.new
rm db.sql
mv db.sql.new db.sql

cp ../db.sh .

sh install.sh
echo "please enter your database root password"
sh db.sh

echo "finish"
cd ..

/etc/init.d/nginx restart
/etc/init.d/mysql restart
/etc/init.d/php5-fpm restart
/etc/init.d/varnish restart