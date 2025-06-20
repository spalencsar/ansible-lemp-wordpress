# SSL/HTTPS Setup Guide

This guide explains how to set up SSL certificates for your WordPress installation using the integrated SSL support.

## Automatic SSL Setup (Recommended)

### Prerequisites
- Domain name pointing to your server
- Ports 80 and 443 open in firewall
- Valid email address for Let's Encrypt

### Method 1: Enable SSL in Inventory

Edit your `inventory/production.yml`:

```yaml
wordpress_servers:
  hosts:
    your-domain.com:
      # ... other settings ...
      
      # SSL Configuration
      ssl_enabled: true                    # Enable SSL
      ssl_email: admin@your-domain.com     # Required for Let's Encrypt
      domain_name: your-domain.com         # Your domain
```

Deploy with SSL:
```bash
# Basic LEMP with SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Ultimate Performance with SSL  
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

### Method 2: Enable SSL via Command Line

```bash
# Enable SSL during deployment
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" \
  -e "ssl_email=admin@your-domain.com"
```

## Manual SSL Setup

If you prefer manual setup or have your own certificates:

1. **Install Certbot:**
   ```bash
   sudo apt update
   sudo apt install certbot python3-certbot-nginx
   ```

2. **Generate Certificate:**
   ```bash
   sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
   ```

3. **Auto-renewal:**
   ```bash
   sudo crontab -e
   # Add: 0 12 * * * /usr/bin/certbot renew --quiet
   ```

### SSL Configuration

The SSL-enabled Nginx configuration includes:
- HTTP to HTTPS redirect
- Strong SSL ciphers
- HSTS headers
- OCSP stapling

### Troubleshooting SSL

**Certificate not found:**
- Verify domain DNS points to server
- Check firewall allows ports 80/443
- Ensure Nginx is running

**Mixed content warnings:**
- Update WordPress site URL in database
- Check for hardcoded HTTP links
- Use SSL-aware plugins

**Certificate renewal fails:**
- Check Nginx configuration syntax
- Verify webroot path permissions
- Review certbot logs: `/var/log/letsencrypt/`

## Custom Certificates

To use your own SSL certificates:

1. Copy certificates to `/etc/ssl/certs/`
2. Update Nginx configuration
3. Restart Nginx service

See `templates/wordpress-ssl.nginx.j2` for the SSL template.
