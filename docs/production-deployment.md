# Production Deployment Guide

This guide walks you through deploying WordPress on a production server using this Ansible automation.

## Prerequisites

### Control Machine (Your Local Computer)
- Ansible 6.0 or higher
- SSH client
- Git (to clone this repository)

### Target Server
- Ubuntu 24.04 LTS (recommended) or other supported OS
- Minimum 1GB RAM (2GB+ recommended)
- 10GB+ free disk space
- Root or sudo access
- SSH access enabled

## Step-by-Step Deployment

### 1. Prepare Your Server

#### Create a Non-Root User (if not exists)
```bash
# On your server, as root:
adduser deployer
usermod -aG sudo deployer

# Add passwordless sudo (optional but recommended)
echo "deployer ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/deployer
```

#### Set Up SSH Key Authentication
```bash
# On your local machine:
ssh-keygen -t ed25519 -C "your-email@example.com"
ssh-copy-id deployer@your-server.com

# Test connection:
ssh deployer@your-server.com
```

### 2. Clone and Configure

### 2. Clone and Configure

```bash
# Clone the repository
git clone https://github.com/yourusername/ansible-lemp-wordpress.git
cd ansible-lemp-wordpress

# Create your inventory from template
cp inventory/production.yml.example inventory/production.yml
```

### 3. Edit Inventory Configuration

Edit `inventory/production.yml`:

```yaml
wordpress_servers:
  hosts:
    your-domain.com:
      ansible_host: YOUR_SERVER_IP
      ansible_user: deployer
      # ansible_ssh_private_key_file: ~/.ssh/id_ed25519  # Use SSH keys
      domain_name: your-domain.com
      
      # SSL Configuration
      ssl_enabled: true
      ssl_email: admin@your-domain.com
      
      # WordPress Database (CHANGE THESE!)
      mysql_root_password: "CHANGE_ME_ROOT_PASSWORD"
      wordpress_db_name: "wordpress"
      wordpress_db_user: "wp_user"
      wordpress_db_password: "CHANGE_ME_WP_PASSWORD"
      
      # WordPress Admin (CHANGE THESE!)
      wp_admin_user: "admin"
      wp_admin_password: "CHANGE_ME_ADMIN_PASSWORD"
      wp_admin_email: "admin@your-domain.com"
      wp_site_title: "Your WordPress Site"
      
      # Ultimate Performance Features (for Ultimate playbook)
      enable_redis: true
      enable_opcache: true
```

### 4. Test Connection

```bash
ansible -i inventory/production.yml wordpress_servers -m ping
```

Expected output:
```
your-domain.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

### 5. Choose Your Deployment Mode

#### Option A: Basic LEMP Stack
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml
```

#### Option B: Ultimate Performance Stack
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

This will:
- Update system packages
- Install and configure Nginx
- Install and secure MySQL
- Install PHP with required extensions
- Configure firewall (if applicable)

### 6. Install WordPress

```bash
ansible-playbook -i inventory/production.ini playbooks/install-wordpress-official.yml
```

This will:
- Download and install WP-CLI
- Download latest WordPress
- Create wp-config.php
- Set up database and admin user
- Configure proper file permissions

### 7. Post-Deployment Steps

#### Update DNS Records
Point your domain to your server's IP address:
```
A Record: your-domain.com → YOUR_SERVER_IP
A Record: www.your-domain.com → YOUR_SERVER_IP
```

#### Set Up SSL (if enabled)
If you set `enable_ssl=true`, SSL certificates will be automatically configured via Let's Encrypt.

#### Test Your Site
- Visit: `https://your-domain.com`
- Admin: `https://your-domain.com/wp-admin`

## Security Recommendations

### 1. Change Default Passwords
Immediately change all default passwords:
- WordPress admin password
- Database passwords
- Server user passwords

### 2. Update WordPress Admin Email
Go to WordPress Admin → Settings → General and update the admin email.

### 3. Install Security Plugins
Consider installing:
- Wordfence Security
- Updraft Plus (for backups)
- iThemes Security

### 4. Server Security
```bash
# Enable automatic security updates
sudo dpkg-reconfigure -plow unattended-upgrades

# Configure firewall
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
```

### 5. Database Security
- Use strong passwords
- Limit database access to localhost only
- Regular backups

## Monitoring and Maintenance

### 1. Log Files
Monitor these log files:
- Nginx: `/var/log/nginx/access.log` and `/var/log/nginx/error.log`
- PHP-FPM: `/var/log/php8.3-fpm.log`
- MySQL: `/var/log/mysql/error.log`
- WordPress: `/var/www/html/wp-content/debug.log` (if WP_DEBUG enabled)

### 2. Regular Updates
```bash
# Update system packages
sudo apt update && sudo apt upgrade

# Update WordPress (via WP-CLI)
cd /var/www/html
sudo -u www-data wp core update --allow-root
sudo -u www-data wp plugin update --all --allow-root
sudo -u www-data wp theme update --all --allow-root
```

### 3. Backups
Set up automated backups:
- Database: `mysqldump`
- Files: `rsync` or cloud storage
- Consider using backup plugins like UpdraftPlus

### 4. Performance Monitoring
Monitor:
- Server resources (CPU, RAM, disk space)
- Website response times
- Database query performance
- Error rates

## Troubleshooting

### Connection Issues
```bash
# Test Ansible connection
ansible -i inventory/production.ini webservers -m ping

# Test SSH connection
ssh -v deployer@your-server.com
```

### Service Issues
```bash
# Check service status
sudo systemctl status nginx
sudo systemctl status mysql
sudo systemctl status php8.3-fpm

# View logs
sudo journalctl -u nginx
sudo journalctl -u mysql
sudo journalctl -u php8.3-fpm
```

### WordPress Issues
```bash
# Check WordPress installation
cd /var/www/html
sudo -u www-data wp core verify-checksums --allow-root

# Check database connection
sudo -u www-data wp db check --allow-root
```

## Scaling Considerations

### Multi-Server Setup
For high-traffic sites, consider:
- Load balancer (Nginx or HAProxy)
- Database replication or clustering
- Redis for object caching
- CDN for static assets

### Performance Optimization
- PHP OPcache configuration
- Nginx caching
- Database query optimization
- Image optimization
- Content compression

## Support

If you encounter issues:
1. Check the [Troubleshooting Guide](troubleshooting.md)
2. Review server logs
3. Open an issue on GitHub
4. Check existing discussions

---

**Next Steps**: [SSL Setup Guide](ssl-setup.md)
