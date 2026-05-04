# WordPress Auto-Update Guide

## Overview

This project includes automated WordPress update functionality via WP-CLI.

## Features

- Automated weekly core updates (Minor)
- Plugin and theme updates
- Automatic backup before updates
- Maintenance mode handling
- Logging to `/var/log/wp-update.log`

## Configuration

### Default Behavior

| Setting | Value | Description |
|---------|-------|-------------|
| Core Updates | Minor only | 6.x → 6.x.y |
| Schedule | Weekly (Sunday 4:00 AM) | Configurable |
| Backup | Enabled | Auto backup before update |

### Change Update Schedule

Edit the cron job on your server:

```bash
# Edit cron job
crontab -e

# Change from weekly to daily (2 AM)
0 2 * * * /usr/local/bin/wp-update.sh --minor --no-backup >> /var/log/wp-update.log 2>&1
```

### Enable Major Updates

In your inventory file, add:

```yaml
update_cron_enabled: true
# Note: Major updates are manual only for safety
```

## Usage

### Manual Update

```bash
# Minor update (default)
sudo /usr/local/bin/wp-update.sh

# Major update
sudo /usr/local/bin/wp-update.sh --major

# Force update (specific version)
sudo /usr/local/bin/wp-update.sh --force

# Skip backup
sudo /usr/local/bin/wp-update.sh --no-backup
```

### View Current Version

```bash
wp core version
```

### Check for Updates

```bash
wp core check-update
```

### Disable Auto-Updates

```bash
# Remove cron job
sudo crontab -e
# Delete the line: wordpress-weekly-update

# Or disable via Ansible
update_cron_enabled: false
```

## Log Files

- Update log: `/var/log/wp-update.log`
- Backups: `/var/backups/wordpress/`
- Database: `/var/backups/wordpress/YYYYMMDD-HHMMSS/wp-db.sql`
- Files: `/var/backups/wordpress/YYYYMMDD-HHMMSS/wp-files.tar.gz`

## Troubleshooting

### Update Failed

```bash
# Check logs
tail -f /var/log/wp-update.log

# Manual recovery
wp maintenance-mode deactivate
```

### Rollback

```bash
# Restore database
mysql -u wordpress_user -p wordpress_db < /var/backups/wordpress/20240101-120000/wp-db.sql
```

## Security Notes

- Auto-updates are set to Minor only (recommended)
- Major updates should be tested on staging first
- Always backup before updating