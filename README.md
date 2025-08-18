# Debopam Dutta - Portfolio Website

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-deployed-success?style=for-the-badge&logo=github)](https://proxymaster356.github.io/simple-portfolio/)
[![Docker](https://img.shields.io/badge/Docker-ready-blue?style=for-the-badge&logo=docker)](https://github.com/proxymaster356/simple-portfolio/pkgs/container/simple-portfolio)
[![Netlify](https://img.shields.io/badge/Netlify-ready-00C7B7?style=for-the-badge&logo=netlify)](https://netlify.com)
[![Vercel](https://img.shields.io/badge/Vercel-ready-000000?style=for-the-badge&logo=vercel)](https://vercel.com)

A modern, responsive portfolio website showcasing personal projects, skills, photography, and achievements. Now available on multiple cloud platforms for maximum performance and availability.

## 🌐 Live Website

This portfolio is deployed on GitHub Pages: **[https://proxymaster356.github.io/simple-portfolio/](https://proxymaster356.github.io/simple-portfolio/)**

## ✨ Features

- **Responsive Design**: Optimized for all device sizes
- **Interactive Navigation**: Smooth menu system with hover effects
- **Dynamic Background**: Animated particle system
- **Portfolio Sections**:
  - About Me
  - Education
  - Skills & Expertise
  - Projects
  - Certificates
  - Photography Gallery
  - Research & Publications
  - Events & Posters

## 🚀 Multi-Cloud Deployment

This portfolio supports deployment to multiple cloud platforms for maximum availability and performance.

### 🌐 Live Deployments

- **GitHub Pages**: [https://proxymaster356.github.io/simple-portfolio/](https://proxymaster356.github.io/simple-portfolio/) ✅
- **Netlify**: Ready for deployment 🔧
- **Vercel**: Ready for deployment 🔧
- **AWS S3**: Ready for deployment 🔧
- **Google Cloud**: Ready for deployment 🔧
- **Azure**: Ready for deployment 🔧

### 🚀 Quick Deploy

```bash
# Deploy to GitHub Pages (automatic on push)
git push origin main

# Deploy to specific platform
./scripts/deploy.sh netlify prod
./scripts/deploy.sh vercel prod
./scripts/deploy.sh aws prod

# Deploy to all platforms
./scripts/deploy.sh all prod

# Run locally with Docker
docker-compose up -d
```

### 📋 Deployment Features

- **Automated CI/CD**: GitHub Actions workflows for all platforms
- **Docker Support**: Containerized deployment ready
- **CDN Integration**: Global content delivery on all platforms
- **SSL/HTTPS**: Automatic HTTPS on all deployments
- **Performance Optimization**: HTML minification and asset optimization
- **Security Headers**: Built-in security configurations

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

## 🛠️ Local Development

To run the site locally:

```bash
# Clone the repository
git clone https://github.com/proxymaster356/simple-portfolio.git
cd simple-portfolio

# Start a local server
python -m http.server 8000
# or
python3 -m http.server 8000

# Open in browser
open http://localhost:8000
```

## 📁 Project Structure

```
├── index.html              # Main landing page
├── aboutme.html            # About section
├── education.html          # Education background
├── skills-and-expertise.html  # Skills showcase
├── projects.html           # Project portfolio
├── certificates3.html      # Certifications
├── photographys.html       # Photography gallery
├── research.html           # Research work
├── publication.html        # Publications
├── event.html             # Events attended
├── poster.html            # Academic posters
├── photography/           # Image assets
└── .github/workflows/     # Deployment automation
```

## 🎨 Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript
- **Styling**: Custom CSS with CSS Grid and Flexbox
- **Icons**: Font Awesome
- **Fonts**: Google Fonts (Montserrat, Poppins)
- **Deployment**: GitHub Pages
- **CI/CD**: GitHub Actions

## 📱 Mobile Responsive

The website is fully responsive and optimized for:
- Desktop computers
- Tablets
- Mobile phones
- Various screen orientations

## 🔧 Customization

To customize this portfolio for your own use:

1. Update personal information in all HTML files
2. Replace images in the `photography/` folder
3. Modify the color scheme in CSS variables
4. Update project information and links
5. Replace social media links and contact information

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Feel free to fork this repository and submit pull requests for any improvements.

---

**Built with ❤️ by Debopam Dutta**