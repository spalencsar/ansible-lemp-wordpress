# Contributing to Ansible LEMP WordPress

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/). By participating, you agree to uphold this code.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- **Description:** Clear description of the issue
- **Environment:** OS version, Ansible version, target system details
- **Steps to reproduce:** Detailed steps to recreate the issue
- **Expected behavior:** What you expected to happen
- **Actual behavior:** What actually happened
- **Logs:** Relevant log output (use code blocks)
- **Configuration:** Your inventory and variable files (sanitized)

### Suggesting Features

Feature requests are welcome! Please:

- Check existing feature requests first
- Provide a clear use case
- Explain the expected behavior
- Consider implementation complexity
- Be open to discussion

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch:** `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly** (see Testing section)
5. **Commit with clear messages**
6. **Push to your fork:** `git push origin feature/amazing-feature`
7. **Open a Pull Request**

#### Pull Request Guidelines

- **Clear title:** Summarize the change in the title
- **Description:** Explain what and why, not just how
- **Link issues:** Reference related issues with "Fixes #123"
- **Test coverage:** Ensure your changes are tested
- **Documentation:** Update docs if needed
- **Small changes:** Keep PRs focused and manageable

## Development Setup

### Prerequisites

- Ansible 2.9+
- Docker and Docker Compose (for testing)
- Git
- Text editor with YAML support

### Local Development

1. **Clone your fork:**
   ```bash
   git clone https://github.com/yourusername/ansible-lemp-wordpress.git
   cd ansible-lemp-wordpress
   ```

2. **Set up testing environment:**
   ```bash
   cd docker/
   docker-compose up -d
   ```

3. **Test your changes:**
   ```bash
   ansible-playbook -i inventory/docker.ini playbooks/lemp-wordpress.yml
   ```

### Testing

Before submitting, please test your changes:

#### Unit Tests
```bash
# Lint Ansible playbooks
ansible-lint playbooks/*.yml

# Validate YAML syntax
ansible-playbook --syntax-check playbooks/lemp-wordpress.yml
```

#### Integration Tests
```bash
# Test on Docker container
cd docker/
docker-compose up -d
ansible-playbook -i ../inventory/docker.ini ../playbooks/lemp-wordpress.yml

# Test WordPress installation
ansible-playbook -i ../inventory/docker.ini ../playbooks/install-wordpress-official.yml

# Verify installation
curl -I http://localhost:8080
```

#### Multi-OS Testing
Test on different operating systems:
- Ubuntu 20.04 LTS
- Ubuntu 22.04 LTS  
- Ubuntu 24.04 LTS
- Debian 11
- Debian 12

## Coding Standards

### Ansible Best Practices

- **Use descriptive task names**
- **Add appropriate tags**
- **Use variables for reusable values**
- **Follow idempotency principles**
- **Include proper error handling**

### YAML Style

```yaml
# Good
- name: Install nginx package
  apt:
    name: nginx
    state: present
    update_cache: yes
  tags:
    - nginx
    - packages

# Avoid
- apt: name=nginx state=present update_cache=yes
```

### Variables

- Use lowercase with underscores: `mysql_root_password`
- Group related variables in files
- Provide sensible defaults
- Document complex variables

### Templates

- Use `.j2` extension for Jinja2 templates
- Include header comments
- Use consistent indentation
- Test template rendering

## File Structure

```
ansible-lemp-wordpress/
├── playbooks/           # Main playbooks
├── roles/              # Ansible roles (if used)
├── templates/          # Jinja2 templates
├── vars/              # Variable definitions
├── inventory/         # Inventory examples
├── docker/           # Docker testing environment
├── docs/             # Documentation
├── tests/            # Test scripts
└── .github/          # GitHub workflows
```

## Documentation

### Required Documentation

- Update README.md for significant changes
- Add inline comments for complex logic
- Update relevant docs/ files
- Include examples for new features

### Documentation Style

- Use clear, concise language
- Include code examples
- Provide both basic and advanced usage
- Test all documented commands

## Release Process

### Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR:** Incompatible API changes
- **MINOR:** New functionality (backward compatible)
- **PATCH:** Bug fixes (backward compatible)

### Changelog

Update CHANGELOG.md for all changes:
- **Added:** New features
- **Changed:** Changes in existing functionality
- **Deprecated:** Soon-to-be removed features
- **Removed:** Removed features
- **Fixed:** Bug fixes
- **Security:** Security improvements

## Getting Help

- **Documentation:** Check the docs/ directory
- **Issues:** Search existing GitHub issues
- **Discussions:** Use GitHub Discussions for questions
- **IRC:** Join #ansible on Libera.Chat
- **Community:** Ansible community forums

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- Project documentation

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Don't hesitate to ask! Open an issue with the "question" label or start a discussion.

Thank you for contributing! 🎉

## 👨‍💻 Maintainer

**Sebastian Palencsár**
Copyright (c) 2025 Sebastian Palencsár

