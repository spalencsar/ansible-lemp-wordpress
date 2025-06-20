# Ansible LEMP WordPress Automation

🚀 **Produktionsreife, vollautomatisierte LEMP-Stack (Linux, Nginx, MySQL, PHP) + WordPress-Bereitstellung mit Ansible**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%20|%2022.04%20|%2024.04-orange)](https://ubuntu.com/)
[![Debian](https://img.shields.io/badge/Debian-11%20|%2012-red)](https://debian.org/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-6.8+-blue)](https://wordpress.org/)

## 🌐 Andere Sprachen

- [🇺🇸 English](../README.md)
- [🇭🇺 Magyar/Ungarisch](README.hu.md)

## 🎯 Features

### 🏗️ Kern-Infrastruktur
✅ **Komplette LEMP-Stack-Installation**
- Nginx-Webserver mit produktionsreifer Optimierung
- MySQL 8.0+ mit sicherer Einrichtung und Performance-Tuning
- PHP 8.3+ mit FPM, OPcache und WordPress-Erweiterungen
- Ubuntu/Debian-Familie Unterstützung (20.04, 22.04, 24.04, Debian 11, 12)

### 🛡️ WordPress & Sicherheit
✅ **WordPress-Automatisierung & Sicherheit**
- Neueste WordPress-Installation mit WP-CLI-Integration
- Automatische Datenbank-Einrichtung und sichere Konfiguration
- **Integrierte SSL/HTTPS-Unterstützung** mit Let's Encrypt
- Sicherheitshärtung (ordnungsgemäße Dateiberechtigungen, sichere Konfigurationen)

### ⚡ Performance & Caching
✅ **Ultimate Performance-Optimierungen**
- **Redis Object-Caching** für Datenbank-Optimierung
- **PHP OPcache** Konfiguration für verbesserte Performance
- **MySQL Performance-Tuning** mit optimierten Konfigurationen
- **Nginx-Optimierung** mit gzip, Caching-Headers und Worker-Tuning

### 🔧 Produktions-Features
✅ **Produktions- und Entwicklungsbereit**
- **Zwei Bereitstellungs-Modi**: Basic LEMP + Ultimate Performance
- Docker-Testumgebung für sicheres Testen
- **Modulare, saubere Architektur** - produktionsgetestet und dokumentiert
- **Idempotente Playbooks** (sicher mehrfach ausführbar)
- **SSL-Unterstützung integriert** in beiden Bereitstellungs-Modi

## 🚀 Schnellstart

### Voraussetzungen

- **Ansible** 6.0+ auf Ihrem lokalen Rechner
- **Ubuntu/Debian-Server** (20.04+, Debian 11+)
- **SSH-Zugang** zu Ihren Zielservern
- **sudo-Berechtigung** auf Zielservern

### 1. Repository klonen

```bash
git clone https://github.com/spalencsar/ansible-lemp-wordpress.git
cd ansible-lemp-wordpress
```

### 2. Inventar konfigurieren

```bash
cp inventory/production.yml.example inventory/production.yml
# Bearbeiten Sie inventory/production.yml mit Ihren Server-Details
```

### 3. Wählen Sie Ihren Bereitstellungs-Modus

#### Option A: Basic LEMP + WordPress
```bash
# Standard LEMP-Stack mit WordPress
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml
```

#### Option B: Ultimate Performance Setup
```bash
# LEMP + WordPress + Redis + OPcache + Nginx-Optimierung
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

#### Option C: Mit SSL/HTTPS
```bash
# SSL während der Bereitstellung aktivieren
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" -e "ssl_email=ihre-email@domain.com"

# Oder mit Ultimate Performance + SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "ssl_enabled=true" -e "ssl_email=ihre-email@domain.com"
```

### 4. Zugriff auf Ihre WordPress-Seite

- **Website**: `http://ihre-server-ip` (oder `https://` wenn SSL aktiviert)
- **Admin-Panel**: `http://ihre-server-ip/wp-admin`
- **Standard-Login**: Prüfen Sie Ihre Inventory-Datei für `wp_admin_user` und `wp_admin_password`
## 🐳 Docker-Testumgebung

Perfekt zum Testen vor der Bereitstellung auf Produktionsservern:

```bash
cd docker/
docker-compose up -d

# Test Basic LEMP Bereitstellung
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Test Ultimate Performance Bereitstellung
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress-ultimate.yml
```

Zugriff auf Test-Site: http://localhost:8080

## � Projektstruktur

```
ansible-lemp-wordpress/
├── playbooks/                    # Haupt-Ansible-Playbooks (PRODUKTIONSREIF)
│   ├── lemp-wordpress.yml           # Basic LEMP + WordPress Bereitstellung
│   └── lemp-wordpress-ultimate.yml  # Ultimate: LEMP + WordPress + Redis + OPcache + Optimierung
├── inventory/                    # Server-Inventar-Konfigurationen
│   ├── production.yml               # Produktionsserver-Konfiguration
│   └── docker.yml                   # Docker-Testumgebung
├── templates/                    # Jinja2-Konfigurationsvorlagen (PRODUKTIONSGETESTET)
│   ├── wp-config.php.j2            # WordPress-Konfiguration
│   ├── wordpress.nginx.j2          # Nginx Virtual Host (HTTP)
│   ├── wordpress-ssl.nginx.j2      # Nginx Virtual Host (HTTPS)
│   ├── my.cnf.j2                   # MySQL-Konfiguration
│   └── www.conf.j2                 # PHP-FPM Pool-Konfiguration
├── vars/                        # OS-spezifische Variablen
│   └── debian-family.yml           # Debian/Ubuntu-Variablen
├── docker/                      # Docker-Testumgebung
│   ├── docker-compose.yml          # Docker-Setup
│   ├── Dockerfile                  # Ubuntu-Test-Container
│   └── start-services.sh           # Service-Startup-Skript
└── docs/                        # Dokumentation
    ├── production-deployment.md
    ├── ssl-setup.md
    └── troubleshooting.md
```

## ⚙️ Konfiguration

### Bereitstellungs-Modi

**Basic LEMP Modus** (`lemp-wordpress.yml`)
- Standard LEMP-Stack (Nginx, MySQL, PHP)
- WordPress mit WP-CLI
- SSL-Unterstützung (optional)
- Geeignet für kleine bis mittlere Websites

**Ultimate Performance Modus** (`lemp-wordpress-ultimate.yml`) 
- Alles aus dem Basic-Modus, plus:
- Redis Object-Caching
- PHP OPcache-Optimierung
- Nginx Performance-Tuning
- MySQL-Optimierung
- Geeignet für High-Traffic-Websites

### SSL-Konfiguration

Beide Bereitstellungs-Modi unterstützen SSL:

```yaml
# In inventory/production.yml
wordpress_servers:
  hosts:
    ihr-server:
      ansible_host: ihre-ip
      ssl_enabled: true
      ssl_email: ihre-email@domain.com
```

### Variablen-Konfiguration

**Wichtige WordPress-Variablen:**
```yaml
# WordPress Admin
wp_admin_user: admin              # WordPress Admin-Benutzername
wp_admin_password: "{{ vault_wp_admin_password }}"  # Verwenden Sie Ansible Vault!
wp_admin_email: admin@domain.com  # WordPress Admin-E-Mail
wp_site_title: "Meine WordPress-Seite"

# Datenbank
mysql_root_password: "{{ vault_mysql_root_password }}"    # Verwenden Sie Ansible Vault!
wordpress_db_name: wordpress
wordpress_db_user: wordpress
wordpress_db_password: "{{ vault_wordpress_db_password }}" # Verwenden Sie Ansible Vault!

# SSL (optional)
ssl_enabled: false
ssl_email: admin@domain.com
```

**Performance-Variablen (Ultimate Modus):**
```yaml
# Redis-Konfiguration
redis_enabled: true
redis_maxmemory: 256mb

# PHP-Optimierung
php_memory_limit: 512M
php_upload_max_filesize: 128M
php_opcache_enabled: true

# Nginx-Optimierung
nginx_worker_processes: auto
nginx_optimization_enabled: true
```

### Server-Anforderungen

- **OS**: Ubuntu 20.04+ oder Debian 11+
- **RAM**: Mindestens 1GB (2GB+ empfohlen für Ultimate Modus)
- **Speicher**: Mindestens 10GB freier Speicherplatz
- **Netzwerk**: SSH-Zugang + Web-Ports (80/443)

## 🔒 Sicherheit & Best Practices

### Sicherheits-Features
- **Sichere Passwort-Behandlung** mit Ansible Vault
- **Ordnungsgemäße Dateiberechtigungen** für WordPress und Systemdateien
- **MySQL-Sicherheit** mit benutzerdefiniertem Root-Passwort und eingeschränktem Zugang
- **Nginx-Sicherheits-Header** und Konfigurationshärtung
- **SSL/HTTPS-Unterstützung** mit Let's Encrypt-Integration

### Best Practices
```bash
# Verwenden Sie Ansible Vault für sensible Daten
ansible-vault create inventory/group_vars/all/vault.yml

# Beispiel vault.yml Inhalt:
vault_mysql_root_password: "ihr-sicheres-mysql-passwort"
vault_wp_admin_password: "ihr-sicheres-wp-passwort"
vault_wordpress_db_password: "ihr-sicheres-db-passwort"

# Bereitstellung mit Vault
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass
```

## 🧪 Testen

### Pre-Deployment-Tests
```bash
# Zuerst mit Docker testen
cd docker/
docker-compose up -d
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Testumgebung aufrufen
curl -I http://localhost:8080/
```

### Validierungs-Befehle
```bash
# WordPress-Installation prüfen
curl -s http://ihr-server/ | grep "WordPress"

# Admin-Zugang testen
curl -I http://ihr-server/wp-admin/

# PHP-Version prüfen
ansible all -i inventory/production.yml -m shell -a "php --version"

# MySQL-Verbindung testen
ansible all -i inventory/production.yml -m shell -a "mysql -u root -p{{ vault_mysql_root_password }} -e 'SELECT VERSION();'"
```

## 🚀 Performance-Features

### Basic Modus Performance
- **PHP-FPM-Optimierung** mit angepasster Pool-Konfiguration
- **MySQL-Optimierung** mit produktionsbereiten Einstellungen
- **Nginx-Optimierung** mit gzip-Kompression und Caching-Headern

### Ultimate Modus Performance  
Alles aus dem Basic-Modus, plus:
- **Redis Object-Caching** für Datenbankabfrage-Optimierung
- **PHP OPcache** für Bytecode-Caching und verbesserte PHP-Performance
- **Erweiterte Nginx-Tuning** mit Worker-Optimierung und Verbindungsbehandlung
- **MySQL Performance-Tuning** mit erweiterten Konfigurationen

### Performance-Vergleich
```bash
# Basic Modus bereitstellen
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Ultimate Modus für High-Traffic-Websites bereitstellen
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

## 🌍 OS-Kompatibilität

| OS | Version | Status | Hinweise |
|---|---|---|---|
| Ubuntu | 24.04 LTS | ✅ Vollständig getestet | Empfohlen |
| Ubuntu | 22.04 LTS | ✅ Vollständig getestet | Empfohlen |
| Ubuntu | 20.04 LTS | ✅ Unterstützt | Getestet |
| Debian | 12 | ✅ Unterstützt | Kompatibel |
| Debian | 11 | ✅ Unterstützt | Kompatibel |

## 📚 Dokumentation

- [Produktions-Bereitstellungsleitfaden](production-deployment.md)
- [SSL/Let's Encrypt-Setup](ssl-setup.md)
- [Fehlerbehebungsleitfaden](troubleshooting.md)
- [Beitragsleitlinien](../CONTRIBUTING.md)

## 🤝 Beitragen

Wir begrüßen Beiträge! Bitte lesen Sie unsere [Beitragsleitlinien](../CONTRIBUTING.md) für Details.

1. Repository forken
2. Feature-Branch erstellen
3. Änderungen mit der Docker-Umgebung testen
4. Pull Request einreichen

## � Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert - siehe die [LICENSE](../LICENSE)-Datei für Details.

## 🙏 Danksagungen

- [WordPress](https://wordpress.org/) - Das fantastische CMS
- [WP-CLI](https://wp-cli.org/) - WordPress Kommandozeilen-Tool
- [Ansible](https://www.ansible.com/) - Automatisierungsplattform
- Community-Mitwirkende und Tester

## � Support

- 📧 **Issues**: [GitHub Issues](https://github.com/yourusername/ansible-lemp-wordpress/issues)
- 📖 **Dokumentation**: [Wiki](https://github.com/yourusername/ansible-lemp-wordpress/wiki)
- � **Diskussionen**: [GitHub Discussions](https://github.com/yourusername/ansible-lemp-wordpress/discussions)

---

⭐ **Wenn Ihnen dieses Projekt hilft, geben Sie ihm bitte einen Stern!** ⭐

## 👨‍💻 Autor

**Sebastian Palencsár**
- Copyright (c) 2025 Sebastian Palencsár
- GitHub: [@spalencsar](https://github.com/spalencsar)
