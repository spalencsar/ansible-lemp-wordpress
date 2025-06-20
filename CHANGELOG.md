# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-06-21 - Production-Ready Release

### Added
- Production-ready project cleanup and optimization
- **Ansible Vault documentation and guide** for secure password management
- Comprehensive security documentation (SECURITY.md)
- Vault usage guide (docs/vault.md) with complete setup instructions
- Enhanced SSL/HTTPS support with modern TLS configurations
- Nginx security headers (X-Frame-Options, X-XSS-Protection, etc.)
- HSTS (HTTP Strict Transport Security) for SSL deployments
- **Redis caching** in ultimate playbook with WordPress object cache plugin
- **PHP OPcache optimization** for enhanced performance
- **Advanced Nginx optimizations** (gzip compression, caching, buffer tuning, timeouts)

### Changed
- **BREAKING**: Removed experimental features for production stability (moved non-essential features to optional)
- Streamlined to 2 production-ready playbooks: `lemp-wordpress.yml` (basic) and `lemp-wordpress-ultimate.yml` (with Redis & OPcache)
- Reduced templates to 5 production-tested files only
- Cleaned inventory structure: `production.yml`, `docker.yml`, `production.yml.example`
- Enhanced documentation structure with consistent multi-language support
- Improved security features focus on SSL/TLS and Nginx hardening
- Updated CONTRIBUTING.md to reflect current project structure

### Removed
- Test playbooks and development artifacts
- Experimental Fail2Ban integration (moved to future roadmap for better implementation)
- Non-essential templates and inventory files
- Test deployment files with hardcoded passwords

### Security
- All production passwords replaced with secure placeholder values
- **Ansible Vault documentation** provided for sensitive data management
- Secure inventory templates with placeholder values (`CHANGE_ME_*`)
- Enhanced SSL certificate management
- Complete vault.md guide for implementing encrypted password storage

### Planned
- WordPress Multisite automation
- Advanced backup strategies with retention policies
- Fail2Ban integration (improved implementation)
- Monitoring integration (Prometheus/Grafana)
- Database replication setup
- Performance tuning guides

## [1.0.0] - 2025-06-19 - First Release

### Added
- Complete LEMP stack automation for Ubuntu/Debian
- SSL/HTTPS support with modern TLS configuration
- GitHub Actions CI/CD pipeline
- WordPress automation with WP-CLI integration
- Performance optimizations (PHP OPcache, MySQL tuning)
- Security enhancements (SSL/TLS hardening, secure configurations)
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
- Streamlined playbooks for production readiness
- Improved test reliability with comprehensive integration tests

### Fixed
- WP-CLI download from official source
- MySQL user permissions for TCP connections
- PHP-FPM socket permissions
- Service management across different systems
- CI/CD pipeline stability issues
- Container build problems in GitHub Actions
- SSH connectivity issues in automated tests
- Python3-apt dependency problems in check mode
