#!/usr/bin/env python3
"""
Documentation Variable Processor
Replaces {{ variable }} placeholders in documentation files with values from vars/debian-family.yml
"""

import os
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.dirname(SCRIPT_DIR)
VARS_FILE = os.path.join(ROOT_DIR, 'vars', 'debian-family.yml')
DOCS_DIR = os.path.join(ROOT_DIR, 'docs')

def load_variables():
    """Load variables from debian-family.yml"""
    with open(VARS_FILE, 'r') as f:
        content = f.read()
    
    php_version = None
    for line in content.split('\n'):
        if 'php_version:' in line:
            php_version = line.split(':')[-1].strip().strip('"')
            break
    
    return {
        'php_version': php_version or '8.4',
    }

def process_file(filepath, variables):
    """Replace {{ variable }} patterns in a file"""
    with open(filepath, 'r') as f:
        content = f.read()
    
    original = content
    
    pattern = r'\{\{\s*php_version\s*\}\}'
    
    content = content.replace('{{ php_version }}', variables['php_version'])
    
    if content != original:
        with open(filepath, 'w') as f:
            f.write(content)
        return True
    return False

def main():
    variables = load_variables()
    
    print(f"Using PHP version: {variables['php_version']}")
    
    changed = 0
    for filename in os.listdir(DOCS_DIR):
        if filename.endswith('.md'):
            filepath = os.path.join(DOCS_DIR, filename)
            if process_file(filepath, variables):
                print(f"  Updated: {filename}")
                changed += 1
    
    for root, dirs, files in os.walk(ROOT_DIR):
        for f in files:
            if f == 'troubleshooting.md' or f == 'production-deployment.md':
                filepath = os.path.join(root, f)
                if process_file(filepath, variables):
                    print(f"  Updated: {f}")
                    changed += 1
    
    print(f"\nDone. {changed} file(s) updated.")
    return 0

if __name__ == '__main__':
    sys.exit(main())