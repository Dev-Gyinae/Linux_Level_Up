#!/bin/bash

# Enhanced Log Backup Script with Verbose Copy Reporting
# Shows exactly what's being copied from where to where

function show_copy_operations() {
    echo "📁 Backup Contents Preview:"
    echo "┌──────────────────────────────────────┐"
    echo "│ FROM: /var/log/                     │"
    find /var/log/ -name '*.log' -printf "│ → %p\n" | sed '$a└──────────────────────────────────────┘'
    echo
    echo "🗄️  Will be packed to:"
    echo "┌──────────────────────────────────────┐"
    echo "│ TO: /backups/logs_$(date +%Y%m%d).tar.gz │"
    echo "└──────────────────────────────────────┘"
}

function setup_cron_backup() {
    echo "⏰ Setting up automatic daily backup..."
    echo "-------------------------------------"
    show_copy_operations
    
    if ! command -v cron &>/dev/null; then
        echo "➔ Installing cron..."
        sudo apt-get update && sudo apt-get install cron -y
    fi

    sudo mkdir -p /backups
    (
        crontab -l 2>/dev/null | grep -v "logs_.*\.tar\.gz"
        echo "0 2 * * * echo \"[ \$(date) ] Backing up:\" && find /var/log/ -name '*.log' -exec tar -cvzf /backups/logs_\$(date +\\%Y\\%m\\%d).tar.gz {} + && echo \"Saved to /backups/logs_\$(date +\\%Y\\%m\\%d).tar.gz\" >> /var/log/backup.log"
    ) | sudo crontab -
    
    echo "✅ Configured to run daily at 2 AM"
    echo "📝 Logs will be saved to: /var/log/backup.log"
}

function run_manual_backup() {
    echo "🔍 Preparing to backup..."
    show_copy_operations
    
    read -p "Continue? (y/n) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo
        echo "🔄 Copying files..."
        sudo mkdir -p /backups
        sudo tar -cvzf "/backups/logs_$(date +%Y%m%d).tar.gz" /var/log/*.log | sed 's|^|  ✓ |'
        
        echo "✅ Backup complete!"
        echo "📦 Archive saved to: /backups/logs_$(date +%Y%m%d).tar.gz"
        echo "📏 Size: $(du -h "/backups/logs_$(date +%Y%m%d).tar.gz" | cut -f1)"
    else
        echo -e "\n❌ Backup cancelled"
    fi
}

# Main Menu
echo "
╔══════════════════════════╗
║    LOG BACKUP MANAGER    ║
╠══════════════════════════╣
║ 1. Setup Auto Backup     ║
║ 2. Run Manual Backup Now ║
║ 3. Exit                 ║
╚══════════════════════════╝"

read -p "Select (1-3): " choice
case $choice in
    1) setup_cron_backup ;;
    2) run_manual_backup ;;
    3) exit 0 ;;
    *) echo "Invalid option"; exit 1 ;;
esac
