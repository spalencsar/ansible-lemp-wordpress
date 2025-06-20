# Ansible LEMP WordPress Automatizálás

🚀 **Termelésre kész, teljesen automatizált LEMP stack (Linux, Nginx, MySQL, PHP) + WordPress telepítés Ansible-lel**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%20|%2022.04%20|%2024.04-orange)](https://ubuntu.com/)
[![Debian](https://img.shields.io/badge/Debian-11%20|%2012-red)](https://debian.org/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-6.8+-blue)](https://wordpress.org/)

## 🌐 Más nyelvek

- [🇺🇸 English](../README.md)
- [🇩🇪 Deutsch/Német](README.de.md)

## 🎯 Funkciók

### 🏗️ Alapinfrastruktúra
✅ **Teljes LEMP Stack telepítés**
- Nginx webszerver termelésre kész optimalizálással
- MySQL 8.0+ biztonságos beállítással és teljesítmény-hangolással
- PHP 8.3+ FPM-mel, OPcache-sel és WordPress bővítményekkel
- Ubuntu/Debian család támogatás (20.04, 22.04, 24.04, Debian 11, 12)

### 🛡️ WordPress és Biztonság
✅ **WordPress automatizálás és biztonság**
- Legújabb WordPress telepítés WP-CLI integrációval
- Automatikus adatbázis beállítás és biztonságos konfiguráció
- **Integrált SSL/HTTPS támogatás** Let's Encrypt-tel
- Biztonság megerősítés (megfelelő fájljogosultságok, biztonságos konfigurációk)

### ⚡ Teljesítmény és Gyorsítótárazás
✅ **Ultimate teljesítmény optimalizálás**
- **Redis objektum-gyorsítótárazás** adatbázis optimalizáláshoz
- **PHP OPcache** konfiguráció a jobb teljesítményért
- **MySQL teljesítmény-hangolás** optimalizált konfigurációkkal
- **Nginx optimalizálás** gzip-pel, cache headerekkel és worker hangolással

### 🔧 Termelési funkciók
✅ **Termelésre és fejlesztésre kész**
- **Két telepítési mód**: Alap LEMP + Ultimate Teljesítmény
- Docker tesztkörnyezet biztonságos teszteléshez
- **Moduláris, tiszta architektúra** - termelésben tesztelt és dokumentált
- **Idempotens playbook-ok** (biztonságosan többször futtatható)
- **SSL támogatás integrálva** mindkét telepítési módban

## 🚀 Gyors kezdés

### Előfeltételek

- **Ansible** 6.0+ a helyi gépén
- **Ubuntu/Debian szerver** (20.04+, Debian 11+)
- **SSH hozzáférés** a célszerverekhez
- **sudo jogosultságok** a célszervereken

### 1. Repository klónozása

```bash
git clone https://github.com/spalencsar/ansible-lemp-wordpress.git
cd ansible-lemp-wordpress
```

### 2. Inventory konfigurálása

```bash
cp inventory/production.yml.example inventory/production.yml
# Szerkessze az inventory/production.yml fájlt a szerver adataival
```

### 3. Válassza ki a telepítési módot

#### A opció: Alap LEMP + WordPress
```bash
# Standard LEMP stack WordPress-szel
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml
```

#### B opció: Ultimate teljesítmény beállítás
```bash
# LEMP + WordPress + Redis + OPcache + Nginx optimalizálás
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

#### C opció: SSL/HTTPS-szel
```bash
# SSL engedélyezése telepítés során
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml \
  -e "ssl_enabled=true" -e "ssl_email=az-on-email@domain.hu"

# Vagy Ultimate teljesítmény + SSL
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml \
  -e "ssl_enabled=true" -e "ssl_email=az-on-email@domain.hu"
```

### 4. WordPress oldal elérése

- **Weboldal**: `http://az-on-szerver-ip` (vagy `https://` ha SSL engedélyezett)
- **Admin panel**: `http://az-on-szerver-ip/wp-admin`
- **Alapértelmezett bejelentkezés**: Ellenőrizze az inventory fájlban a `wp_admin_user` és `wp_admin_password` értékeket
## 🐳 Docker tesztkörnyezet

Tökéletes teszteléshez termelési szerverek előtt:

```bash
cd docker/
docker-compose up -d

# Alap LEMP telepítés tesztelése
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Ultimate teljesítmény telepítés tesztelése
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress-ultimate.yml
```

Teszt oldal elérése: http://localhost:8080

## 📁 Projekt struktúra

```
ansible-lemp-wordpress/
├── playbooks/                    # Fő Ansible playbook-ok (TERMELÉSRE KÉSZ)
│   ├── lemp-wordpress.yml           # Alap LEMP + WordPress telepítés
│   └── lemp-wordpress-ultimate.yml  # Ultimate: LEMP + WordPress + Redis + OPcache + Optimalizálás
├── inventory/                    # Szerver inventory konfigurációk
│   ├── production.yml               # Termelési szerver konfiguráció
│   └── docker.yml                   # Docker teszt környezet
├── templates/                    # Jinja2 konfigurációs sablonok (TERMELÉSBEN TESZTELT)
│   ├── wp-config.php.j2            # WordPress konfiguráció
│   ├── wordpress.nginx.j2          # Nginx virtual host (HTTP)
│   ├── wordpress-ssl.nginx.j2      # Nginx virtual host (HTTPS)
│   ├── my.cnf.j2                   # MySQL konfiguráció
│   └── www.conf.j2                 # PHP-FPM pool konfiguráció
├── vars/                        # OS-specifikus változók
│   └── debian-family.yml           # Debian/Ubuntu változók
├── docker/                      # Docker teszt környezet
│   ├── docker-compose.yml          # Docker beállítás
│   ├── Dockerfile                  # Ubuntu teszt konténer
│   └── start-services.sh           # Szolgáltatás indító script
└── docs/                        # Dokumentáció
    ├── production-deployment.md
    ├── ssl-setup.md
    └── troubleshooting.md
```

## ⚙️ Konfiguráció

### Telepítési módok

**Alap LEMP mód** (`lemp-wordpress.yml`)
- Standard LEMP stack (Nginx, MySQL, PHP)
- WordPress WP-CLI-vel
- SSL támogatás (opcionális)
- Kis és közepes oldalakhoz alkalmas

**Ultimate teljesítmény mód** (`lemp-wordpress-ultimate.yml`) 
- Minden az alap módból, plusz:
- Redis objektum gyorsítótárazás
- PHP OPcache optimalizálás
- Nginx teljesítmény hangolás
- MySQL optimalizálás
- Nagy forgalmú oldalakhoz alkalmas

### SSL konfiguráció

Mindkét telepítési mód támogatja az SSL-t:

```yaml
# Az inventory/production.yml fájlban
wordpress_servers:
  hosts:
    az-on-szerver:
      ansible_host: az-on-ip
      ssl_enabled: true
      ssl_email: az-on-email@domain.hu
```

### Változó konfiguráció

**Alapvető WordPress változók:**
```yaml
# WordPress Admin
wp_admin_user: admin              # WordPress admin felhasználónév
wp_admin_password: "{{ vault_wp_admin_password }}"  # Használja az Ansible Vault-ot!
wp_admin_email: admin@domain.hu   # WordPress admin email
wp_site_title: "Az Én WordPress Oldalam"

# Adatbázis
mysql_root_password: "{{ vault_mysql_root_password }}"    # Használja az Ansible Vault-ot!
wordpress_db_name: wordpress
wordpress_db_user: wordpress
wordpress_db_password: "{{ vault_wordpress_db_password }}" # Használja az Ansible Vault-ot!

# SSL (opcionális)
ssl_enabled: false
ssl_email: admin@domain.hu
```

**Teljesítmény változók (Ultimate mód):**
```yaml
# Redis konfiguráció
redis_enabled: true
redis_maxmemory: 256mb

# PHP optimalizálás
php_memory_limit: 512M
php_upload_max_filesize: 128M
php_opcache_enabled: true

# Nginx optimalizálás
nginx_worker_processes: auto
nginx_optimization_enabled: true
```

### Szerver követelmények

- **OS**: Ubuntu 20.04+ vagy Debian 11+
- **RAM**: Minimum 1GB (2GB+ ajánlott Ultimate módhoz)
- **Tárhely**: Minimum 10GB szabad hely
- **Hálózat**: SSH hozzáférés + web portok (80/443)

## 🔒 Biztonság és legjobb gyakorlatok

### Biztonsági funkciók
- **Biztonságos jelszó kezelés** Ansible Vault-tal
- **Megfelelő fájljogosultságok** WordPress és rendszerfájlokhoz
- **MySQL biztonság** egyedi root jelszóval és korlátozott hozzáféréssel
- **Nginx biztonsági fejlécek** és konfiguráció megerősítés
- **SSL/HTTPS támogatás** Let's Encrypt integrációval

### Legjobb gyakorlatok
```bash
# Használja az Ansible Vault-ot érzékeny adatokhoz
ansible-vault create inventory/group_vars/all/vault.yml

# Példa vault.yml tartalom:
vault_mysql_root_password: "az-on-biztonsagos-mysql-jelszo"
vault_wp_admin_password: "az-on-biztonsagos-wp-jelszo"
vault_wordpress_db_password: "az-on-biztonsagos-db-jelszo"

# Telepítés vault-tal
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml --ask-vault-pass
```

## 🧪 Tesztelés

### Telepítés előtti tesztelés
```bash
# Először tesztelje Docker-rel
cd docker/
docker-compose up -d
ansible-playbook -i inventory/docker.yml playbooks/lemp-wordpress.yml

# Teszt környezet elérése
curl -I http://localhost:8080/
```

### Validációs parancsok
```bash
# WordPress telepítés ellenőrzése
curl -s http://az-on-szerver/ | grep "WordPress"

# Admin hozzáférés tesztelése
curl -I http://az-on-szerver/wp-admin/

# PHP verzió ellenőrzése
ansible all -i inventory/production.yml -m shell -a "php --version"

# MySQL kapcsolat tesztelése
ansible all -i inventory/production.yml -m shell -a "mysql -u root -p{{ vault_mysql_root_password }} -e 'SELECT VERSION();'"
```

## 🚀 Teljesítmény funkciók

### Alap mód teljesítmény
- **PHP-FPM optimalizálás** hangolt pool konfigurációval
- **MySQL optimalizálás** termelésre kész beállításokkal
- **Nginx optimalizálás** gzip tömörítéssel és cache fejlécekkel

### Ultimate mód teljesítmény  
Minden az alap módból, plusz:
- **Redis objektum gyorsítótárazás** adatbázis lekérdezés optimalizáláshoz
- **PHP OPcache** bytecode gyorsítótárazáshoz és javított PHP teljesítményhez
- **Fejlett Nginx hangolás** worker optimalizálással és kapcsolat kezeléssel
- **MySQL teljesítmény hangolás** fejlett konfigurációkkal

### Teljesítmény összehasonlítás
```bash
# Alap mód telepítése
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml

# Ultimate mód telepítése nagy forgalmú oldalakhoz
ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress-ultimate.yml
```

## 🌍 OS kompatibilitás

| OS | Verzió | Státusz | Megjegyzések |
|---|---|---|---|
| Ubuntu | 24.04 LTS | ✅ Teljesen tesztelt | Ajánlott |
| Ubuntu | 22.04 LTS | ✅ Teljesen tesztelt | Ajánlott |
| Ubuntu | 20.04 LTS | ✅ Támogatott | Tesztelt |
| Debian | 12 | ✅ Támogatott | Kompatibilis |
| Debian | 11 | ✅ Támogatott | Kompatibilis |

## 📚 Dokumentáció

- [Termelési telepítési útmutató](production-deployment.md)
- [SSL/Let's Encrypt beállítás](ssl-setup.md)
- [Hibaelhárítási útmutató](troubleshooting.md)
- [Közreműködési irányelvek](../CONTRIBUTING.md)

## 🤝 Közreműködés

Szívesen fogadjuk a közreműködést! Kérjük, olvassa el a [Közreműködési irányelveinket](../CONTRIBUTING.md) a részletekért.

1. Repository forkolása
2. Funkció branch létrehozása
3. Változtatások tesztelése a Docker környezettel
4. Pull request beküldése

## 📄 Licenc

Ez a projekt MIT licenc alatt áll - lásd a [LICENSE](../LICENSE) fájlt a részletekért.

## 🙏 Köszönetnyilvánítás

- [WordPress](https://wordpress.org/) - A fantasztikus CMS
- [WP-CLI](https://wp-cli.org/) - WordPress parancssori eszköz
- [Ansible](https://www.ansible.com/) - Automatizálási platform
- Közösségi közreműködők és tesztelők

## 📞 Támogatás

- 📧 **Issues**: [GitHub Issues](https://github.com/yourusername/ansible-lemp-wordpress/issues)
- 📖 **Dokumentáció**: [Wiki](https://github.com/yourusername/ansible-lemp-wordpress/wiki)
- 💬 **Beszélgetések**: [GitHub Discussions](https://github.com/yourusername/ansible-lemp-wordpress/discussions)

---

⭐ **Ha ez a projekt segít önnek, kérjük, adjon neki egy csillagot!** ⭐

## 👨‍💻 Szerző

**Sebastian Palencsár**
- Copyright (c) 2025 Sebastian Palencsár
- GitHub: [@spalencsar](https://github.com/spalencsar)
