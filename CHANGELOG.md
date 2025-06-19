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
- **BREAKING**: Removed RedHat/CentOS/Rocky Linux support for stability
- Focused on Ubuntu/Debian family systems only
- Simplified CI/CD pipeline (removed CentOS tests)
- Unified variables into single debian-family.yml file
- Streamlined playbooks for better maintainability

### Fixed
- WP-CLI download from official source
- MySQL user permissions for TCP connections
- PHP-FPM socket permissions
- Service management across different OS families

### Removed
- RedHat/CentOS/Rocky Linux specific code and variables
- CentOS Docker tests from CI/CD pipeline
- Multi-OS complexity that caused maintenance issues

## [1.0.0] - 2025-06-19

### Added
- SSL/HTTPS support with Let's Encrypt integration
- Ubuntu/Debian support (20.04, 22.04, 24.04, Debian 11, 12)
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
