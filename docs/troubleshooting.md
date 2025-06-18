# Troubleshooting Guide

Common issues and their solutions when using the LEMP WordPress automation.

## Installation Issues

### Ansible Connection Problems

**SSH Connection Refused:**
```bash
# Check if SSH service is running
sudo systemctl status ssh
sudo systemctl start ssh

# Verify SSH port (default 22)
sudo netstat -tlnp | grep :22
```

**Permission Denied (publickey):**
```bash
# Use password authentication temporarily
ansible-playbook -i inventory/production playbooks/lemp-wordpress.yml --ask-pass

# Or set up SSH keys
ssh-copy-id username@your-server
```

**Host Key Verification Failed:**
```bash
# Remove old host key
ssh-keygen -R your-server-ip

# Or disable host key checking temporarily
export ANSIBLE_HOST_KEY_CHECKING=False
```

### Package Installation Failures

**Package Not Found:**
```bash
# Update package cache first
sudo apt update

# Check if universe repository is enabled (Ubuntu)
sudo add-apt-repository universe
```

**Lock Error (dpkg/apt):**
```bash
# Kill any running package managers
sudo killall apt apt-get dpkg

# Remove locks
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock*

# Reconfigure packages
sudo dpkg --configure -a
```

## Service Issues

### Nginx Problems

**Nginx Won't Start:**
```bash
# Check configuration syntax
sudo nginx -t

# Check what's using port 80
sudo netstat -tlnp | grep :80
sudo lsof -i :80

# Check logs
sudo journalctl -u nginx -f
```

**403 Forbidden Error:**
```bash
# Check file permissions
ls -la /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Check Nginx user in config
grep user /etc/nginx/nginx.conf
```

### MySQL/MariaDB Issues

**MySQL Won't Start:**
```bash
# Check MySQL status and logs
sudo systemctl status mysql
sudo journalctl -u mysql -f

# Check disk space
df -h

# Reset MySQL if corrupted
sudo systemctl stop mysql
sudo mysqld_safe --skip-grant-tables &
```

**Can't Connect to Database:**
```bash
# Test MySQL connection
mysql -u root -p
mysql -u wordpress_user -p wordpress_db

# Check user privileges
mysql -u root -p -e "SELECT user,host FROM mysql.user;"
mysql -u root -p -e "SHOW GRANTS FOR 'wordpress_user'@'localhost';"
```

**Access Denied for User:**
```bash
# Reset WordPress database user
mysql -u root -p
DROP USER IF EXISTS 'wordpress_user'@'localhost';
CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'localhost';
FLUSH PRIVILEGES;
```

### PHP-FPM Issues

**PHP-FPM Not Working:**
```bash
# Check PHP-FPM status
sudo systemctl status php8.3-fpm

# Check socket file
ls -la /run/php/php8.3-fpm.sock

# Check PHP-FPM configuration
sudo nginx -t
sudo php-fpm8.3 -t
```

**PHP Errors in WordPress:**
```bash
# Enable PHP error logging
sudo tail -f /var/log/php8.3-fpm.log

# Check WordPress debug
# Add to wp-config.php:
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);

# Check WordPress logs
tail -f /var/www/html/wp-content/debug.log
```

## WordPress Issues

### WordPress Installation Problems

**White Screen of Death:**
```bash
# Check PHP errors
sudo tail -f /var/log/php8.3-fpm.log
sudo tail -f /var/log/nginx/error.log

# Increase PHP memory limit
sudo nano /etc/php/8.3/fpm/php.ini
# memory_limit = 256M

sudo systemctl restart php8.3-fpm
```

**Database Connection Error:**
```bash
# Verify wp-config.php settings
sudo cat /var/www/html/wp-config.php

# Test database connection manually
mysql -u wordpress_user -p wordpress_db
```

**File Permissions Issues:**
```bash
# Set correct WordPress permissions
sudo chown -R www-data:www-data /var/www/html/
sudo find /var/www/html/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/ -type f -exec chmod 644 {} \;
sudo chmod 600 /var/www/html/wp-config.php
```

### Performance Issues

**Slow Website Loading:**
```bash
# Enable PHP OPcache
sudo nano /etc/php/8.3/fpm/php.ini
# opcache.enable=1
# opcache.memory_consumption=128

# Optimize MySQL
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
# innodb_buffer_pool_size = 256M

# Enable Nginx gzip
sudo nano /etc/nginx/nginx.conf
# gzip on;
```

## Security Issues

### File Permission Problems

**Incorrect Ownership:**
```bash
# WordPress files should be owned by www-data
sudo chown -R www-data:www-data /var/www/html/

# wp-config.php should have restricted permissions
sudo chmod 600 /var/www/html/wp-config.php
```

**Upload Directory Issues:**
```bash
# Create uploads directory if missing
sudo mkdir -p /var/www/html/wp-content/uploads
sudo chown www-data:www-data /var/www/html/wp-content/uploads
sudo chmod 755 /var/www/html/wp-content/uploads
```

## Network Issues

### Firewall Configuration

**Can't Access Website:**
```bash
# Check if UFW is blocking
sudo ufw status
sudo ufw allow 80
sudo ufw allow 443

# Check iptables
sudo iptables -L
```

**Domain/DNS Issues:**
```bash
# Test DNS resolution
nslookup yourdomain.com
dig yourdomain.com

# Test local access
curl -I http://localhost
curl -I http://your-server-ip
```

## Log Files Locations

Important log files for debugging:

- **Nginx Access:** `/var/log/nginx/access.log`
- **Nginx Error:** `/var/log/nginx/error.log`
- **PHP-FPM:** `/var/log/php8.3-fpm.log`
- **MySQL:** `/var/log/mysql/error.log`
- **WordPress:** `/var/www/html/wp-content/debug.log`
- **System:** `journalctl -f`

## Getting Help

1. **Check the logs first** - Most issues show up in the relevant log files
2. **Test each component individually** - Nginx, PHP, MySQL, WordPress
3. **Verify configuration files** - Use built-in syntax checkers
4. **Check file permissions** - Many issues are permission-related
5. **Open an issue** on GitHub with relevant log output

## Common Commands

```bash
# Restart all services
sudo systemctl restart nginx php8.3-fpm mysql

# Check all service status
sudo systemctl status nginx php8.3-fpm mysql

# Test configurations
sudo nginx -t
sudo php-fpm8.3 -t

# Monitor logs in real-time
sudo tail -f /var/log/nginx/error.log /var/log/php8.3-fpm.log
```
