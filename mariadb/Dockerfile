FROM mariadb
COPY /.env /
COPY ./mariadb/setup.sql /
COPY ./mariadb/setup.sh /
RUN chmod +x /setup.sh