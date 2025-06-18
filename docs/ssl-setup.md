# SSL/HTTPS Setup Guide

This guide explains how to set up SSL certificates for your WordPress installation.

## Let's Encrypt with Certbot

### Prerequisites
- Domain name pointing to your server
- Ports 80 and 443 open in firewall
- Nginx already configured and running

### Automatic SSL Setup

The playbook includes an optional SSL setup that uses Let's Encrypt:

```bash
ansible-playbook -i inventory/production playbooks/lemp-wordpress.yml -e enable_ssl=true -e domain_name=yourdomain.com
```

### Manual SSL Setup

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
