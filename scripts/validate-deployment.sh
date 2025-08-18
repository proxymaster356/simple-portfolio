#!/bin/bash

# Portfolio Deployment Validation Script
# Tests all deployment configurations and platform readiness

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[TEST]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Test file existence
test_file_exists() {
    local file=$1
    local description=$2
    
    if [ -f "$file" ]; then
        print_success "$description exists: $file"
        return 0
    else
        print_error "$description missing: $file"
        return 1
    fi
}

# Test directory existence
test_dir_exists() {
    local dir=$1
    local description=$2
    
    if [ -d "$dir" ]; then
        print_success "$description exists: $dir"
        return 0
    else
        print_error "$description missing: $dir"
        return 1
    fi
}

# Test HTML file validity
test_html_validity() {
    local file=$1
    
    print_status "Validating HTML: $file"
    
    # Basic HTML structure checks
    if grep -q "<!DOCTYPE html>" "$file" && \
       grep -q "<html" "$file" && \
       grep -q "</html>" "$file" && \
       grep -q "<head>" "$file" && \
       grep -q "</head>" "$file" && \
       grep -q "<body>" "$file" && \
       grep -q "</body>" "$file"; then
        print_success "HTML structure valid: $file"
        return 0
    else
        print_error "HTML structure invalid: $file"
        return 1
    fi
}

# Test Docker configuration
test_docker_config() {
    print_status "Testing Docker configuration..."
    
    if test_file_exists "Dockerfile" "Dockerfile" && \
       test_file_exists "docker-compose.yml" "Docker Compose config" && \
       test_file_exists ".dockerignore" "Docker ignore file" && \
       test_file_exists "docker/nginx.conf" "Nginx configuration"; then
        print_success "Docker configuration complete"
        return 0
    else
        print_error "Docker configuration incomplete"
        return 1
    fi
}

# Test cloud configurations
test_cloud_configs() {
    print_status "Testing cloud platform configurations..."
    
    local configs=(
        "netlify.toml:Netlify configuration"
        "vercel.json:Vercel configuration"
        "cloud-configs/aws-cloudformation.yml:AWS CloudFormation template"
        "cloud-configs/gcp-cloudrun.yml:Google Cloud Platform configuration"
        "cloud-configs/azure-deployment.yml:Azure deployment configuration"
    )
    
    local passed=0
    local total=${#configs[@]}
    
    for config in "${configs[@]}"; do
        local file="${config%%:*}"
        local desc="${config##*:}"
        
        if test_file_exists "$file" "$desc"; then
            ((passed++))
        fi
    done
    
    if [ $passed -eq $total ]; then
        print_success "All cloud configurations present ($passed/$total)"
        return 0
    else
        print_warning "Some cloud configurations missing ($passed/$total)"
        return 1
    fi
}

# Test GitHub Actions workflows
test_github_actions() {
    print_status "Testing GitHub Actions workflows..."
    
    local workflows=(
        ".github/workflows/deploy-to-pages.yml:GitHub Pages deployment"
        ".github/workflows/deploy-netlify.yml:Netlify deployment"
        ".github/workflows/deploy-vercel.yml:Vercel deployment"
        ".github/workflows/docker-build.yml:Docker build workflow"
        ".github/workflows/multi-cloud-deploy.yml:Multi-cloud deployment"
    )
    
    local passed=0
    local total=${#workflows[@]}
    
    for workflow in "${workflows[@]}"; do
        local file="${workflow%%:*}"
        local desc="${workflow##*:}"
        
        if test_file_exists "$file" "$desc"; then
            ((passed++))
        fi
    done
    
    if [ $passed -eq $total ]; then
        print_success "All GitHub Actions workflows present ($passed/$total)"
        return 0
    else
        print_error "GitHub Actions workflows incomplete ($passed/$total)"
        return 1
    fi
}

# Test deployment scripts
test_deployment_scripts() {
    print_status "Testing deployment scripts..."
    
    if test_file_exists "scripts/deploy.sh" "Main deployment script" && \
       [ -x "scripts/deploy.sh" ]; then
        print_success "Deployment script is executable"
        
        # Test script help
        if ./scripts/deploy.sh --help > /dev/null 2>&1; then
            print_success "Deployment script help works"
            return 0
        else
            print_error "Deployment script help failed"
            return 1
        fi
    else
        print_error "Deployment script issues"
        return 1
    fi
}

# Test HTML files
test_html_files() {
    print_status "Testing HTML files..."
    
    local html_files=(
        "index.html"
        "aboutme.html"
        "projects.html"
        "skills-and-expertise.html"
        "certificates3.html"
        "education.html"
        "photographys.html"
        "poster.html"
        "research.html"
        "publication.html"
        "event.html"
    )
    
    local passed=0
    local total=${#html_files[@]}
    
    for file in "${html_files[@]}"; do
        if [ -f "$file" ]; then
            if test_html_validity "$file"; then
                ((passed++))
            fi
        else
            print_warning "HTML file not found: $file"
        fi
    done
    
    if [ $passed -gt 0 ]; then
        print_success "HTML files validation passed ($passed/$total files)"
        return 0
    else
        print_error "No valid HTML files found"
        return 1
    fi
}

# Test Docker build
test_docker_build() {
    print_status "Testing Docker build..."
    
    if command -v docker > /dev/null 2>&1; then
        if docker build -t portfolio-test . --quiet > /dev/null 2>&1; then
            print_success "Docker build successful"
            
            # Clean up test image
            docker rmi portfolio-test > /dev/null 2>&1 || true
            return 0
        else
            print_error "Docker build failed"
            return 1
        fi
    else
        print_warning "Docker not available, skipping build test"
        return 0
    fi
}

# Test documentation
test_documentation() {
    print_status "Testing documentation..."
    
    if test_file_exists "README.md" "README file" && \
       test_file_exists "DEPLOYMENT.md" "Deployment documentation"; then
        
        # Check if README contains deployment information
        if grep -q "Multi-Cloud Deployment" README.md; then
            print_success "README contains deployment information"
            return 0
        else
            print_warning "README missing deployment information"
            return 1
        fi
    else
        print_error "Documentation incomplete"
        return 1
    fi
}

# Main test runner
main() {
    echo "🧪 Portfolio Deployment Validation"
    echo "=================================="
    echo ""
    
    local tests=(
        test_html_files
        test_docker_config
        test_cloud_configs
        test_github_actions
        test_deployment_scripts
        test_documentation
        test_docker_build
    )
    
    local passed=0
    local total=${#tests[@]}
    
    for test in "${tests[@]}"; do
        echo ""
        if $test; then
            ((passed++))
        fi
    done
    
    echo ""
    echo "🏁 Test Summary"
    echo "==============="
    
    if [ $passed -eq $total ]; then
        print_success "All tests passed! ($passed/$total) 🎉"
        echo ""
        echo "✅ Portfolio is ready for multi-cloud deployment!"
        echo ""
        echo "Next steps:"
        echo "1. Push changes to trigger GitHub Pages deployment"
        echo "2. Set up accounts on other platforms (Netlify, Vercel, etc.)"
        echo "3. Configure platform-specific secrets for automated deployment"
        echo "4. Test deployments using: ./scripts/deploy.sh [platform] prod"
        return 0
    else
        print_error "Some tests failed ($passed/$total)"
        echo ""
        echo "❌ Please fix the failing tests before deployment"
        return 1
    fi
}

# Run tests
main "$@"