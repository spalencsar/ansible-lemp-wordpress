# Multi-Environment Deployment Guide

This guide explains how to deploy the LEMP WordPress stack in different environments using Docker for testing and production servers for live deployment.

## 🎯 Available Deployment Modes

### Basic LEMP Mode
- **Playbook**: `playbooks/lemp-wordpress.yml`
- **Features**: Nginx, MySQL, PHP, WordPress, SSL support
- **Use Case**: Standard WordPress sites

### Ultimate Performance Mode  
- **Playbook**: `playbooks/lemp-wordpress-ultimate.yml`
- **Features**: Basic + Redis caching + PHP OPcache + Nginx optimization
- **Use Case**: High-traffic WordPress sites

## 🔧 Environment Setup

### 1. Docker Testing Environment

**Prerequisites:**
```bash
cd docker/
docker-compose up -d
```

**Inventory File (`inventory/docker.yml`):**
```yaml
wordpress_servers:
  hosts:
    docker-test:
      ansible_host: localhost
      ansible_port: 2222
      ansible_user: ansible
      ansible_ssh_pass: ansible123
      ansible_become_pass: ansible123
      domain_name: localhost
      
      # SSL Configuration (usually disabled for testing)
      ssl_enabled: false
      
      # WordPress Database (Test credentials)
      mysql_root_password: "test_root_password"
      wordpress_db_name: "wordpress"
      wordpress_db_user: "wp_user"
      wordpress_db_password: "test_wp_password"
      
      # WordPress Admin (Test credentials)
      wp_admin_user: "admin"
      wp_admin_password: "test_admin_password"
      wp_admin_email: "admin@localhost"
      wp_site_title: "Test WordPress Site"
      
      # Ultimate Features (for testing Ultimate-Playbook)
      enable_redis: true
      enable_opcache: true
```

**Deploy Commands:**
```bash
# Test Basic LEMP deployment
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Test Ultimate Performance deployment
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress-ultimate.yml
```

**Access:** http://localhost:8080

### 2. Production Server Deployment

**Inventory File (`inventory/production.yml`):**
```yaml
wordpress_servers:
  hosts:
    your-server.example.com:
      ansible_host: YOUR_SERVER_IP
      ansible_user: your_user
      domain_name: example.com
      
      # SSL Configuration
      ssl_enabled: true  # Enable HTTPS
      ssl_email: admin@example.com
      
      # WordPress Database (CHANGE THESE!)
      mysql_root_password: "CHANGE_ME_ROOT_PASSWORD"
      wordpress_db_name: "wordpress"
      wordpress_db_user: "wp_user"
      wordpress_db_password: "CHANGE_ME_WP_PASSWORD"
      
      # WordPress Admin (CHANGE THESE!)
      wp_admin_user: "admin"
      wp_admin_password: "CHANGE_ME_ADMIN_PASSWORD"
      wp_admin_email: "admin@example.com"
      wp_site_title: "My WordPress Site"
      
      # Ultimate Performance Features
      enable_redis: true      # For Ultimate playbook
      enable_opcache: true    # For Ultimate playbook
```

**Deploy Commands:**
```bash
# Basic LEMP deployment
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Ultimate Performance deployment
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

### 3. Staging Environment

**Inventory File (`inventory/staging.yml`):**
```yaml
wordpress_servers:
  hosts:
    staging.example.com:
      ansible_host: 192.168.1.100
      ansible_user: deploy
      domain_name: staging.example.com
      
      # SSL Configuration
      ssl_enabled: false  # Disable for staging
      
      # WordPress Database
      mysql_root_password: "staging_root_password"
      wordpress_db_name: "wordpress_staging"
      wordpress_db_user: "wp_staging"
      wordpress_db_password: "staging_wp_password"
      
      # WordPress Admin
      wp_admin_user: "staging_admin"
      wp_admin_password: "staging_admin_password"
      wp_admin_email: "staging@example.com"
      wp_site_title: "Staging WordPress Site"
      
      # Ultimate Features (test performance features)
      enable_redis: true
      enable_opcache: true
```

## 🎛️ Advanced Configuration

### 1. SSL/HTTPS Setup

**Enable SSL during deployment:**
```bash
# Basic LEMP with SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" -e "ssl_email=your-email@domain.com"

# Ultimate Performance with SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "ssl_enabled=true" -e "ssl_email=your-email@domain.com"
```

### 2. Performance Tuning Overrides

**Custom PHP settings:**
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "php_memory_limit=1G" \
  -e "php_upload_max_filesize=256M"
```

**Custom Redis settings:**
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "redis_maxmemory=512mb"
```

### 3. Security with Ansible Vault

**For production environments, use Ansible Vault:**

**Create vault file:**
```bash
mkdir -p group_vars/all/
ansible-vault create group_vars/all/vault.yml
```

**Update inventory to use vault variables:**
```yaml
wordpress_servers:
  hosts:
    your-server.example.com:
      # ... other settings ...
      
      # Database (using vault)
      mysql_root_password: "{{ vault_mysql_root_password }}"
      wordpress_db_password: "{{ vault_wordpress_db_password }}"
      wp_admin_password: "{{ vault_wp_admin_password }}"
```

**Deploy with vault:**
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass
```

See [Vault Security Guide](vault.md) for detailed instructions.

## 🚀 Common Deployment Scenarios

### Scenario 1: Local Development & Testing
```bash
# Start Docker environment
cd docker/
docker-compose up -d

# Test Basic LEMP
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Test Ultimate Performance
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress-ultimate.yml

# Access: http://localhost:8080
```

### Scenario 2: Cloud Server (DigitalOcean, AWS, Linode)
```bash
# Configure inventory/production.yml with your server details

# Deploy with SSL for production
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "ssl_enabled=true" -e "ssl_email=admin@yourdomain.com"
```

### Scenario 3: On-Premises Server
```bash
# Deploy without SSL for internal network
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=false"
```

### Scenario 4: High-Performance WordPress
```bash
# Ultimate deployment with custom performance settings
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "php_memory_limit=1G" \
  -e "redis_maxmemory=512mb" \
  -e "ssl_enabled=true"
```

## 🔍 Troubleshooting Multi-Environment Issues

### Problem: Docker container not accessible
**Solution:** Check Docker setup
```bash
cd docker/
docker-compose ps
docker-compose logs
```

### Problem: SSH connection to production server fails
**Solution:** Verify SSH settings
```bash
# Test SSH connection
ssh -p 22 your_user@your_server_ip

# Check inventory file SSH settings
ansible all -i inventory/production.yml -m ping
```

### Problem: SSL certificate generation fails
**Solution:** Check domain and email
```bash
# Ensure domain points to your server
nslookup yourdomain.com

# Deploy with valid email
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" -e "ssl_email=valid-email@domain.com"
```

### Problem: Redis not working in Ultimate mode
**Solution:** Check if Ultimate playbook is being used
```bash
# Make sure you're using the Ultimate playbook
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

## 📝 Best Practices

### Development
1. **Always test in Docker first** before deploying to production
2. **Use docker.yml inventory** for local testing
3. **Enable all Ultimate features** in Docker for testing

### Production  
1. **Use strong passwords** or Ansible Vault
2. **Enable SSL/HTTPS** for production sites
3. **Choose appropriate deployment mode** (Basic vs Ultimate)
4. **Regular backups** of database and files
5. **Keep system updated** with security patches

### Security
1. **Never commit real passwords** to Git
2. **Use SSH keys** instead of passwords
3. **Enable firewall** on production servers
4. **Regular security updates**

## 🎯 Quick Reference

### Available Playbooks
| Playbook | Features | Use Case |
|----------|----------|----------|
| `lemp-wordpress.yml` | Basic LEMP + WordPress + SSL | Small to medium sites |
| `lemp-wordpress-ultimate.yml` | Basic + Redis + OPcache + Optimization | High-traffic sites |

### Environment Files
| File | Purpose | Use Case |
|------|---------|----------|
| `inventory/docker.yml` | Docker testing | Development/Testing |
| `inventory/production.yml` | Production server | Live deployment |

### Key Variables
| Variable | Purpose | Example |
|----------|---------|---------|
| `ssl_enabled` | Enable/disable HTTPS | `true` or `false` |
| `enable_redis` | Enable Redis caching | `true` (Ultimate only) |
| `enable_opcache` | Enable PHP OPcache | `true` (Ultimate only) |
| `mysql_root_password` | MySQL root password | `"SecurePassword123!"` |
| `wp_admin_password` | WordPress admin password | `"AdminPassword456!"` |
