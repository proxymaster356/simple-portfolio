# 🌐 Cloud Deployment Guide

This document provides comprehensive instructions for deploying Debopam's Portfolio to various cloud platforms.

## 🚀 Quick Start

The portfolio supports multiple deployment methods:

### 1. Automated GitHub Actions Deployment (Recommended)
```bash
# Push to main branch triggers automatic deployment to GitHub Pages
git push origin main
```

### 2. Manual Deployment Script
```bash
# Deploy to GitHub Pages
./scripts/deploy.sh github-pages prod

# Deploy to Netlify
./scripts/deploy.sh netlify prod

# Deploy to Vercel
./scripts/deploy.sh vercel prod

# Deploy to all platforms
./scripts/deploy.sh all prod
```

### 3. Docker Container
```bash
# Build and run locally
docker-compose up -d

# Or use the deployment script
./scripts/deploy.sh docker
```

## 📋 Platform-Specific Deployment

### GitHub Pages
**Current Status**: ✅ Active
**URL**: https://proxymaster356.github.io/simple-portfolio/

#### Features:
- Automatic deployment via GitHub Actions
- Custom domain support
- HTTPS enabled
- HTML optimization during build

#### Setup:
1. Repository is already configured
2. GitHub Actions workflow handles deployment
3. Site automatically updates on push to main branch

### Netlify
**Status**: 🔧 Ready for deployment
**Configuration**: `netlify.toml`

#### Features:
- Instant deployments
- Custom redirects and headers
- Branch previews
- Form handling (if needed)

#### Setup:
1. Connect GitHub repository to Netlify
2. Set build command: `echo 'Static site - no build required'`
3. Set publish directory: `/`
4. Deploy automatically or use CLI

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login and deploy
netlify login
netlify deploy --prod
```

### Vercel
**Status**: 🔧 Ready for deployment
**Configuration**: `vercel.json`

#### Features:
- Global CDN
- Automatic HTTPS
- Branch deployments
- Serverless functions support (future)

#### Setup:
1. Install Vercel CLI: `npm install -g vercel`
2. Login: `vercel login`
3. Deploy: `vercel --prod`

### AWS S3 + CloudFront
**Status**: 🔧 Ready for deployment
**Configuration**: `cloud-configs/aws-cloudformation.yml`

#### Features:
- Global CDN with CloudFront
- Custom domain support
- SSL/TLS certificates
- Cost-effective scaling

#### Setup:
1. Deploy CloudFormation stack:
```bash
aws cloudformation deploy \
  --template-file cloud-configs/aws-cloudformation.yml \
  --stack-name debopam-portfolio \
  --parameter-overrides DomainName=your-domain.com
```

2. Upload files to S3:
```bash
aws s3 sync . s3://your-bucket-name --delete
```

### Google Cloud Platform
**Status**: 🔧 Ready for deployment
**Configuration**: `cloud-configs/gcp-cloudrun.yml`

#### Features:
- Cloud Run for containerized deployment
- Automatic scaling
- Custom domains
- Global load balancing

#### Setup:
1. Build and deploy:
```bash
gcloud builds submit --config cloud-configs/gcp-cloudrun.yml
```

2. Or use the deployment script:
```bash
./scripts/deploy.sh gcp prod
```

### Azure
**Status**: 🔧 Ready for deployment
**Configuration**: `cloud-configs/azure-deployment.yml`

#### Features:
- Azure Static Web Apps
- Container Instances support
- Custom domains
- Global distribution

#### Setup with Azure CLI:
```bash
az deployment group create \
  --resource-group your-rg \
  --template-file cloud-configs/azure-deployment.yml
```

## 🐳 Docker Deployment

### Local Development
```bash
# Build and run
docker-compose up -d

# Access at http://localhost
```

### Production Container Registry
The portfolio is available as a Docker image:
- **GitHub Container Registry**: `ghcr.io/proxymaster356/simple-portfolio:latest`

### Cloud Container Deployment

#### AWS ECS
```bash
# Create task definition using the Docker image
aws ecs register-task-definition --cli-input-json file://ecs-task-definition.json
```

#### Google Cloud Run
```bash
gcloud run deploy debopam-portfolio \
  --image ghcr.io/proxymaster356/simple-portfolio:latest \
  --region us-central1 \
  --allow-unauthenticated
```

#### Azure Container Instances
```bash
az container create \
  --resource-group myResourceGroup \
  --name debopam-portfolio \
  --image ghcr.io/proxymaster356/simple-portfolio:latest \
  --dns-name-label debopam-portfolio \
  --ports 80
```

## 🔧 Configuration Management

### Environment Variables
The portfolio supports the following environment variables:

- `NODE_ENV`: Environment mode (development/production)
- `DEPLOY_ENV`: Deployment environment (dev/staging/prod)

### Build Optimization
The build process includes:

1. **HTML Minification**: Removes whitespace and comments
2. **Asset Optimization**: Compresses images and static files
3. **Security Headers**: Adds security-focused HTTP headers
4. **Caching Strategy**: Implements appropriate cache policies

### Security Features
- **CSP Headers**: Content Security Policy implementation
- **HTTPS Redirect**: Forces HTTPS connections
- **Frame Protection**: Prevents clickjacking attacks
- **XSS Protection**: Cross-site scripting prevention

## 📊 Monitoring and Analytics

### Deployment Status
Each platform provides deployment status:

| Platform | Status | URL | Monitoring |
|----------|--------|-----|------------|
| GitHub Pages | ✅ Active | [Live Site](https://proxymaster356.github.io/simple-portfolio/) | GitHub Actions |
| Netlify | 🔧 Ready | TBD | Netlify Dashboard |
| Vercel | 🔧 Ready | TBD | Vercel Dashboard |
| AWS | 🔧 Ready | TBD | CloudWatch |
| GCP | 🔧 Ready | TBD | Cloud Monitoring |

### Performance Monitoring
- **Lighthouse**: Automated performance audits
- **Web Vitals**: Core web vitals tracking
- **Uptime Monitoring**: Available through each platform

## 🚨 Troubleshooting

### Common Issues

1. **Build Failures**
   - Check HTML syntax validation
   - Verify image paths and assets
   - Review workflow logs

2. **Deployment Errors**
   - Verify authentication credentials
   - Check platform-specific configurations
   - Review DNS settings for custom domains

3. **Performance Issues**
   - Enable CDN caching
   - Optimize image sizes
   - Implement compression

### Support Commands
```bash
# Check deployment status
./scripts/deploy.sh --help

# Test local build
python3 -m http.server 8080

# Validate Docker build
docker build -t test-portfolio .
docker run -p 8080:80 test-portfolio
```

## 🔄 Continuous Deployment

### GitHub Actions Workflows
1. **Main Deployment**: `.github/workflows/deploy-to-pages.yml`
2. **Multi-Cloud**: `.github/workflows/multi-cloud-deploy.yml`
3. **Docker Build**: `.github/workflows/docker-build.yml`

### Automatic Triggers
- **Push to main**: Deploys to GitHub Pages
- **Tagged releases**: Builds Docker images
- **Manual dispatch**: Allows manual deployments

## 📈 Scaling and Performance

### CDN Configuration
All platforms include global CDN support:
- **GitHub Pages**: GitHub's global CDN
- **Netlify**: Global edge network
- **Vercel**: Global edge network
- **AWS**: CloudFront distribution
- **GCP**: Global load balancer

### Caching Strategy
- **Static Assets**: 30-day cache
- **HTML Files**: 1-hour cache
- **Images**: 30-day cache
- **CSS/JS**: 7-day cache

## 📞 Support

For deployment support:
- **Repository Issues**: [GitHub Issues](https://github.com/proxymaster356/simple-portfolio/issues)
- **Documentation**: This file and inline comments
- **Deployment Logs**: Available in GitHub Actions

---

**Last Updated**: $(date)
**Version**: 2.0.0
**Platforms**: GitHub Pages, Netlify, Vercel, AWS, GCP, Azure, Docker