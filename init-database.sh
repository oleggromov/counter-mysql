#!/bin/bash

read -p "mysql Database name: " MYSQL_DATABASE
read -p "Username: " MYSQL_USERNAME
read -s -p "Password: " MYSQL_PASSWORD

FILENAME="/tmp/mysql-$(date +%s).sql"

cat > $FILENAME <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER '${MYSQL_USERNAME}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\` . * TO '${MYSQL_USERNAME}'@'%';
FLUSH PRIVILEGES;

USE \`${MYSQL_DATABASE}\`;

CREATE TABLE IF NOT EXISTS \`users\` (
	\`id\` INT NOT NULL AUTO_INCREMENT,
	\`facebookId\` VARCHAR(128) NOT NULL UNIQUE,
	PRIMARY KEY (\`id\`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS \`lists\` (
	\`id\` INT NOT NULL AUTO_INCREMENT,
	\`name\` TEXT NOT NULL,
	PRIMARY KEY (\`id\`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS \`permissions\` (
	\`userId\` INT NOT NULL,
	\`listId\` INT NOT NULL,
	PRIMARY KEY (\`userId\`, \`listId\`),
	FOREIGN KEY (\`userId\`) REFERENCES \`users\`(\`id\`),
	FOREIGN KEY (\`listId\`) REFERENCES \`lists\`(\`id\`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS \`items\` (
	\`id\` INT NOT NULL AUTO_INCREMENT,
	\`listId\` INT NOT NULL,
	\`name\` TEXT NOT NULL,
	\`date\` BIGINT UNSIGNED NOT NULL,
	\`value\` DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (\`id\`),
	FOREIGN KEY (\`listId\`) REFERENCES \`lists\`(\`id\`)
) ENGINE=InnoDB;
EOF

mysql -u root -p"$MYSQL_ROOT_PASSWORD" < $FILENAME

unset MYSQL_DATABASE
unset MYSQL_USERNAME
unset MYSQL_PASSWORD
rm $FILENAME
