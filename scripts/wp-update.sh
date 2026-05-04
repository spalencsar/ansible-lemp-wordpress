#!/bin/bash
#
# WordPress Auto-Update Script
# Usage: ./wp-update.sh [--minor|--major|--force] [--backup]
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORDPRESS_PATH="${WORDPRESS_PATH:-/var/www/html}"
BACKUP_PATH="${BACKUP_PATH:-/var/backups/wordpress}"
LOG_FILE="${LOG_FILE:-/var/log/wp-update.log}"

MODE="minor"
DO_BACKUP=true

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

error_exit() {
    log "ERROR: $1"
    wp maintenance-mode deactivate 2>/dev/null || true
    exit 1
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --minor)
            MODE="minor"
            shift
            ;;
        --major)
            MODE="major"
            shift
            ;;
        --force)
            MODE="force"
            shift
            ;;
        --no-backup)
            DO_BACKUP=false
            shift
            ;;
        *)
            echo "Usage: $0 [--minor|--major|--force] [--no-backup]"
            exit 1
            ;;
    esac
done

log "========================================"
log "WordPress Update Started (Mode: $MODE)"
log "========================================"

cd "$WORDPRESS_PATH"

if [ ! -f "wp-config.php" ]; then
    error_exit "WordPress not found at $WORDPRESS_PATH"
fi

if $DO_BACKUP; then
    log "Creating database backup..."
    
    BACKUP_DIR="$BACKUP_PATH/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    if wp db export "$BACKUP_DIR/wp-db.sql"; then
        log "Database backup saved to $BACKUP_DIR/wp-db.sql"
    else
        error_exit "Database backup failed"
    fi
    
    log "Creating file backup..."
    tar -czf "$BACKUP_DIR/wp-files.tar.gz" -C "$(dirname "$WORDPRESS_PATH")" "$(basename "$WORDPRESS_PATH")" 2>/dev/null || true
    log "File backup saved to $BACKUP_DIR/wp-files.tar.gz"
fi

log "Activating maintenance mode..."
wp maintenance-mode activate || error_exit "Failed to activate maintenance mode"

log "Checking for WordPress updates..."
if [ "$MODE" = "major" ]; then
    wp core update || log "No major update available or update failed"
elif [ "$MODE" = "force" ]; then
    wp core update --force || log "Update failed"
else
    wp core update --minor || log "No minor update available"
fi

log "Running database updates..."
wp core update-db || log "No database update needed"

log "Updating plugins..."
wp plugin update --all || log "Plugin update completed with warnings"

log "Updating themes..."
wp theme update --all || log "Theme update completed with warnings"

log "Verifying WordPress installation..."
wp core verify-checksums || log "Checksum verification completed with warnings"

log "Deactivating maintenance mode..."
wp maintenance-mode deactivate || true

log "========================================"
log "WordPress Update Completed Successfully"
log "========================================"

wp plugin list --status=active --format=table 2>/dev/null | tee -a "$LOG_FILE"

echo ""
log "Updated WordPress version:"
wp core version

exit 0