CREATE DATABASE db_user;
GRANT ALL PRIVILEGES ON db_user.* TO "db_user"@"localhost" IDENTIFIED BY "db_password";
FLUSH PRIVILEGES;