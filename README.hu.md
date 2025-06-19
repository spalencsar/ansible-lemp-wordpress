# Ansible LEMP WordPress Automatizálás

🚀 **Teljesen automatizált LEMP stack (Linux, Nginx, MySQL, PHP) + WordPress telepítés Ansible-lel**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%20|%2022.04%20|%2024.04-orange)](https://ubuntu.com/)
[![Debian](https://img.shields.io/badge/Debian-11%20|%2012-red)](https://debian.org/)
[![Ansible](https://img.shields.io/badge/Ansible-6.0+-red)](https://www.ansible.com/)
[![WordPress](https://img.shields.io/badge/WordPress-6.8+-blue)](https://wordpress.org/)

## 🌐 Más nyelvek

- [English](README.md)
- [Deutsch/Német](README.de.md)

## 🎯 Funkciók

### Alapinfrastruktúra
✅ **Teljes LEMP Stack telepítés**
- Nginx webszerver optimalizált konfigurációval
- MySQL 8.0+ biztonságos beállítással
- PHP 8.3+ FPM-mel és WordPress bővítményekkel
- Ubuntu/Debian család támogatás (20.04, 22.04, 24.04, Debian 11, 12)

### WordPress és Biztonság
✅ **WordPress automatizálás**
- Legújabb WordPress telepítés hivatalos WP-CLI-vel
- Automatikus adatbázis beállítás és konfiguráció
- SSL/HTTPS Let's Encrypt integrációval
- Biztonság megerősítés (Fail2Ban, biztonságos konfigurációk)

### Teljesítmény és Monitoring
✅ **Teljesítmény optimalizálások**
- Redis/Memcached gyorsítótár támogatás
- PHP OPcache konfiguráció
- MySQL teljesítmény hangolás
- Automatizált biztonsági mentési rendszer megőrzéssel

### Fejlesztés és DevOps
✅ **Termelési és fejlesztési készenlét**
- Docker teszt környezet mellékelve
- GitHub Actions CI/CD pipeline
- Több környezet támogatás (Docker, VM-ek, bare metal)
- WordPress Multisite támogatás

### Dokumentáció és Támogatás
✅ **Fejlesztőbarát**
- Átfogó dokumentáció és útmutatók
- Hibaelhárítási útmutató gyakori megoldásokkal
- Közreműködési irányelvek nyílt forráskódú együttműködéshez
- Idempotens playbook-ok (biztonságosan többször futtatható)

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
# Termeléshez
cp inventory/production.example inventory/production.ini
# Szerkessze a production.ini fájlt a szerver adataival

# Helyi tesztekhez Docker-rel
cp inventory/docker.ini inventory/local.ini
```

### 3. Változók testreszabása

Szerkessze a változókat a playbook-jaiban vagy használja az `--extra-vars` opciót:

```bash
# Alapvető WordPress konfiguráció
wp_admin_user: admin
wp_admin_password: az_on_biztonsagos_jelszava
wp_admin_email: admin@azoldaluk.hu
wp_site_title: "Az Én WordPress Oldalam"

# Adatbázis konfiguráció
mysql_root_password: nagyon_biztonsagos_root_jelszo
wordpress_db_password: biztonsagos_wp_jelszo
```

### 4. LEMP + WordPress telepítése

```bash
# Alap LEMP stack + WordPress
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml

# SSL/HTTPS-szel (Let's Encrypt)
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml

# Fejlett teljesítmény funkciókkal
ansible-playbook -i inventory/production.ini playbooks/ultimate-performance-optimization.yml
```

### 5. WordPress oldal elérése

```bash
# Nyissa meg a böngészőjét és menjen a következő címre:
http://az-on-szerver-ip-je

# SSL beállításhoz:
https://az-on-domain-je.hu
```

## 📖 Részletes használat

### Elérhető Playbook-ok

| Playbook | Leírás | Felhasználási eset |
|----------|-----------|-------------------|
| `lemp-wordpress.yml` | Alap LEMP + WordPress | Gyors beállítás, fejlesztés |
| `lemp-wordpress-ssl.yml` | LEMP + WordPress + SSL | Termelés HTTPS-szel |
| `install-wordpress-official.yml` | Csak WordPress telepítés | Meglévő LEMP stack-ek |
| `ultimate-performance-optimization.yml` | Teljesítmény optimalizálások | Nagy teljesítményű weboldalak |
| `wordpress-advanced-features.yml` | Fejlett funkciók | Vállalati funkciók |

### Környezetspecifikus telepítés

#### Docker (Fejlesztés/Tesztelés)
```bash
# Docker környezet indítása
cd docker
docker-compose up -d

# Tesztek futtatása
ansible-playbook -i inventory/docker.ini playbooks/lemp-wordpress.yml
```

#### Felhő szerverek (AWS, GCP, Azure, DigitalOcean)
```bash
# Inventory konfigurálása felhő szerver IP-kkel
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml \
  --extra-vars "domain_name=azoldaluk.hu"
```

#### Bare Metal / VPS
```bash
# Közvetlen szerver hozzáférés
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml \
  --extra-vars "enable_ssl=true"
```

### Fejlett konfiguráció

#### SSL/Let's Encrypt engedélyezése
```bash
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress-ssl.yml \
  --extra-vars "domain_name=azoldaluk.hu admin_email=admin@azoldaluk.hu"
```

#### Teljesítmény funkciók engedélyezése
```bash
ansible-playbook -i inventory/production.ini playbooks/ultimate-performance-optimization.yml \
  --extra-vars "enable_redis=true enable_memcached=true"
```

#### WordPress Multisite beállítása
```bash
ansible-playbook -i inventory/production.ini playbooks/wordpress-advanced-features.yml \
  --extra-vars "enable_multisite=true"
```

## 🌍 Ubuntu/Debian támogatás

| OS | Verzió | Státusz |
|---|---|---|
| Ubuntu | 24.04 LTS | ✅ Teljesen tesztelve |
| Ubuntu | 22.04 LTS | ✅ Támogatott |
| Ubuntu | 20.04 LTS | ✅ Támogatott |
| Debian | 12 | ✅ Támogatott |
| Debian | 11 | ✅ Támogatott |

## 📚 Dokumentáció

- [Termelési telepítési útmutató](docs/production-deployment.md)
- [SSL/Let's Encrypt beállítás](docs/ssl-setup.md)
- [Hibaelhárítási útmutató](docs/troubleshooting.md)
- [Közreműködési irányelvek](CONTRIBUTING.md)

## 🤝 Közreműködés

Szívesen fogadunk közreműködéseket! Kérjük, olvassa el a [Közreműködési irányelveinket](CONTRIBUTING.md) a részletekért.

### Fejlesztés

```bash
# Repository fork-olása és klónozása
git clone https://github.com/az-on-felhasznalo-neve/ansible-lemp-wordpress.git

# Funkció branch létrehozása
git checkout -b feature/uj-funkcio

# Változtatások commit-olása
git commit -m "feat: Új funkció hozzáadása"

# Push és Pull Request létrehozása
git push origin feature/uj-funkcio
```

## 🐛 Hibaelhárítás

### Gyakori problémák

#### SSH kapcsolati hibák
```bash
# SSH kulcs jogosultságok ellenőrzése
chmod 600 ~/.ssh/id_rsa

# SSH kapcsolat tesztelése
ssh -i ~/.ssh/id_rsa felhasznalo@szerver-ip
```

#### Ansible jogosultsági hibák
```bash
# Sudo jogosultságok ellenőrzése
ansible all -i inventory/production.ini -m ping --ask-become-pass
```

#### WordPress telepítési hibák
```bash
# Adatbázis kapcsolat ellenőrzése
ansible-playbook -i inventory/production.ini playbooks/lemp-wordpress.yml --tags mysql -v
```

További hibaelhárításért tekintse meg a [Hibaelhárítási útmutatót](docs/troubleshooting.md).

## 📄 Licenc

Ez a projekt MIT licenc alatt áll - lásd a [LICENSE](LICENSE) fájlt a részletekért.

## 👨‍💻 Szerző

**Sebastian Palencsar**
- GitHub: [@spalencsar](https://github.com/spalencsar)
- LinkedIn: [Sebastian Palencsar](https://linkedin.com/in/spalencsar)

## 🙏 Köszönetnyilvánítás

- [Ansible Community](https://ansible.com) a fantasztikus automatizálási eszközért
- [WordPress Community](https://wordpress.org) a legjobb CMS-ért
- Minden közreműködőnek, aki javítja ezt a projektet

## ⭐ Csillag adása

Ha tetszik ez a projekt, kérjük, adjon neki egy csillagot a GitHub-on! ⭐

---

**Készítve ❤️-tel a DevOps közösségnek**
