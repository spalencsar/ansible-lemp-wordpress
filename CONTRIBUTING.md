# Contributing to Ansible LEMP WordPress Automation

🎉 Thank you for your interest in contributing to this project!

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Testing Guidelines](#testing-guidelines)
- [Submitting Changes](#submitting-changes)
- [Documentation](#documentation)

## 🤝 Code of Conduct

This project and everyone participating in it is governed by our commitment to creating a welcoming, diverse, and harassment-free experience for everyone.

## 🚀 Getting Started

### Prerequisites

- Ansible 6.0+
- Docker (for testing)
- Python 3.8+
- Git

### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/ansible-lemp-wordpress.git
   cd ansible-lemp-wordpress
   ```

2. **Set up Testing Environment**
   ```bash
   # Start Docker test environment
   cd docker
   docker-compose up -d
   
   # Test the playbook
   cd ..
   ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml
   ```

3. **Install Development Dependencies**
   ```bash
   pip install ansible-lint yamllint
   ```

## 🛠️ How to Contribute

### Types of Contributions

- 🐛 **Bug Reports**: Found an issue? Please report it!
- ✨ **Feature Requests**: Have an idea? We'd love to hear it!
- 📝 **Documentation**: Help improve our docs
- 🧪 **Testing**: Add test cases or improve existing ones
- 🔧 **Code**: Fix bugs or implement new features

### Areas for Contribution

1. **OS Support**
   - Test on different Ubuntu/Debian versions
   - Improve OS-specific configurations

2. **Security Enhancements**
   - SSL/TLS improvements
   - Security hardening features
   - Vulnerability assessments

3. **Performance Optimizations**
   - Caching strategies
   - Database tuning
   - Web server optimizations

4. **Monitoring & Logging**
   - Log management
   - Monitoring integration
   - Health checks

5. **Documentation**
   - Tutorials and guides
   - Troubleshooting scenarios
   - Translation to other languages

## 🧪 Testing Guidelines

### Before Submitting

1. **Lint Your Code**
   ```bash
   ansible-lint playbooks/*.yml
   yamllint .
   ```

2. **Test in Docker Environment**
   ```bash
   # Clean test
   docker-compose down -v
   docker-compose up -d
   ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml
   ```

3. **Verify WordPress Installation**
   ```bash
   curl -I http://localhost:8080
   curl -s http://localhost:8080/ | grep "WordPress"
   ```

### Test Categories

- **Unit Tests**: Test individual tasks
- **Integration Tests**: Test complete playbook execution
- **Functional Tests**: Test WordPress functionality
- **Security Tests**: Verify security configurations

## 📤 Submitting Changes

### Pull Request Process

1. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make Your Changes**
   - Follow Ansible best practices
   - Add comments for complex logic
   - Update documentation as needed

3. **Test Your Changes**
   ```bash
   # Run all tests
   ./tests/integration-test.sh
   
   # Lint check
   ansible-lint playbooks/*.yml
   yamllint .
   ```

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

5. **Push and Create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

### Commit Message Format

Use conventional commits format:

```
type(scope): description

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `test`: Adding tests
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `ci`: CI/CD changes

**Examples:**
```
feat(wordpress): add multisite support
fix(nginx): correct SSL certificate path
docs(readme): update installation instructions
test(docker): add integration test for MySQL
```

## 📚 Documentation

### Documentation Standards

- Use clear, concise language
- Include code examples
- Add troubleshooting tips
- Keep documentation up-to-date

### Areas Needing Documentation

- [x] Advanced configuration scenarios *(see docs/multi-environment-deployment.md)*
- [x] Troubleshooting common issues *(see docs/troubleshooting.md)*
- [ ] Performance tuning guides
- [x] Security best practices *(see SECURITY.md and docs/vault.md)*  
- [x] Multi-environment setups *(see docs/multi-environment-deployment.md)*

## 🔧 Development Guidelines

### Ansible Best Practices

1. **Use Proper YAML Syntax**
   - 2-space indentation
   - Descriptive task names
   - Use `---` document separator

2. **Variable Naming**
   - Use descriptive names
   - Follow snake_case convention
   - Group related variables

3. **Error Handling**
   - Check return codes
   - Provide meaningful error messages
   - Use `failed_when` when appropriate

4. **Idempotency**
   - Ensure tasks are idempotent
   - Use appropriate modules
   - Test multiple runs

### Template Guidelines

- Use Jinja2 best practices
- Comment complex logic
- Handle undefined variables gracefully
- Test with different variable combinations

## 🙋‍♀️ Getting Help

- **Issues**: Check existing issues or create a new one
- **Discussions**: Use GitHub Discussions for questions
- **Documentation**: Refer to our comprehensive docs in the `docs/` directory

## 🎯 Project Roadmap

### Planned Features

- [ ] WordPress Multisite automation
- [ ] Advanced backup strategies
- [ ] Monitoring integration (Prometheus/Grafana)
- [ ] Cluster deployment support
- [x] Advanced SSL management *(implemented in lemp-wordpress-ultimate.yml)*
- [ ] Database replication setup

### Help Wanted

Look for issues labeled:
- `good first issue`
- `help wanted`
- `documentation`
- `testing`

---

**Thank you for contributing to make this project better!** 🚀
