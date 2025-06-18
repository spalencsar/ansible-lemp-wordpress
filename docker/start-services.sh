#!/bin/bash
# Services für LEMP-Stack starten

# MySQL starten
service mysql start

# PHP-FPM starten  
service php8.3-fpm start

# Nginx starten
service nginx start

# SSH-Server für Ansible
service ssh start

# Container am Leben halten
tail -f /dev/null
