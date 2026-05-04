# Ansible LEMP WordPress Automation

🚀 **Production-ready, fully automated LEMP stack (Linux, Nginx, MySQL, PHP) + WordPress deployment using Ansible**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%20|%2022.04%20|%2024.04%20|%2025.04-orange)](https://ubuntu.com/)
[![Debian](https://img.shields.io/badge/Debian-11%20|%2012%20|%2013%20|%2014-red)](https://debian.org/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-7.0+-blue)](https://wordpress.org/)

## 🌐 Other Languages

- [🇩🇪 Deutsch](docs/README.de.md)
- [🇭🇺 Magyar](docs/README.hu.md)

## 🎯 Features

### 🏗️ Core Infrastructure
✅ **Complete LEMP Stack Installation**
- Nginx web server with production-ready optimization
- MySQL 8.0+ with secure setup and performance tuning
- PHP 8.4+ with FPM, OPcache and WordPress extensions
- Ubuntu/Debian family support (20.04, 22.04, 24.04, 25.04, Debian 11, 12, 13, 14)

### 🛡️ WordPress & Security
✅ **WordPress Automation & Security**
- Latest WordPress installation with WP-CLI integration
- Automatic database setup and secure configuration
- **Integrated SSL/HTTPS support** with Let's Encrypt
- Security hardening (proper file permissions, secure configurations)

### ⚡ Performance & Caching
✅ **Ultimate Performance Optimizations**
- **Redis object caching** for database optimization
- **PHP OPcache** configuration for improved performance
- **MySQL performance tuning** with optimized configurations
- **Nginx optimization** with gzip, caching headers and worker tuning

### 🔧 Production Features
✅ **Production & Development Ready**
- **Two deployment modes**: Basic LEMP + Ultimate Performance
- Docker testing environment for safe testing
- **Modular, clean architecture** - production-tested and documented
- **Idempotent playbooks** (safe to run multiple times)
- **SSL support integrated** in both deployment modes

## 🚀 Quick Start

### Prerequisites

- **Control Machine**: Ansible 6.0+ installed
- **Target Server**: Ubuntu 20.04+ or Debian 11+ with SSH access and sudo privileges
- **Network**: SSH access (port 22) and web access (ports 80/443)

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/ansible-lemp-wordpress.git
cd ansible-lemp-wordpress
```

### 2. Configure Inventory

```bash
cp inventory/production.yml.example inventory/production.yml
# Edit inventory/production.yml with your server details
```

### 3. Choose Your Deployment Mode

#### Option A: Basic LEMP + WordPress
```bash
# Standard LEMP stack with WordPress
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml
```

#### Option B: Ultimate Performance Setup
```bash
# LEMP + WordPress + Redis + OPcache + Nginx optimization
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

#### Option C: With SSL/HTTPS
```bash
# Enable SSL during deployment
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" -e "ssl_email=your-email@domain.com"

# Or with Ultimate Performance + SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "ssl_enabled=true" -e "ssl_email=your-email@domain.com"
```

### 4. Access Your WordPress Site

- **Website**: `http://your-server-ip` (or `https://` if SSL enabled)
- **Admin Panel**: `http://your-server-ip/wp-admin`
- **Default Login**: Check your inventory file for `wp_admin_user` and `wp_admin_password`

## 🐳 Docker Testing Environment

Perfect for testing before deploying to production servers:

```bash
cd docker/
docker-compose up -d

# Test Basic LEMP deployment
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Test Ultimate Performance deployment
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress-ultimate.yml
```

Access test site: http://localhost:8080

## 📁 Project Structure

```
ansible-lemp-wordpress/
├── playbooks/                    # Main Ansible playbooks (PRODUCTION-READY)
│   ├── lemp-wordpress.yml           # Basic LEMP + WordPress deployment
│   └── lemp-wordpress-ultimate.yml  # Ultimate: LEMP + WordPress + Redis + OPcache + Optimization
├── inventory/                    # Server inventory configurations
│   ├── production.yml               # Production server configuration
│   └── docker.yml                   # Docker test environment
├── templates/                    # Jinja2 configuration templates (PRODUCTION-TESTED)
│   ├── wp-config.php.j2            # WordPress configuration
│   ├── wordpress.nginx.j2          # Nginx virtual host (HTTP)
│   ├── wordpress-ssl.nginx.j2      # Nginx virtual host (HTTPS)
│   ├── my.cnf.j2                   # MySQL configuration
│   └── www.conf.j2                 # PHP-FPM pool configuration
├── vars/                        # OS-specific variables
│   └── debian-family.yml           # Debian/Ubuntu variables
├── docker/                      # Docker testing environment
│   ├── docker-compose.yml          # Docker setup
│   ├── Dockerfile                  # Ubuntu test container
│   └── start-services.sh           # Service startup script
└── docs/                        # Documentation
    ├── production-deployment.md
    ├── ssl-setup.md
    └── troubleshooting.md
```

## ⚙️ Configuration

### Deployment Modes

**Basic LEMP Mode** (`lemp-wordpress.yml`)
- Standard LEMP stack (Nginx, MySQL, PHP)
- WordPress with WP-CLI
- SSL support (optional)
- Suitable for small to medium sites

**Ultimate Performance Mode** (`lemp-wordpress-ultimate.yml`) 
- Everything from Basic mode, plus:
- Redis object caching
- PHP OPcache optimization
- Nginx performance tuning
- MySQL optimization
- Suitable for high-traffic sites

### SSL Configuration

Both deployment modes support SSL:

```yaml
# In inventory/production.yml
wordpress_servers:
  hosts:
    your-server:
      ansible_host: your-ip
      ssl_enabled: true
      ssl_email: your-email@domain.com
```

### Variable Configuration

**Essential WordPress Variables:**
```yaml
# WordPress Admin
wp_admin_user: admin              # WordPress admin username
wp_admin_password: "{{ vault_wp_admin_password }}"  # Use Ansible Vault!
wp_admin_email: admin@domain.com  # WordPress admin email
wp_site_title: "My WordPress Site"

# Database
mysql_root_password: "{{ vault_mysql_root_password }}"    # Use Ansible Vault!
wordpress_db_name: wordpress
wordpress_db_user: wordpress
wordpress_db_password: "{{ vault_wordpress_db_password }}" # Use Ansible Vault!

# SSL (optional)
ssl_enabled: false
ssl_email: admin@domain.com
```

**Performance Variables (Ultimate Mode):**
```yaml
# Redis Configuration
redis_enabled: true
redis_maxmemory: 256mb

# PHP Optimization
php_memory_limit: 512M
php_upload_max_filesize: 128M
php_opcache_enabled: true

# Nginx Optimization
nginx_worker_processes: auto
nginx_optimization_enabled: true
```
### Server Requirements

- **OS**: Ubuntu 20.04+ or Debian 11+
- **RAM**: Minimum 1GB (2GB+ recommended for Ultimate mode)
- **Storage**: Minimum 10GB free space
- **Network**: SSH access + web ports (80/443)

## 🔒 Security & Best Practices

### Security Features
- **Secure password handling** with Ansible Vault
- **Proper file permissions** for WordPress and system files
- **MySQL security** with custom root password and restricted access
- **Nginx security headers** and configuration hardening
- **SSL/HTTPS support** with Let's Encrypt integration

### Best Practices
```bash
# Use Ansible Vault for sensitive data
ansible-vault create inventory/group_vars/all/vault.yml

# Example vault.yml content:
vault_mysql_root_password: "your-secure-mysql-password"
vault_wp_admin_password: "your-secure-wp-password"
vault_wordpress_db_password: "your-secure-db-password"

# Deploy with vault
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass
```

## 🧪 Testing

### Pre-deployment Testing
```bash
# Test with Docker first
cd docker/
docker-compose up -d
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Access test environment
curl -I http://localhost:8080/
```

### Validation Commands
```bash
# Check WordPress installation
curl -s http://your-server/ | grep "WordPress"

# Test admin access
curl -I http://your-server/wp-admin/

# Check PHP version
ansible all -i inventory/production.yml -m shell -a "php --version"

# Test MySQL connection
ansible all -i inventory/production.yml -m shell -a "mysql -u root -p{{ vault_mysql_root_password }} -e 'SELECT VERSION();'"
```

## 🔒 Security

## 🚀 Performance Features

### Basic Mode Performance
- **PHP-FPM optimization** with tuned pool configuration
- **MySQL optimization** with production-ready settings
- **Nginx optimization** with gzip compression and caching headers

### Ultimate Mode Performance  
Everything from Basic mode, plus:
- **Redis Object Caching** for database query optimization
- **PHP OPcache** for bytecode caching and improved PHP performance
- **Advanced Nginx tuning** with worker optimization and connection handling
- **MySQL performance tuning** with enhanced configurations

### Performance Comparison
```bash
# Deploy Basic mode
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Deploy Ultimate mode for high-traffic sites
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

## 🌍 OS Compatibility

| OS | Version | Status | Notes |
|---|---|---|---|
| Ubuntu | 25.04 | ✅ Supported | Interim release |
| Ubuntu | 24.04 LTS | ✅ Fully Tested | Recommended |
| Ubuntu | 22.04 LTS | ✅ Fully Tested | Recommended |
| Ubuntu | 20.04 LTS | ✅ Supported | Tested |
| Debian | 14 | 🔶 Testing | Forky (upcoming) |
| Debian | 13 | ✅ Supported | Current stable |
| Debian | 12 | ✅ Supported | Compatible |
| Debian | 11 | ✅ Supported | Compatible |

## 📚 Documentation

- [Production Deployment Guide](docs/production-deployment.md)
- [SSL/Let's Encrypt Setup](docs/ssl-setup.md)
- [Troubleshooting Guide](docs/troubleshooting.md)
- [Contributing Guidelines](CONTRIBUTING.md)

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create a feature branch
3. Test your changes with the Docker environment
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [WordPress](https://wordpress.org/) - The amazing CMS
- [WP-CLI](https://wp-cli.org/) - WordPress command-line tool
- [Ansible](https://www.ansible.com/) - Automation platform
- Community contributors and testers

## 📞 Support

- 📧 **Issues**: [GitHub Issues](https://github.com/spalencsar/ansible-lemp-wordpress/issues)
- 📖 **Documentation**: [Wiki](https://github.com/spalencsar/ansible-lemp-wordpress/wiki)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/spalencsar/ansible-lemp-wordpress/discussions)

---

⭐ **If this project helps you, please give it a star!** ⭐

## 👨‍💻 Author

**Sebastian Palencsár**
- Copyright (c) 2025 Sebastian Palencsár
- GitHub: [@spalencsar](https://github.com/spalencsar)

