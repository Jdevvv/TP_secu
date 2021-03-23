# TP_secu

## Docker compose information
- 2 NodeJS app connected to database with Knex.js
- Nginx load balancing round robin with HTTPS and WAF (https://github.com/theonemule/docker-waf)
- Mariadb with secu database and secu user with permission (SELECT, INSERT, UPDATE, DELETE) on unique database
- Phpmyadmin
- Env file use it to secure your password

## Components model
![image](https://user-images.githubusercontent.com/32338891/112132362-d0f05c80-8bca-11eb-8ba4-71916f58ee73.png)

### Start Docker Compose:
Set up your .env file with .env.exemple and run this command:
```
docker-compose up -d --scale node=2 --build
```
Only for the first time, execute this command after the MariaDB container is successfully started (5s):
```
docker exec -ti tp_secu_mariadb_1 /bin/bash
sh setup.sh
exit
```
To have https certificate:
```
cd nginx
apt-get install openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```

You can see the app here : [https://localhost:5100/]https://localhost:5100/)

You can see phpmyadmin here : [https://localhost:5100/phpmyadmin](https://localhost:5100/phpmyadmin)

## Test

```
https://localhost:5100/?parmas=%27%3Cscript%3Ealert(%22fdopjdf%22)%3C/script%3E
```
The WAF detect and show in /var/log/modsec_audit.log
![image](https://user-images.githubusercontent.com/32338891/112130292-a2718200-8bc8-11eb-82c1-f96aff9adf0f.png)

In `modesecurity.conf` change DetectOnly to On
```
SecRuleEngine On
```
![image](https://user-images.githubusercontent.com/32338891/112130605-f2504900-8bc8-11eb-94fe-864a30cc961d.png)


## Bug
```
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)
```
You don't wait MariaDB container is successfully started, wait and rerun the command.

```
ERROR 1007 (HY000) at line 1: Can't create database 'secu'; database exists
```
You have already run `setup.sh` before the database have already initialized. 
