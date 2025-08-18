#!/bin/bash

# Multi-Cloud Deployment Script for Debopam's Portfolio
# Usage: ./deploy.sh [platform] [environment]
# Platforms: github-pages, netlify, vercel, aws, gcp, azure, docker
# Environments: dev, staging, prod

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PORTFOLIO_NAME="debopam-portfolio"
GITHUB_REPO="proxymaster356/simple-portfolio"
BUILD_DIR="build"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check dependencies
check_dependencies() {
    local deps=("$@")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            print_error "$dep is not installed. Please install it first."
            exit 1
        fi
    done
}

# Function to build the site
build_site() {
    print_status "Building portfolio site..."
    
    # Create build directory
    rm -rf "$BUILD_DIR"
    mkdir -p "$BUILD_DIR"
    
    # Copy all files except build directory and git
    rsync -av --exclude="$BUILD_DIR" --exclude=".git" --exclude="node_modules" . "$BUILD_DIR/"
    
    # Optimize HTML files if html-minifier is available
    if command -v html-minifier-terser &> /dev/null; then
        print_status "Optimizing HTML files..."
        find "$BUILD_DIR" -name "*.html" -type f -exec html-minifier-terser \
            --collapse-whitespace \
            --remove-comments \
            --remove-empty-attributes \
            --remove-redundant-attributes \
            --use-short-doctype \
            --minify-css true \
            --minify-js true \
            --output {} {} \;
    fi
    
    # Add build metadata
    cat > "$BUILD_DIR/build-info.json" << EOF
{
    "buildTime": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "platform": "$1",
    "environment": "$2",
    "version": "$(git rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
}
EOF
    
    print_success "Site built successfully in $BUILD_DIR/"
}

# Function to deploy to GitHub Pages
deploy_github_pages() {
    print_status "Deploying to GitHub Pages..."
    check_dependencies "git"
    
    build_site "github-pages" "$1"
    
    # Use GitHub CLI if available, otherwise provide instructions
    if command -v gh &> /dev/null; then
        print_status "Using GitHub CLI for deployment..."
        cd "$BUILD_DIR"
        git init
        git add .
        git commit -m "Deploy portfolio to GitHub Pages - $(date)"
        git branch -M gh-pages
        gh repo set-default "$GITHUB_REPO"
        git push -f origin gh-pages
        cd ..
    else
        print_warning "GitHub CLI not found. Please push the $BUILD_DIR contents to gh-pages branch manually."
        print_status "URL: https://github.com/$GITHUB_REPO/tree/gh-pages"
    fi
    
    print_success "GitHub Pages deployment initiated!"
    print_status "Site will be available at: https://proxymaster356.github.io/simple-portfolio/"
}

# Function to deploy to Netlify
deploy_netlify() {
    print_status "Deploying to Netlify..."
    check_dependencies "netlify"
    
    build_site "netlify" "$1"
    
    # Deploy to Netlify
    cd "$BUILD_DIR"
    
    if [ "$1" = "prod" ]; then
        netlify deploy --prod --dir . --message "Production deployment - $(date)"
    else
        netlify deploy --dir . --message "Development deployment - $(date)"
    fi
    
    cd ..
    print_success "Netlify deployment completed!"
}

# Function to deploy to Vercel
deploy_vercel() {
    print_status "Deploying to Vercel..."
    check_dependencies "vercel"
    
    build_site "vercel" "$1"
    
    cd "$BUILD_DIR"
    
    if [ "$1" = "prod" ]; then
        vercel --prod --yes
    else
        vercel --yes
    fi
    
    cd ..
    print_success "Vercel deployment completed!"
}

# Function to deploy to AWS S3 + CloudFront
deploy_aws() {
    print_status "Deploying to AWS S3 + CloudFront..."
    check_dependencies "aws"
    
    build_site "aws" "$1"
    
    local bucket_name="${PORTFOLIO_NAME}-${1:-dev}"
    
    # Sync to S3
    aws s3 sync "$BUILD_DIR" "s3://$bucket_name" --delete
    
    # Invalidate CloudFront cache if distribution exists
    if aws cloudfront list-distributions --query "DistributionList.Items[?contains(Aliases.Items, '$bucket_name')].Id" --output text | grep -q .; then
        local distribution_id=$(aws cloudfront list-distributions --query "DistributionList.Items[?contains(Aliases.Items, '$bucket_name')].Id" --output text)
        aws cloudfront create-invalidation --distribution-id "$distribution_id" --paths "/*"
        print_status "CloudFront cache invalidated"
    fi
    
    print_success "AWS deployment completed!"
    print_status "Site URL: http://$bucket_name.s3-website-$(aws configure get region).amazonaws.com"
}

# Function to build and run Docker locally
deploy_docker() {
    print_status "Building and running Docker container..."
    check_dependencies "docker"
    
    # Build Docker image
    docker build -t "$PORTFOLIO_NAME:latest" .
    
    # Stop existing container if running
    docker stop "$PORTFOLIO_NAME" 2>/dev/null || true
    docker rm "$PORTFOLIO_NAME" 2>/dev/null || true
    
    # Run new container
    docker run -d -p 80:80 --name "$PORTFOLIO_NAME" "$PORTFOLIO_NAME:latest"
    
    print_success "Docker container is running!"
    print_status "Site available at: http://localhost"
    print_status "Container logs: docker logs $PORTFOLIO_NAME"
}

# Function to deploy to Google Cloud Platform
deploy_gcp() {
    print_status "Deploying to Google Cloud Platform..."
    check_dependencies "gcloud" "docker"
    
    local project_id=$(gcloud config get-value project)
    if [ -z "$project_id" ]; then
        print_error "Please set your GCP project: gcloud config set project YOUR_PROJECT_ID"
        exit 1
    fi
    
    # Build and push Docker image
    local image_name="gcr.io/$project_id/$PORTFOLIO_NAME:latest"
    docker build -t "$image_name" .
    docker push "$image_name"
    
    # Deploy to Cloud Run
    gcloud run deploy "$PORTFOLIO_NAME" \
        --image "$image_name" \
        --region us-central1 \
        --platform managed \
        --allow-unauthenticated \
        --memory 512Mi \
        --cpu 1
    
    print_success "GCP Cloud Run deployment completed!"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [platform] [environment]"
    echo ""
    echo "Platforms:"
    echo "  github-pages  Deploy to GitHub Pages"
    echo "  netlify       Deploy to Netlify"
    echo "  vercel        Deploy to Vercel"
    echo "  aws           Deploy to AWS S3 + CloudFront"
    echo "  gcp           Deploy to Google Cloud Platform"
    echo "  docker        Build and run Docker container locally"
    echo "  all           Deploy to all platforms (sequential)"
    echo ""
    echo "Environments:"
    echo "  dev           Development environment"
    echo "  staging       Staging environment"
    echo "  prod          Production environment"
    echo ""
    echo "Examples:"
    echo "  $0 github-pages prod"
    echo "  $0 netlify dev"
    echo "  $0 docker"
    echo "  $0 all prod"
}

# Main deployment logic
main() {
    local platform=${1:-github-pages}
    local environment=${2:-dev}
    
    print_status "Starting deployment to $platform ($environment environment)"
    
    case $platform in
        github-pages)
            deploy_github_pages "$environment"
            ;;
        netlify)
            deploy_netlify "$environment"
            ;;
        vercel)
            deploy_vercel "$environment"
            ;;
        aws)
            deploy_aws "$environment"
            ;;
        gcp)
            deploy_gcp "$environment"
            ;;
        docker)
            deploy_docker
            ;;
        all)
            print_status "Deploying to all platforms..."
            deploy_github_pages "$environment"
            sleep 2
            deploy_netlify "$environment"
            sleep 2
            deploy_vercel "$environment"
            print_success "All deployments completed!"
            ;;
        *)
            print_error "Unknown platform: $platform"
            show_usage
            exit 1
            ;;
    esac
    
    print_success "Deployment completed successfully! 🚀"
}

# Check if help is requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_usage
    exit 0
fi

# Run main function
main "$@"