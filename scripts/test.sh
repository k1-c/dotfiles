#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to run Docker tests
run_docker_tests() {
    local test_type="$1"
    
    print_info "Running Docker test: $test_type"
    
    case "$test_type" in
        "full")
            docker-compose up --build dotfiles-test
            ;;
        "preinstall")
            docker-compose up --build test-preinstall
            ;;
        "config")
            docker-compose up --build test-config
            ;;
        "vscode")
            docker-compose up --build test-vscode
            ;;
        "fonts")
            docker-compose up --build test-fonts
            ;;
        "interactive")
            docker-compose up --build dotfiles-dev
            ;;
        *)
            print_error "Unknown test type: $test_type"
            echo "Available test types: full, preinstall, config, vscode, fonts, interactive"
            exit 1
            ;;
    esac
}

# Function to run validation tests
run_validation_tests() {
    print_info "Running validation tests in Docker container..."
    
    # Build and run container with test validation
    docker-compose up --build --exit-code-from dotfiles-test dotfiles-test
    
    # Run the test script inside the container
    docker-compose run --rm dotfiles-test bash -c "
        export PATH=\"\$HOME/.proto/bin:\$PATH\" && 
        deno run --allow-all lib/test.ts
    "
}

# Function to clean up Docker resources
cleanup_docker() {
    print_info "Cleaning up Docker resources..."
    docker-compose down --remove-orphans
    docker system prune -f
    print_success "Docker cleanup completed"
}

# Main script logic
case "${1:-help}" in
    "full")
        run_docker_tests "full"
        ;;
    "preinstall")
        run_docker_tests "preinstall"
        ;;
    "config")
        run_docker_tests "config"
        ;;
    "vscode")
        run_docker_tests "vscode"
        ;;
    "fonts")
        run_docker_tests "fonts"
        ;;
    "interactive"|"dev")
        run_docker_tests "interactive"
        ;;
    "validate")
        run_validation_tests
        ;;
    "cleanup")
        cleanup_docker
        ;;
    "help"|*)
        echo "🐳 Dotfiles Docker Testing Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  full        - Run full dotfiles installation test"
        echo "  preinstall  - Test system dependencies installation only"
        echo "  config      - Test configuration symlinks setup only"
        echo "  vscode      - Test VSCode extensions installation only"
        echo "  fonts       - Test Nerd Fonts installation only"
        echo "  interactive - Start interactive container for manual testing"
        echo "  validate    - Run validation tests after installation"
        echo "  cleanup     - Clean up Docker resources"
        echo "  help        - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 full                # Test complete installation"
        echo "  $0 interactive         # Start interactive testing environment"
        echo "  $0 validate           # Run validation tests"
        echo "  $0 cleanup            # Clean up Docker resources"
        ;;
esac