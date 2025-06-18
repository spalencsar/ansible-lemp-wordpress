#!/usr/bin/env python3
"""
Ansible inventory validation script
Validates inventory files for common issues and best practices
"""

import argparse
import configparser
import ipaddress
import os
import re
import sys
from pathlib import Path


class InventoryValidator:
    def __init__(self, inventory_file):
        self.inventory_file = Path(inventory_file)
        self.errors = []
        self.warnings = []
        
    def validate(self):
        """Run all validation checks"""
        if not self.inventory_file.exists():
            self.errors.append(f"Inventory file {self.inventory_file} does not exist")
            return False
            
        try:
            config = configparser.ConfigParser(allow_no_value=True)
            config.read(self.inventory_file)
            
            self._validate_groups(config)
            self._validate_hosts(config)
            self._validate_variables(config)
            self._validate_security(config)
            
        except configparser.Error as e:
            self.errors.append(f"INI parsing error: {e}")
            
        return len(self.errors) == 0
    
    def _validate_groups(self, config):
        """Validate group definitions"""
        required_groups = ['wordpress_servers']
        
        for group in required_groups:
            if group not in config.sections():
                self.errors.append(f"Required group '{group}' not found")
        
        # Check for empty groups
        for section in config.sections():
            if not config.options(section):
                self.warnings.append(f"Group '{section}' is empty")
    
    def _validate_hosts(self, config):
        """Validate host definitions"""
        host_pattern = re.compile(r'^[a-zA-Z0-9][a-zA-Z0-9\.-]*[a-zA-Z0-9]$')
        
        for section in config.sections():
            if ':vars' in section:
                continue
                
            for option in config.options(section):
                host_line = f"{option} {config.get(section, option) or ''}"
                host_name = option
                
                # Validate hostname format
                if not host_pattern.match(host_name) and not self._is_valid_ip(host_name):
                    self.warnings.append(f"Host '{host_name}' has unusual format")
                
                # Check for common connection variables
                if 'ansible_host=' in host_line:
                    ansible_host = self._extract_variable(host_line, 'ansible_host')
                    if ansible_host and not self._is_valid_ip(ansible_host) and not self._is_valid_hostname(ansible_host):
                        self.warnings.append(f"ansible_host '{ansible_host}' for host '{host_name}' looks invalid")
                
                # Check for insecure practices
                if 'ansible_ssh_pass=' in host_line:
                    self.warnings.append(f"Host '{host_name}' uses password authentication (consider SSH keys)")
                
                if 'ansible_become_pass=' in host_line:
                    self.warnings.append(f"Host '{host_name}' has become password in inventory (consider vault)")
    
    def _validate_variables(self, config):
        """Validate variable definitions"""
        wordpress_vars = [
            'mysql_root_password',
            'wordpress_db_password', 
            'wp_admin_password'
        ]
        
        for section in config.sections():
            if ':vars' not in section:
                continue
                
            for option in config.options(section):
                value = config.get(section, option)
                
                # Check for hardcoded passwords
                if any(var in option for var in wordpress_vars):
                    if value and len(value) < 8:
                        self.warnings.append(f"Variable '{option}' has weak password")
                    if value and value in ['password', 'admin', '123456']:
                        self.errors.append(f"Variable '{option}' has insecure default value")
    
    def _validate_security(self, config):
        """Validate security-related settings"""
        security_checks = {
            'ansible_host_key_checking': 'false',
            'ansible_ssh_common_args': '-o StrictHostKeyChecking=no'
        }
        
        for section in config.sections():
            for option in config.options(section):
                value = config.get(section, option) or ''
                
                for check, insecure_value in security_checks.items():
                    if check in value and insecure_value in value.lower():
                        self.warnings.append(f"Insecure setting detected: {check}={insecure_value}")
    
    def _is_valid_ip(self, ip_str):
        """Check if string is a valid IP address"""
        try:
            ipaddress.ip_address(ip_str)
            return True
        except ValueError:
            return False
    
    def _is_valid_hostname(self, hostname):
        """Check if string is a valid hostname"""
        if len(hostname) > 255:
            return False
        hostname = hostname.rstrip('.')
        allowed = re.compile(r'^[a-zA-Z0-9]([a-zA-Z0-9\-]*[a-zA-Z0-9])?$')
        return all(allowed.match(part) for part in hostname.split('.'))
    
    def _extract_variable(self, line, var_name):
        """Extract variable value from inventory line"""
        pattern = fr'{var_name}=([^\s]+)'
        match = re.search(pattern, line)
        return match.group(1) if match else None
    
    def print_results(self):
        """Print validation results"""
        if self.errors:
            print("❌ ERRORS:")
            for error in self.errors:
                print(f"  - {error}")
        
        if self.warnings:
            print("⚠️  WARNINGS:")
            for warning in self.warnings:
                print(f"  - {warning}")
        
        if not self.errors and not self.warnings:
            print("✅ Inventory validation passed!")
        
        return len(self.errors) == 0


def main():
    parser = argparse.ArgumentParser(description='Validate Ansible inventory files')
    parser.add_argument('inventory', help='Path to inventory file')
    parser.add_argument('--strict', action='store_true', help='Treat warnings as errors')
    
    args = parser.parse_args()
    
    validator = InventoryValidator(args.inventory)
    is_valid = validator.validate()
    validator.print_results()
    
    if args.strict and validator.warnings:
        is_valid = False
    
    sys.exit(0 if is_valid else 1)


if __name__ == '__main__':
    main()
