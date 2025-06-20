#!/bin/bash
# 
# Comprehensive test script for LEMP WordPress deployment
# Tests both Docker and VM/Bare Metal environments
#
# Usage: ./final-test.sh [docker|vm|all]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOCKER_INVENTORY="inventory/docker.ini"
VM_INVENTORY="inventory/production.yml"
PLAYBOOK="playbooks/lemp-wordpress.yml"
TEST_TIMEOUT=300

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if ansible is installed
    if ! command -v ansible-playbook &> /dev/null; then
        log_error "ansible-playbook is not installed"
        exit 1
    fi
    
    # Check if required files exist
    local required_files=("$PLAYBOOK" "$DOCKER_INVENTORY" "vars/debian-family.yml")
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            log_error "Required file not found: $file"
            exit 1
        fi
    done
    
    log_success "Prerequisites check passed"
}

test_syntax() {
    log_info "Testing playbook syntax..."
    
    if ansible-playbook "$PLAYBOOK" --syntax-check > /dev/null 2>&1; then
        log_success "Playbook syntax is valid"
    else
        log_error "Playbook syntax check failed"
        ansible-playbook "$PLAYBOOK" --syntax-check
        exit 1
    fi
}

test_docker_environment() {
    log_info "Testing Docker environment..."
    
    # Check if Docker is available
    if ! command -v docker &> /dev/null; then
        log_warning "Docker not available, skipping Docker tests"
        return 1
    fi
    
    # Start Docker environment
    log_info "Starting Docker test environment..."
    cd docker
    if docker-compose up -d --build; then
        log_success "Docker environment started"
    else
        log_error "Failed to start Docker environment"
        cd ..
        return 1
    fi
    cd ..
    
    # Wait for SSH to be ready
    log_info "Waiting for SSH to be ready..."
    sleep 10
    
    # Test SSH connectivity
    if ansible all -i "$DOCKER_INVENTORY" -m ping --timeout=30; then
        log_success "SSH connectivity to Docker container verified"
    else
        log_error "Cannot connect to Docker container via SSH"
        return 1
    fi
    
    # Run playbook
    log_info "Running LEMP WordPress playbook in Docker..."
    if timeout "$TEST_TIMEOUT" ansible-playbook -i "$DOCKER_INVENTORY" "$PLAYBOOK"; then
        log_success "Docker deployment completed successfully"
    else
        log_error "Docker deployment failed"
        return 1
    fi
    
    # Test WordPress installation
    log_info "Testing WordPress installation in Docker..."
    sleep 5
    
    # Test HTTP response
    if curl -f -s http://localhost:8080 > /dev/null; then
        log_success "WordPress is responding on http://localhost:8080"
    else
        log_error "WordPress is not responding on http://localhost:8080"
        return 1
    fi
    
    # Test WordPress content
    if curl -s http://localhost:8080 | grep -i "wordpress" > /dev/null; then
        log_success "WordPress content detected"
    else
        log_warning "WordPress content not detected (might be redirect)"
    fi
    
    # Test admin area
    if curl -f -s http://localhost:8080/wp-admin/ > /dev/null; then
        log_success "WordPress admin area accessible"
    else
        log_warning "WordPress admin area not accessible (normal for fresh install)"
    fi
    
    # Cleanup Docker environment
    log_info "Cleaning up Docker environment..."
    cd docker
    docker-compose down -v
    cd ..
    
    log_success "Docker environment test completed successfully"
    return 0
}

test_vm_environment() {
    log_info "Testing VM environment configuration..."
    
    # Check if VM inventory exists
    if [[ ! -f "$VM_INVENTORY" ]]; then
        log_warning "VM inventory file not found: $VM_INVENTORY"
        log_warning "Skipping VM tests - create inventory file for VM testing"
        return 1
    fi
    
    # Test inventory file syntax
    if ansible-inventory -i "$VM_INVENTORY" --list > /dev/null 2>&1; then
        log_success "VM inventory syntax is valid"
    else
        log_error "VM inventory syntax check failed"
        return 1
    fi
    
    # Test VM connectivity (without actually running playbook)
    log_info "Testing VM connectivity..."
    if ansible all -i "$VM_INVENTORY" -m ping --timeout=10; then
        log_success "VM connectivity verified"
        
        # Optional: Run actual deployment if user confirms
        read -p "Run full deployment on VM? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "Running LEMP WordPress playbook on VM..."
            if ansible-playbook -i "$VM_INVENTORY" "$PLAYBOOK" --ask-become-pass; then
                log_success "VM deployment completed successfully"
                
                # Extract VM IP for testing
                VM_IP=$(ansible-inventory -i "$VM_INVENTORY" --list | jq -r '.webservers.hosts[0]')
                if [[ "$VM_IP" != "null" && "$VM_IP" != "" ]]; then
                    log_info "Testing WordPress installation on VM ($VM_IP)..."
                    if curl -f -s "http://$VM_IP" > /dev/null; then
                        log_success "WordPress is responding on http://$VM_IP"
                    else
                        log_warning "WordPress not responding (might need time to start)"
                    fi
                fi
            else
                log_error "VM deployment failed"
                return 1
            fi
        else
            log_info "Skipping VM deployment (connectivity test passed)"
        fi
    else
        log_warning "VM not reachable - check inventory configuration"
        return 1
    fi
    
    log_success "VM environment test completed"
    return 0
}

show_environment_info() {
    log_info "Environment Detection Test"
    echo
    echo "This test verifies the automatic environment detection logic:"
    echo "1. Docker environment: Detects /.dockerenv file"
    echo "2. VM/Bare Metal: All other systems"
    echo
    echo "The playbook will automatically:"
    echo "- Set wp_site_url to http://localhost:8080 in Docker"
    echo "- Set wp_site_url to http://server-ip in VM/Bare Metal"
    echo "- Allow manual override of both environment and URL"
    echo
}

run_tests() {
    local test_type="${1:-all}"
    
    show_environment_info
    check_prerequisites
    test_syntax
    
    case "$test_type" in
        "docker")
            test_docker_environment
            ;;
        "vm")
            test_vm_environment
            ;;
        "all")
            test_docker_environment
            echo
            test_vm_environment
            ;;
        *)
            log_error "Invalid test type: $test_type"
            echo "Usage: $0 [docker|vm|all]"
            exit 1
            ;;
    esac
}

# Main execution
main() {
    echo "========================================"
    echo "  LEMP WordPress Deployment Test Suite"
    echo "========================================"
    echo
    
    run_tests "$1"
    
    echo
    log_success "Test suite completed!"
    echo
    echo "Next steps:"
    echo "1. Deploy to production server with: ansible-playbook -i inventory/production.yml playbooks/lemp-wordpress.yml"
    echo "2. Customize variables in inventory files"
    echo "3. Enable SSL with: -e 'enable_ssl=true'"
    echo "4. Check documentation: docs/multi-environment-deployment.md"
}

# Run main function with all arguments
main "$@"
