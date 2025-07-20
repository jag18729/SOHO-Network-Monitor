#!/bin/bash
# setup_project.sh

# Create the complete project structure
echo "🚀 Setting up Vandine Network Monitor..."

# Create project directory
mkdir -p vandine-network-monitor
cd vandine-network-monitor

# Initialize git
git init
git branch -M main

# Create directory structure
mkdir -p .github/workflows
mkdir -p docker/{django,fastapi,nginx,postgres}
mkdir -p src/django_app/{apps/{dashboard,network_monitor,api},static/{css,js,img},media,templates/{dashboard,network_monitor}}
mkdir -p src/fastapi_app/{app/{api,core,models,services},tests}
mkdir -p scripts tests/{django,fastapi}
mkdir -p monitoring/{prometheus,grafana}
mkdir -p .claude

# Create all the files from the artifacts above...
# (Copy all the content from the artifacts)

# Create initial Django app structure
cd src/django_app
django-admin startproject vandine_monitor .
cd ../..

# Make scripts executable
chmod +x scripts/*.sh

# Initialize git
git add .
git commit -m "Initial commit: Vandine Network Monitor setup"

# Create GitHub repository (if gh CLI is installed)
if command -v gh &> /dev/null; then
    gh repo create vandine-network-monitor --public --source=. --remote=origin --push
fi

echo "✅ Project setup complete!"
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env and configure"
echo "2. Run: docker-compose build"
echo "3. Run: docker-compose up -d"
echo "4. Run: docker-compose exec django python manage.py migrate"
echo "5. Run: docker-compose exec django python scripts/populate_data.py"
echo ""
echo "Access the application at:"
echo "- Dashboard: http://localhost"
echo "- FastAPI Docs: http://localhost/api/v1/docs"
echo "- Admin: http://localhost/admin"
