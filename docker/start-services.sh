#!/bin/bash
# Services für LEMP-Stack starten

# MySQL/MariaDB starten
service mysql start || service mariadb start

# PHP-FPM starten  
service php8.4-fpm start

# Nginx starten
service nginx start

# SSH-Server für Ansible
service ssh start

# Container am Leben halten
tail -f /dev/null
