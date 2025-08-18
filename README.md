# Debopam Dutta - Portfolio Website

A modern, responsive portfolio website showcasing personal projects, skills, photography, and achievements.

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

## 🚀 Deployment

This site is automatically deployed to GitHub Pages using GitHub Actions whenever changes are pushed to the main branch.

### Deployment Workflow

The site uses a GitHub Actions workflow (`.github/workflows/deploy-to-pages.yml`) that:

1. **Builds** the static site
2. **Uploads** all files as a Pages artifact
3. **Deploys** to GitHub Pages environment

### Manual Deployment

If you need to manually trigger a deployment:

1. Go to the "Actions" tab in the GitHub repository
2. Select "Deploy Static Site to GitHub Pages"
3. Click "Run workflow"

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