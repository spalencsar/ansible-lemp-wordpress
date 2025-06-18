FROM ubuntu:24.04

# Umgebungsvariablen setzen
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# System updaten und notwendige Pakete installieren
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget \
    vim \
    nano \
    git \
    systemctl \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# SSH-Verzeichnis erstellen
RUN mkdir /var/run/sshd

# Root-Passwort setzen (für Testing)
RUN echo 'root:password' | chpasswd

# SSH-Konfiguration für moderne Sicherheit
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config && \
    echo "ClientAliveCountMax 3" >> /etc/ssh/sshd_config

# Ansible-User erstellen mit modernen Standards
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible:ansible123' | chpasswd && \
    usermod -aG sudo ansible

# Sudo ohne Passwort für ansible-User (sicher für Testumgebung)
RUN echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/ansible && \
    chmod 0440 /etc/sudoers.d/ansible

# SSH-Keys-Verzeichnis für ansible-User erstellen
RUN mkdir -p /home/ansible/.ssh && \
    chown ansible:ansible /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh

# Webroot-Verzeichnis vorbereiten
RUN mkdir -p /var/www/html && \
    chown ansible:ansible /var/www/html

# Systemd-Ersatz für Container (optional)
RUN systemctl --user enable ssh || true

# Gesunde Defaults setzen
WORKDIR /home/ansible
USER root

# Start-Script kopieren
COPY start-services.sh /usr/local/bin/start-services.sh
RUN chmod +x /usr/local/bin/start-services.sh

# SSH-Port freigeben
EXPOSE 22

# Healthcheck hinzufügen
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD service ssh status || exit 1

# Start-Script ausführen
CMD ["/usr/local/bin/start-services.sh"]
