#!/bin/bash

export $(/.env | xargs) > /dev/null
sed -i -e 's/MYSQL_SECU_PASSWORD/'`echo $MYSQL_SECU_PASSWORD`'/g' /setup.sql
mysql -u root -p`echo $MYSQL_ROOT_PASSWORD` < /setup.sql


GREEN='\033[0;32m'
NC='\033[0m'
echo "Create database secu ... ${GREEN}done${NC}";
echo "Create user secu ... ${GREEN}done${NC}";
echo "Add grant secu user only for select, insert, update and delete in secu database ... ${GREEN}done${NC}";