# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- PostgreSQL database support
- Apache webserver option
- Advanced monitoring dashboard

## [1.0.0] - 2025-06-19 - First Release

### Added
- Complete LEMP stack automation for Ubuntu/Debian
- SSL/HTTPS support with Let's Encrypt integration
- GitHub Actions CI/CD pipeline
- Advanced WordPress features (Redis, Memcached, Fail2Ban)
- Automated backup system with retention
- WordPress Multisite support
- Performance optimizations (PHP OPcache, MySQL tuning)
- Security enhancements (Fail2Ban, secure configurations)
- Comprehensive documentation and guides
- Contributing guidelines and troubleshooting guide
- Docker testing environment
- Multi-environment support (Docker, VMs, bare metal)
- Ubuntu/Debian support (20.04, 22.04, 24.04, Debian 11, 12)
- 🌍 Multilingual documentation (German, Hungarian translations)
- 🧪 Simplified and robust CI/CD testing approach  
- 📝 Professional language navigation in README

### Changed
- Restructured project for better maintainability
- Improved error handling in playbooks
- Enhanced variable management with OS-specific files
- Better template organization
- Focused exclusively on Ubuntu/Debian family systems for better stability
- Unified variables into single debian-family.yml file
- Streamlined playbooks for better maintainability
- Improved test reliability with syntax checks instead of runtime tests

### Fixed
- WP-CLI download from official source
- MySQL user permissions for TCP connections
- PHP-FPM socket permissions
- Service management across different systems
- CI/CD pipeline stability issues
- Container build problems in GitHub Actions
- SSH connectivity issues in automated tests
- Python3-apt dependency problems in check mode
