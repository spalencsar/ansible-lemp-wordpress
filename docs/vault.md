# Ansible Vault Security Guide

This guide explains how to use Ansible Vault to securely manage passwords and sensitive data in your WordPress deployment.

## What is Ansible Vault?

Ansible Vault is a feature that allows you to encrypt sensitive data like passwords, API keys, and certificates, so they can be safely stored in version control systems like Git.

## Why Use Ansible Vault?

**Without Vault (Insecure):**
```yaml
# production.yml - INSECURE!
mysql_root_password: "my-secret-password"  # Visible to everyone
```

**With Vault (Secure):**
```yaml
# production.yml - SECURE!
mysql_root_password: "{{ vault_mysql_root_password }}"  # References encrypted value

# group_vars/all/vault.yml - ENCRYPTED!
$ANSIBLE_VAULT;1.1;AES256
66633030613...  # Encrypted content
```

## Quick Setup Guide

### 1. Create the Vault Structure

```bash
# Create directories
mkdir -p group_vars/all/

# Create encrypted vault file
ansible-vault create group_vars/all/vault.yml
```

You'll be prompted to enter a vault password. **Remember this password!**

### 2. Add Encrypted Passwords

In the vault editor, add your sensitive data:

```yaml
# Content of group_vars/all/vault.yml (will be encrypted)
vault_mysql_root_password: "your-super-secure-mysql-password"
vault_wordpress_db_password: "your-secure-wp-db-password"
vault_wp_admin_password: "your-secure-admin-password"
```

### 3. Update Your Inventory

Modify your `inventory/production.yml` to reference vault variables:

```yaml
wordpress_servers:
  hosts:
    your-server.example.com:
      # ... other settings ...
      
      # Database - Using vault variables
      mysql_root_password: "{{ vault_mysql_root_password }}"
      wordpress_db_password: "{{ vault_wordpress_db_password }}"
      
      # WordPress Admin - Using vault variables  
      wp_admin_password: "{{ vault_wp_admin_password }}"
```

### 4. Deploy with Vault

```bash
# Deploy and provide vault password
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass

# Or store vault password in a file (keep secure!)
echo "your-vault-password" > .vault_password
chmod 600 .vault_password
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --vault-password-file .vault_password
```

## Vault File Management

### View Encrypted Content
```bash
ansible-vault view group_vars/all/vault.yml
```

### Edit Encrypted Content
```bash
ansible-vault edit group_vars/all/vault.yml
```

### Change Vault Password
```bash
ansible-vault rekey group_vars/all/vault.yml
```

### Encrypt Existing File
```bash
ansible-vault encrypt group_vars/all/vault.yml
```

### Decrypt File (Temporarily)
```bash
ansible-vault decrypt group_vars/all/vault.yml
# Edit the file
ansible-vault encrypt group_vars/all/vault.yml
```

## Complete Example

### Project Structure
```
ansible-lemp-wordpress/
├── inventory/
│   └── production.yml          # References vault variables
├── group_vars/
│   └── all/
│       └── vault.yml           # Encrypted passwords
├── playbooks/
│   └── lemp-wordpress.yml
└── .vault_password             # Optional: vault password file
```

### Example Vault File
```yaml
# group_vars/all/vault.yml (encrypted)
vault_mysql_root_password: "MySecure123!@#Root"
vault_wordpress_db_password: "WordPressDB456$%^"
vault_wp_admin_password: "AdminPass789&*()"
vault_ssl_email: "admin@yourcompany.com"
```

### Example Inventory
```yaml
# inventory/production.yml
wordpress_servers:
  hosts:
    web1.yourcompany.com:
      ansible_host: 192.168.1.100
      ansible_user: ubuntu
      domain_name: yoursite.com
      
      # SSL Configuration
      ssl_enabled: true
      ssl_email: "{{ vault_ssl_email }}"
      
      # Database (using vault)
      mysql_root_password: "{{ vault_mysql_root_password }}"
      wordpress_db_name: "wordpress"
      wordpress_db_user: "wp_user"
      wordpress_db_password: "{{ vault_wordpress_db_password }}"
      
      # WordPress Admin (using vault)
      wp_admin_user: "admin"
      wp_admin_password: "{{ vault_wp_admin_password }}"
      wp_admin_email: "{{ vault_ssl_email }}"
      wp_site_title: "My Company Website"
```

## Security Best Practices

### 1. Vault Password Management
- **Never commit the vault password to Git**
- Use a strong, unique password for your vault
- Consider using a password manager
- For teams, use external secret management systems

### 2. File Permissions
```bash
# Secure vault password file
chmod 600 .vault_password

# Add to .gitignore
echo ".vault_password" >> .gitignore
```

### 3. Git Configuration
```bash
# Add vault file to Git (it's encrypted, so it's safe)
git add group_vars/all/vault.yml

# But never add the password file
echo ".vault_password" >> .gitignore
git add .gitignore
```

### 4. Team Collaboration
For teams, consider these approaches:

**Option 1: Shared Vault Password**
- Share vault password through secure channels (encrypted email, password manager)
- Each team member stores password locally

**Option 2: External Secret Management**
- Use HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault
- Ansible can integrate with these systems

## Deployment Commands

### Basic Deployment
```bash
# Standard deployment with vault
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass
```

### Ultimate Performance Deployment
```bash
# Ultimate deployment with vault
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml --ask-vault-pass
```

### Using Password File
```bash
# With password file (for automation)
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --vault-password-file .vault_password
```

## Troubleshooting

### "Decryption failed" Error
- Check that you're using the correct vault password
- Verify the vault file isn't corrupted: `ansible-vault view group_vars/all/vault.yml`

### "Variable not found" Error
- Ensure vault variables are properly referenced in inventory
- Check variable names match exactly (case sensitive)
- Verify vault file is in the correct location

### Permission Denied
- Check file permissions: `ls -la group_vars/all/vault.yml`
- Ensure Ansible can read the vault file

## Migration from Plain Text

If you have existing plain text passwords in your inventory:

1. **Create vault file:**
```bash
ansible-vault create group_vars/all/vault.yml
```

2. **Move passwords to vault:**
```yaml
# Add to vault.yml
vault_mysql_root_password: "your-existing-password"
```

3. **Update inventory:**
```yaml
# Change in production.yml
mysql_root_password: "{{ vault_mysql_root_password }}"
```

4. **Test deployment:**
```bash
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass --check
```

## Conclusion

Ansible Vault provides a secure way to manage sensitive data while keeping it version-controlled. While it adds complexity, it's essential for production deployments where security is paramount.

For simple testing or development, plain text passwords in inventory files may be acceptable, but always use Vault for production environments.

---

**Next Steps:**
- [Production Deployment Guide](production-deployment.md)
- [SSL Setup Guide](ssl-setup.md)
- [Security Best Practices](../SECURITY.md)
