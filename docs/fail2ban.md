# Fail2Ban Security Guide

## Overview

Fail2Ban is included in this project to protect your server against brute-force attacks. It monitors log files and bans IPs that show malicious behavior.

## Enabled Jails

| Jail | Description | Default Actions |
|------|-------------|-----------------|
| sshd | SSH brute force | Ban for 24h after 3 failures |
| nginx-http-auth | HTTP Auth failures | Ban for 1h after 5 failures |
| nginx-botsearch | Bot scanners | Ban for 2h after 2 failures |
| wordpress-login | WordPress login attempts | Ban for 2h after 5 failures |
| recidive | Repeat offenders | Ban for 1 week after 3 bans |

## Quick Commands

### Check Status

```bash
# See all bans
sudo fail2ban-client status

# See specific jail
sudo fail2ban-client status sshd
sudo fail2ban-client status wordpress-login
```

### Unban IP

```bash
# Unban specific IP
sudo fail2ban-client set sshd unbanip 192.168.1.100
sudo fail2ban-client unban 192.168.1.100

# Unban all
sudo fail2ban-client unban --all
```

### Manage Jails

```bash
# Disable a jail
sudo fail2ban-client set wordpress-login disabled

# Enable a jail
sudo fail2ban-client set wordpress-login enabled
```

## Log Files

- Fail2Ban log: `/var/log/fail2ban.log`
- Banned IPs database: `/var/lib/fail2ban/fail2ban.sqlite3`

## Configuration

### Default Settings

| Setting | Value | Description |
|--------|-------|-------------|
| bantime | 3600s (1h) | Default ban duration |
| findtime | 600s (10m) | Window to count failures |
| maxretry | 5 | Failures before ban |
| bantime.increment | true | Increase for repeat offenders |

### Add Trusted IP

Edit `/etc/fail2ban/jail.local`:

```ini
[DEFAULT]
ignoreip = 127.0.0.1/8 ::1 203.0.113.42
```

## Testing

### Test SSH Filter

```bash
sudo fail2ban-regex /var/log/auth.log /etc/fail2ban/filter.d/sshd.conf
```

### Test WordPress Filter

```bash
sudo fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/wordpress-login.conf
```

## Whitelist Your IP (Important!)

Before testing, add your IP to the whitelist:

```bash
# Edit jail.local
sudo nano /etc/fail2ban/jail.local

# Add to [DEFAULT]:
ignoreip = 127.0.0.1/8 ::1 YOUR_IP_ADDRESS
```

## Troubleshooting

### No Bans Happen

1. Check log path: `sudo fail2ban-client get wordpress-login logpath`
2. Test filter: `sudo fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/wordpress-login.conf`
3. Verify log exists: `sudo tail /var/log/nginx/access.log`

### Locked Out

```bash
# Unban yourself
sudo fail2ban-client unban YOUR_IP
```

### Service Not Starting

```bash
# Check status
sudo systemctl status fail2ban

# Check logs
sudo journalctl -u fail2ban -n 50
```

## Customize Ban Time

For specific services, edit `/etc/fail2ban/jail.local`:

```ini
[sshd]
bantime = 86400    # 24 hours for SSH

[wordpress-login]
bantime = 7200     # 2 hours for WordPress
maxretry = 3        # Stricter for WordPress
```

## Disable Fail2Ban

```bash
# Stop service
sudo systemctl stop fail2ban

# Disable on boot
sudo systemctl disable fail2ban
```

## Security Notes

- Always whitelist your own IP before deploying
- SSH jail has strict settings (3 retries) - ensure you use SSH keys
- Incremental bans enabled - repeat offenders get longer bans
- Recidive jail bans for 1 week after 3 bans in 24h