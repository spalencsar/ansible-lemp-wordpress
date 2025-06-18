# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- SSL/HTTPS support with Let's Encrypt integration
- Multi-OS support (Ubuntu, Debian, CentOS, RHEL, Rocky Linux)
- GitHub Actions CI/CD pipeline
- Advanced WordPress features (Redis, Memcached, Fail2Ban)
- Automated backup system
- WordPress Multisite support
- Performance optimizations (OPcache, MySQL tuning)
- Security enhancements (Fail2Ban, ModSecurity ready)
- Comprehensive documentation
- Contributing guidelines
- Troubleshooting guide

### Changed
- Restructured project for better maintainability
- Improved error handling in playbooks
- Enhanced variable management with OS-specific files
- Better template organization

### Fixed
- WP-CLI download from official source
- MySQL user permissions for TCP connections
- PHP-FPM socket permissions
- Service management across different OS families

## [1.0.0] - 2025-06-18

### Added
- Initial release
- Basic LEMP stack installation (Linux, Nginx, MySQL, PHP)
- WordPress installation and configuration
- WP-CLI integration
- Docker environment for testing
- Basic Ansible playbooks
- Templates for configuration files

### Features
- Automated Nginx configuration
- MySQL database setup with security
- PHP-FPM optimization
- WordPress installation via WP-CLI
- Basic security configurations
