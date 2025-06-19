# Ansible LEMP WordPress Automation

🚀 **Vollautomatisierte LEMP-Stack (Linux, Nginx, MySQL, PHP) + WordPress-Bereitstellung mit Ansible**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%20|%2022.04%20|%2024.04-orange)](https://ubuntu.com/)
[![Debian](https://img.shields.io/badge/Debian-11%20|%2012-red)](https://debian.org/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-6.8+-blue)](https://wordpress.org/)

## 🌐 Andere Sprachen

- [English](README.md)
- [Magyar/Ungarisch](README.hu.md)

## 🎯 Features

### Kern-Infrastruktur
✅ **Komplette LEMP-Stack-Installation**
- Nginx-Webserver mit optimierter Konfiguration
- MySQL 8.0+ mit sicherer Einrichtung
- PHP 8.3+ mit FPM und WordPress-Erweiterungen
- Ubuntu/Debian-Familie Unterstützung (20.04, 22.04, 24.04, Debian 11, 12)

### WordPress & Sicherheit
✅ **WordPress-Automatisierung**
- Neueste WordPress-Installation über offizielles WP-CLI
- Automatische Datenbank-Einrichtung und -Konfiguration
- SSL/HTTPS mit Let's Encrypt-Integration
- Sicherheitshärtung (Fail2Ban, sichere Konfigurationen)

### Performance & Monitoring
✅ **Performance-Optimierungen**
- Redis/Memcached-Caching-Unterstützung
- PHP OPcache-Konfiguration
- MySQL-Performance-Tuning
- Automatisiertes Backup-System mit Aufbewahrung

### Entwicklung & DevOps
✅ **Produktions- und Entwicklungsbereit**
- Docker-Testumgebung enthalten
- GitHub Actions CI/CD-Pipeline
- Multi-Umgebungs-Unterstützung (Docker, VMs, Bare Metal)
- WordPress-Multisite-Unterstützung

### Dokumentation & Support
✅ **Entwicklerfreundlich**
- Umfassende Dokumentation und Anleitungen
- Fehlerbehebungsleitfaden mit häufigen Lösungen
- Beitragsleitlinien für Open-Source-Zusammenarbeit
- Idempotente Playbooks (sicher mehrfach ausführbar)

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
# Für Produktion
cp inventory/production.example inventory/production.ini
# Bearbeiten Sie production.ini mit Ihren Server-Details

# Für lokale Tests mit Docker
cp inventory/docker.ini inventory/local.ini
```

### 3. Variablen anpassen

Bearbeiten Sie die Variablen in Ihren Playbooks oder verwenden Sie `--extra-vars`:

```bash
# Grundlegende WordPress-Konfiguration
wp_admin_user: admin
wp_admin_password: ihr_sicheres_passwort
wp_admin_email: admin@ihreseite.com
wp_site_title: "Meine WordPress-Seite"

# Datenbank-Konfiguration
mysql_root_password: sehr_sicheres_root_passwort
wordpress_db_password: sicheres_wp_passwort
```

### 4. LEMP + WordPress bereitstellen

```bash
# Basis-LEMP-Stack + WordPress
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml

# Mit SSL/HTTPS (Let's Encrypt)
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml

# Mit erweiterten Performance-Features
ansible-playbook -i inventory/production.ini playbooks/ultimate-performance-optimization.yml
```

### 5. Zugriff auf Ihre WordPress-Seite

```bash
# Öffnen Sie Ihren Browser und gehen Sie zu:
http://ihre-server-ip

# Für SSL-Setup:
https://ihre-domain.com
```

## 📖 Detaillierte Nutzung

### Verfügbare Playbooks

| Playbook | Beschreibung | Anwendungsfall |
|----------|--------------|----------------|
| `lemp-wordpress.yml` | Basis-LEMP + WordPress | Schnelle Einrichtung, Entwicklung |
| `lemp-wordpress-ssl.yml` | LEMP + WordPress + SSL | Produktion mit HTTPS |
| `install-wordpress-official.yml` | Nur WordPress-Installation | Bestehende LEMP-Stacks |
| `ultimate-performance-optimization.yml` | Performance-Optimierungen | Hochleistungs-Websites |
| `wordpress-advanced-features.yml` | Erweiterte Features | Enterprise-Features |

### Umgebungsspezifische Bereitstellung

#### Docker (Entwicklung/Tests)
```bash
# Docker-Umgebung starten
cd docker
docker-compose up -d

# Tests ausführen
ansible-playbook -i inventory/docker.ini playbooks/lemp-wordpress.yml
```

#### Cloud-Server (AWS, GCP, Azure, DigitalOcean)
```bash
# Inventar mit Cloud-Server-IPs konfigurieren
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml \
  --extra-vars "domain_name=ihreseite.com"
```

#### Bare Metal / VPS
```bash
# Direkter Server-Zugang
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml \
  --extra-vars "enable_ssl=true"
```

### Erweiterte Konfiguration

#### SSL/Let's Encrypt aktivieren
```bash
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml \
  --extra-vars "domain_name=ihreseite.com admin_email=admin@ihreseite.com"
```

#### Performance-Features aktivieren
```bash
ansible-playbook -i inventory/production.ini playbooks/ultimate-performance-optimization.yml \
  --extra-vars "enable_redis=true enable_memcached=true"
```

#### WordPress-Multisite einrichten
```bash
ansible-playbook -i inventory/production.ini playbooks/wordpress-advanced-features.yml \
  --extra-vars "enable_multisite=true"
```

## 🌍 Ubuntu/Debian-Unterstützung

| OS | Version | Status |
|---|---|---|
| Ubuntu | 24.04 LTS | ✅ Vollständig getestet |
| Ubuntu | 22.04 LTS | ✅ Unterstützt |
| Ubuntu | 20.04 LTS | ✅ Unterstützt |
| Debian | 12 | ✅ Unterstützt |
| Debian | 11 | ✅ Unterstützt |

## 📚 Dokumentation

- [Produktions-Bereitstellungsleitfaden](docs/production-deployment.md)
- [SSL/Let's Encrypt-Setup](docs/ssl-setup.md)
- [Fehlerbehebungsleitfaden](docs/troubleshooting.md)
- [Beitragsleitlinien](CONTRIBUTING.md)

## 🤝 Beitragen

Wir begrüßen Beiträge! Bitte lesen Sie unsere [Beitragsleitlinien](CONTRIBUTING.md) für Details.

### Entwicklung

```bash
# Repository forken und klonen
git clone https://github.com/ihr-username/ansible-lemp-wordpress.git

# Feature-Branch erstellen
git checkout -b feature/neues-feature

# Änderungen committen
git commit -m "feat: Neues Feature hinzufügen"

# Push und Pull Request erstellen
git push origin feature/neues-feature
```

## 🐛 Fehlerbehebung

### Häufige Probleme

#### SSH-Verbindungsfehler
```bash
# SSH-Schlüssel-Berechtigung prüfen
chmod 600 ~/.ssh/id_rsa

# SSH-Verbindung testen
ssh -i ~/.ssh/id_rsa benutzer@server-ip
```

#### Ansible-Berechtungsfehler
```bash
# Sudo-Berechtigung prüfen
ansible all -i inventory/production.ini -m ping --ask-become-pass
```

#### WordPress-Installationsfehler
```bash
# Datenbank-Verbindung prüfen
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml --tags mysql -v
```

Weitere Fehlerbehebung finden Sie im [Fehlerbehebungsleitfaden](docs/troubleshooting.md).

## 📄 Lizenz

Dieses Projekt ist unter der MIT-Lizenz lizenziert - siehe die [LICENSE](LICENSE)-Datei für Details.

## 👨‍💻 Autor

**Sebastian Palencsar**
- GitHub: [@spalencsar](https://github.com/spalencsar)
- LinkedIn: [Sebastian Palencsar](https://linkedin.com/in/spalencsar)

## 🙏 Danksagungen

- [Ansible Community](https://ansible.com) für das fantastische Automatisierungstool
- [WordPress Community](https://wordpress.org) für das beste CMS
- Alle Mitwirkenden, die dieses Projekt verbessern

## ⭐ Stern geben

Wenn Ihnen dieses Projekt gefällt, geben Sie ihm bitte einen Stern auf GitHub! ⭐

---

**Hergestellt mit ❤️ für die DevOps-Community**
