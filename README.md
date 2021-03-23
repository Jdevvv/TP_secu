# TP_secu

## Docker compose information
- 2 NodeJS app connected to database with Knex.js
- Nginx load balancing round robin with HTTPS and WAF
- Mariadb
- Phpmyadmin
- Env file 

## Why use this configuration
- Knex.js (http://knexjs.org/)
   - Simple and light SQL builder allowing to easily make queries to the database while preventing SQL injections
- Nginx load balancing round robin (http://nginx.org/en/docs/http/load_balancing.html)
   - Easy to implement and conceptualize, round robin is the most widely deployed load balancing algorithm. Using this method, client requests are routed to available servers on a cyclical basis. Round robin server load balancing works best when servers have roughly identical computing capabilities and storage capacity.
- WAF (https://github.com/theonemule/docker-waf)
  - A Web Application Firewall (WAF) is a purpose-built firewall designed to protect against attacks common to web apps. One of the most widely used WAF’s is ModSecurity. Originally, it was written as a module for the Apache webserver, but it has since been ported to NGINX and IIS. ModSecurity protects against attacks by looking for:
    - SQL Injection
    - Insuring the content type matches the body data.
    - Protection against malformed POST requests.
    - HTTP Protocol Protection
    - Real-time Blacklist Lookups
    - HTTP Denial of Service Protections
    - Generic Web Attack Protection
     - Error Detection and Hiding
- Mariadb (https://hub.docker.com/_/mariadb)
  - Encrypt database and user with permission (SELECT, INSERT, UPDATE, DELETE) on unique database
- Env file (https://docs.docker.com/compose/environment-variables/)
   - Use it to secure your password with prevent bad handling with git

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
The WAF detect and show in `/var/log/modsec_audit.log`

![image](https://user-images.githubusercontent.com/32338891/112130292-a2718200-8bc8-11eb-82c1-f96aff9adf0f.png)

In `modesecurity.conf` change `DetectOnly` to `On`
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
