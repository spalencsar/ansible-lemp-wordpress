# Ansible LEMP WordPress Automation

🚀 **Fully automated LEMP stack (Linux, Nginx, MySQL, PHP) + WordPress deployment using Ansible**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04%20LTS-orange)](https://ubuntu.com/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-6.8+-blue)](https://wordpress.org/)

## 🎯 Features

### Core Infrastructure
✅ **Complete LEMP Stack Installation**
- Nginx web server with optimized configuration
- MySQL 8.0+ with secure setup  
- PHP 8.3+ with FPM and WordPress extensions
- Multi-OS support (Ubuntu, Debian, CentOS, RHEL, Rocky Linux)

### WordPress & Security
✅ **WordPress Automation**
- Latest WordPress installation via official WP-CLI
- Automatic database setup and configuration
- SSL/HTTPS with Let's Encrypt integration
- Security hardening (Fail2Ban, secure configurations)

### Performance & Monitoring
✅ **Performance Optimizations**
- Redis/Memcached caching support
- PHP OPcache configuration
- MySQL performance tuning
- Automated backup system with retention

### Development & DevOps
✅ **Production & Development Ready**
- Docker testing environment included
- GitHub Actions CI/CD pipeline
- Multi-environment support (Docker, VMs, bare metal)
- WordPress Multisite support

### Documentation & Support
✅ **Developer Friendly**
- Comprehensive documentation and guides
- Troubleshooting guide with common solutions
- Contributing guidelines for open source collaboration
- Idempotent playbooks (safe to run multiple times)

## 🚀 Quick Start

### Prerequisites

- **Control Machine**: Ansible 6.0+ installed
- **Target Server**: Ubuntu 24.04+ with SSH access and sudo privileges
- **Network**: SSH access (port 22) and web access (ports 80/443)

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/ansible-lemp-wordpress.git
cd ansible-lemp-wordpress
```

### 2. Configure Inventory

```bash
cp inventory/production.example inventory/production.ini
# Edit inventory/production.ini with your server details
```

### 3. Deploy WordPress

```bash
# Install LEMP stack
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml

# Install WordPress with WP-CLI
ansible-playbook -i inventory/production.ini playbooks/install-wordpress-official.yml
```

### 4. Access Your Site

- **Website**: `http://your-server-ip`
- **Admin Panel**: `http://your-server-ip/wp-admin`
- **Default Login**: admin / admin123 (change immediately!)

## 🐳 Docker Testing Environment

Perfect for testing before deploying to production servers:

```bash
cd docker/
docker-compose up -d
ansible-playbook -i inventory/docker.ini playbooks/lemp-wordpress.yml
ansible-playbook -i inventory/docker.ini playbooks/install-wordpress-official.yml
```

Access test site: http://localhost:8080

## 📁 Project Structure

```
ansible-lemp-wordpress/
├── playbooks/              # Main Ansible playbooks
│   ├── lemp-wordpress.yml       # LEMP stack installation
│   └── install-wordpress-official.yml  # WordPress setup with WP-CLI
├── inventory/              # Server inventory examples
│   ├── production.example      # Production server template
│   ├── staging.example         # Staging server template
│   └── docker.ini             # Docker test environment
├── templates/              # Configuration templates
│   ├── wp-config.php.j2       # WordPress configuration
│   └── wordpress.nginx.j2     # Nginx virtual host
├── vars/                   # Variable files for different OS
│   ├── ubuntu.yml             # Ubuntu-specific variables
│   └── debian.yml             # Debian-specific variables
├── docker/                 # Docker testing environment
│   ├── docker-compose.yml     # Docker setup
│   ├── Dockerfile             # Ubuntu container
│   └── start-services.sh      # Service startup script
└── docs/                   # Documentation
    ├── production-deployment.md
    ├── ssl-setup.md
    └── troubleshooting.md
```

## ⚙️ Configuration

### Server Requirements

- **OS**: Ubuntu 24.04+, Debian 12+, CentOS 8+, Rocky Linux 8+
- **RAM**: Minimum 1GB (2GB+ recommended)
- **Storage**: Minimum 10GB free space
- **Network**: SSH access + web ports (80/443)

### Customization

Edit variables in your inventory file:

```ini
[webservers]
your-server.com ansible_user=ubuntu

[webservers:vars]
# WordPress Configuration
wp_admin_user=admin
wp_admin_email=admin@yoursite.com
wp_site_title="My WordPress Site"
wp_site_url="https://yoursite.com"

# Database Configuration
mysql_root_password=your_secure_password
wordpress_db_name=wordpress
wordpress_db_user=wp_user
wordpress_db_password=another_secure_password

# SSL Configuration (optional)
enable_ssl=true
ssl_email=admin@yoursite.com
```

## 🔒 Security Features

- Secure MySQL installation with custom root password
- WordPress security keys auto-generation
- Proper file permissions and ownership
- Nginx security headers
- PHP security hardening
- Firewall configuration ready

## 🧪 Testing

### Automated Testing
```bash
# Run integration tests
./tests/integration-test.sh

# Validate inventory files
./tests/validate-inventory.py inventory/production.example

# Lint Ansible playbooks
ansible-lint playbooks/*.yml

# Validate YAML syntax
yamllint .
```

### Manual Testing
```bash
# Test basic WordPress functionality
curl -I http://your-server/
curl -s http://your-server/ | grep "WordPress"

# Test admin access
curl -I http://your-server/wp-admin/

# Test WP-CLI
ansible all -i inventory/production -m shell -a "cd /var/www/html && wp core version"
```

## 🔒 Security

This project includes several security features:
- **Fail2Ban integration** for intrusion prevention
- **SSL/HTTPS support** with Let's Encrypt
- **Security headers** and Nginx hardening
- **Database security** with proper user permissions
- **File permission hardening**

See [SECURITY.md](SECURITY.md) for detailed security information.

## 📊 Performance Features

- **FastCGI Caching** with Nginx for ultra-fast page loads
- **Redis Object Caching** for database query optimization
- **PHP OPcache** for improved PHP performance
- **System-level optimizations** (kernel parameters, limits)
- **Automated performance monitoring** with alerts
- **Database optimization** scripts with scheduled cleanup
- **Cache warming** for consistent performance

## 🚀 **Performance Optimization** (NEW!)
```bash
# Ultimate performance optimization
ansible-playbook -i inventory/production playbooks/ultimate-performance-optimization.yml \
  -e enable_redis=true -e enable_performance_monitoring=true

# Advanced features with performance
ansible-playbook -i inventory/production playbooks/wordpress-advanced-features.yml \
  -e enable_redis=true -e enable_memcached=true -e enable_opcache=true
```

### 📊 **Enterprise Features**
- **Multi-environment testing** (Docker, VM, bare metal)
- **Performance monitoring** with automated alerts
- **Log management** with rotation and cleanup
- **Security hardening** with Fail2Ban and headers
- **Backup automation** with retention policies
- **Health checks** and self-healing capabilities

## 🌍 Multi-OS Support

| OS | Version | Status |
|---|---|---|
| Ubuntu | 24.04 LTS | ✅ Fully Tested |
| Ubuntu | 22.04 LTS | ✅ Supported |
| Debian | 12+ | ✅ Supported |
| CentOS | 8+ | 🔄 In Progress |
| Rocky Linux | 8+ | 🔄 In Progress |

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

- 📧 **Issues**: [GitHub Issues](https://github.com/yourusername/ansible-lemp-wordpress/issues)
- 📖 **Documentation**: [Wiki](https://github.com/yourusername/ansible-lemp-wordpress/wiki)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/ansible-lemp-wordpress/discussions)

---

⭐ **If this project helps you, please give it a star!** ⭐

## 👨‍💻 Author

**Sebastian Palencsár**
- Copyright (c) 2025 Sebastian Palencsár
- GitHub: [@spalencsar](https://github.com/spalencsar)

