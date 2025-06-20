# Troubleshooting Guide

Common issues and their solutions when using the LEMP WordPress automation.

## Connection Issues

### Ansible Connection Problems

**SSH Connection Refused:**
```bash
# Check if SSH service is running on target server
sudo systemctl status ssh
sudo systemctl start ssh

# Verify SSH port (default 22)
sudo netstat -tlnp | grep :22

# Test connection manually
ssh your_user@your_server_ip
```

**Permission Denied (publickey):**
```bash
# Use password authentication (if enabled in inventory)
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Or set up SSH keys (recommended)
ssh-keygen -t ed25519 -C "your-email@example.com"
ssh-copy-id your_user@your_server_ip

# Test SSH connection
ssh your_user@your_server_ip
```

**Host Key Verification Failed:**
```bash
# Remove old host key
ssh-keygen -R your_server_ip

# Or disable host key checking temporarily (not recommended for production)
export ANSIBLE_HOST_KEY_CHECKING=False
```

**Inventory File Syntax Error:**
```bash
# Validate inventory syntax
ansible-inventory -i inventory/production.yml --list

# Test connection to all hosts
ansible -i inventory/production.yml wordpress_servers -m ping
```

## Deployment Issues

### Package Installation Failures

**Package Not Found:**
```bash
# Update package cache on target server
sudo apt update

# Check if universe repository is enabled (Ubuntu)
sudo add-apt-repository universe
sudo apt update
```

**Lock Error (dpkg/apt):**
```bash
# Kill any running package managers on target server
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
### WordPress Issues

**WordPress Installation Fails:**
```bash
# Check if WP-CLI is installed
wp --info

# Check WordPress directory permissions
ls -la /var/www/html/ 
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Verify wp-config.php
cat /var/www/html/wp-config.php
```

**Database Connection Error:**
```bash
# Test database connection from WordPress
mysql -u wp_user -p wordpress

# Check credentials in wp-config.php match inventory
grep DB_ /var/www/html/wp-config.php

# Verify database user exists
mysql -u root -p -e "SELECT user,host FROM mysql.user WHERE user='wp_user';"
```

### SSL/HTTPS Issues

**SSL Certificate Generation Fails:**
```bash
# Check if domain points to server
nslookup your-domain.com

# Verify firewall allows HTTP/HTTPS
sudo ufw status
sudo ufw allow 80
sudo ufw allow 443

# Check if ports are accessible
curl -I http://your-domain.com
```

**Mixed Content Warnings:**
```bash
# Update WordPress URLs in database
mysql -u root -p wordpress -e "UPDATE wp_options SET option_value = 'https://your-domain.com' WHERE option_name = 'home';"
mysql -u root -p wordpress -e "UPDATE wp_options SET option_value = 'https://your-domain.com' WHERE option_name = 'siteurl';"

# Or use WP-CLI
wp search-replace 'http://your-domain.com' 'https://your-domain.com' --dry-run
wp search-replace 'http://your-domain.com' 'https://your-domain.com'
```

## Performance Issues (Ultimate Mode)

### Redis Issues

**Redis Not Working:**
```bash
# Check Redis status
sudo systemctl status redis-server

# Test Redis connection
redis-cli ping

# Check Redis configuration
sudo cat /etc/redis/redis.conf | grep -v "^#" | grep -v "^$"
```

**WordPress Not Using Redis:**
```bash
# Check if Redis object cache plugin is active
wp plugin list --status=active

# Verify Redis cache is working
redis-cli monitor
# Then browse your WordPress site and watch for Redis activity
```

### PHP OPcache Issues

**OPcache Not Working:**
```bash
# Check if OPcache is loaded
php -m | grep -i opcache

# Check OPcache status
php -r "print_r(opcache_get_status());"

# Check PHP configuration
php --ini
grep opcache /etc/php/*/fpm/php.ini
```

## Service Management

### Restart All Services
```bash
# Restart all LEMP services
sudo systemctl restart nginx
sudo systemctl restart mysql  
sudo systemctl restart php8.3-fpm

# For Ultimate mode, also restart Redis
sudo systemctl restart redis-server
```

### Check Service Status
```bash
# Check all service statuses
sudo systemctl status nginx mysql php8.3-fpm

# For Ultimate mode
sudo systemctl status redis-server
```
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
