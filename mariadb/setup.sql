CREATE DATABASE secu;
CREATE USER secu IDENTIFIED BY 'MYSQL_SECU_PASSWORD';
GRANT USAGE ON *.* TO 'secu'@'%' IDENTIFIED BY 'MYSQL_SECU_PASSWORD';
GRANT SELECT, INSERT, UPDATE, DELETE ON `secu`.* TO secu;
FLUSH PRIVILEGES;
CREATE TABLE `user`
(
    id        int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname varchar(35)  NOT NULL,
    lastname  varchar(35)  NOT NULL,
    birthdate date         NOT NULL,
    email     varchar(255) NOT NULL,
    phone     varchar(15)  NOT NULL,
    address   varchar(95)  NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;