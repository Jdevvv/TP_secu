# TP_secu

## Docker compose
- 2 Node app 
- Nginx load balancing round robin 
- Mariadb with secu database and secu user

### Start Docker Compose:
Set up your .env file and run this command:
```
docker-compose up -d --scale node=2 --build
```
Only for the first time, execute this command after the MariaDB container is successfully started (5s):
```
docker exec -ti tp_secu_mariadb_1 /bin/bash
sh setup.sh
exit
```

You can see the app here : [http://localhost:5100/](http://localhost:5100/)

You can see phpmyadmin here : [http://localhost:5100/phpmyadmin](http://localhost:5100/phpmyadmin)

## Single node app
Install dependencies:

```
npm install
```

Run the app:

```
npm run start
```

## Bug
```
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/run/mysqld/mysqld.sock' (2)
```
You don't wait MariaDB container is successfully started, wait and rerun the command.

```
ERROR 1007 (HY000) at line 1: Can't create database 'secu'; database exists
```
You have already run `setup.sh` before the database have already initialized. 
