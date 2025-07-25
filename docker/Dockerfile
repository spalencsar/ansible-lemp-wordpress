# Optimized multi-stage Dockerfile for LEMP WordPress testing
# This Dockerfile creates a lightweight, secure testing environment

# Stage 1: Base system with essential packages
FROM ubuntu:24.04 AS base

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# Create necessary directories and users early
RUN mkdir -p /var/run/sshd /var/log/supervisor \
    && groupadd -r ansible && useradd -r -g ansible ansible \
    && echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install base system packages in a single layer
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    # Core system
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https \
    # SSH and system control
    openssh-server \
    sudo \
    systemd \
    systemd-sysv \
    # Python for Ansible
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    # Essential utilities
    curl \
    wget \
    unzip \
    git \
    vim \
    nano \
    htop \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Stage 2: Runtime with LEMP stack
FROM base AS runtime

# Install LEMP stack packages
RUN apt-get update && apt-get install -y \
    # Web server
    nginx \
    # Database
    mysql-server \
    mysql-client \
    # PHP and extensions
    php8.3 \
    php8.3-fpm \
    php8.3-cli \
    php8.3-mysql \
    php8.3-gd \
    php8.3-xml \
    php8.3-mbstring \
    php8.3-curl \
    php8.3-zip \
    php8.3-intl \
    php8.3-soap \
    php8.3-xmlrpc \
    php8.3-opcache \
    php8.3-redis \
    # Security and monitoring
    fail2ban \
    ufw \
    # Cache systems (optional)
    redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo 'root:password' | chpasswd \
    && echo 'ansible:ansible' | chpasswd

# Configure systemd
RUN systemctl enable ssh \
    && systemctl enable nginx \
    && systemctl enable mysql \
    && systemctl enable php8.3-fpm

# Create web directory structure
RUN mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Copy service startup script
COPY start-services.sh /usr/local/bin/start-services.sh
RUN chmod +x /usr/local/bin/start-services.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Expose ports
EXPOSE 22 80 443

# Set working directory
WORKDIR /var/www/html

# Use systemd as init system for proper service management
CMD ["/usr/local/bin/start-services.sh"]

# Labels for metadata
LABEL org.opencontainers.image.title="LEMP WordPress Testing Environment"
LABEL org.opencontainers.image.description="Ubuntu 24.04 with Nginx, MySQL, PHP 8.3 for WordPress testing"
LABEL org.opencontainers.image.version="1.0"
LABEL org.opencontainers.image.licenses="MIT"
