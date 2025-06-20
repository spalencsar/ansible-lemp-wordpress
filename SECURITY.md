# Security Policy

## Supported Versions

We actively support the following versions of this project with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |
| 0.x.x   | :x:                |

## Reporting a Vulnerability

We take the security of our software seriously. If you believe you have found a security vulnerability in this project, please report it to us as described below.

### Where to Report

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please use GitHub's private vulnerability reporting feature or create a private issue.

### What to Include

Please include the following information in your report:

- **Type of issue** (e.g., buffer overflow, SQL injection, cross-site scripting, etc.)
- **Full paths of source file(s)** related to the manifestation of the issue
- **The location of the affected source code** (tag/branch/commit or direct URL)
- **Any special configuration** required to reproduce the issue
- **Step-by-step instructions** to reproduce the issue
- **Proof-of-concept or exploit code** (if possible)
- **Impact of the issue**, including how an attacker might exploit the issue

### Response Timeline

- We will acknowledge receipt of your vulnerability report within 48 hours
- We will provide a detailed response within 7 days indicating next steps
- We will notify you when the vulnerability has been fixed
- We will coordinate with you on disclosure timing

### Safe Harbor

We support safe harbor for security researchers who:

- Make a good faith effort to avoid privacy violations, destruction of data, and interruption or degradation of our services
- Only interact with accounts you own or with explicit permission of the account holder
- Do not access data that doesn't belong to you
- Report vulnerabilities as soon as possible after discovery
- Do not exploit a security issue for purposes other than verification

## Security Best Practices

When using this project, please follow these security best practices:

### Server Security
- Keep your operating system and all packages up to date
- Use strong passwords and SSH keys for authentication
- Configure firewall rules to restrict access
- Regularly review and rotate credentials
- Enable automatic security updates where possible

### WordPress Security
- Keep WordPress core, themes, and plugins updated
- Use strong passwords for WordPress admin accounts
- Enable two-factor authentication
- Regularly backup your WordPress site and database
- Use security plugins like Wordfence or Sucuri
- Limit login attempts and implement IP blocking

### SSL/TLS Security
- Use strong SSL/TLS configurations
- Regularly renew SSL certificates
- Implement HSTS headers
- Use secure cipher suites

### Ansible Security
- Use Ansible Vault for sensitive variables
- Store secrets in external credential stores when possible
- Regularly rotate SSH keys and passwords
- Use least privilege principles for Ansible users
- Keep Ansible and its dependencies updated

### Database Security
- Use strong database passwords
- Limit database user permissions
- Enable database logging and monitoring
- Regularly backup databases
- Use encrypted connections to databases

## Known Security Considerations

### Default Configurations
- The project includes development-friendly defaults that may not be suitable for production
- Review all default passwords and change them before production deployment
- SSL is optional but strongly recommended for production use

### Network Security
- The project opens standard web ports (80, 443)
- SSH access is required for Ansible deployment
- Consider using VPN or bastion hosts for enhanced security

### Third-Party Dependencies
- This project installs various third-party packages
- Regularly update these dependencies for security patches
- Monitor security advisories for WordPress, Nginx, MySQL, and PHP

## Security Features

This project includes several security features:

- **SSL/HTTPS support** with modern TLS configuration (TLS 1.2/1.3)
- **Nginx security headers** (X-Frame-Options, X-XSS-Protection, X-Content-Type-Options, etc.)
- **HSTS (HTTP Strict Transport Security)** for SSL-enabled deployments
- **Secure WordPress configurations** out of the box
- **Database security hardening** with user privilege restrictions
- **File permission hardening** for WordPress files and directories
- **Strong SSL cipher suites** and secure session handling

## Contributing to Security

If you'd like to contribute to the security of this project:

- Review the code for potential security issues
- Suggest security improvements in pull requests
- Help maintain documentation about security best practices
- Participate in security-related discussions

## Acknowledgments

We would like to thank the following individuals who have helped improve the security of this project:

<!-- Add names of security contributors here -->

---

Thank you for helping keep our project and our users safe!

---

**Maintainer**: Sebastian Palencsár  
**Copyright**: (c) 2025 Sebastian Palencsár

