# counter-mysql

Don't forget to provide a host based directory for data persistence as `/var/lib/mysql`

## How to create a database/user for a counter instance

1. log in to a container `docker exec -it <ID> bash`
1. get database and user names and password
1. run `/usr/src/copied-scripts/init-database.sh`
1. enjoy

# TODO

- figure out the best way to create databases and populate them with data
- how to backup all the stuff regularly?
