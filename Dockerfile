FROM mysql:5.7
LABEL maintainer Oleg Gromov <hi@oleggromov.com>

# copying script helping create databases
RUN mkdir -p /usr/src/copied-scripts
WORKDIR /usr/src/app

COPY ./init-database.sh /usr/src/copied-scripts
COPY ./config/* /etc/mysql/conf.d
