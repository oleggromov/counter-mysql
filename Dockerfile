FROM mysql:5.7
LABEL maintainer Oleg Gromov <hi@oleggromov.com>

COPY ./init-scripts/* /docker-entrypoint-initdb.d/
