# Makefile for deploying a Flutter Web project to GitHub Pages

# Usage:
#   make deploy OUTPUT=my_repo_name

# GitHub username
GITHUB_USER := patriciob00

# GitHub repo via SSH (used for pushing)
GITHUB_REPO := git@github.com-personal:$(GITHUB_USER)/$(OUTPUT).git

# Extract version from pubspec.yaml
BUILD_VERSION := $(shell grep '^version:' pubspec.yaml | awk '{print $$2}')

# Base path for GitHub Pages hosting
BASE_HREF := /$(OUTPUT)/

.PHONY: deploy

deploy:
ifndef OUTPUT
	$(error ❌ OUTPUT is not set. Usage: make deploy OUTPUT=<repo_name>)
endif
	@echo "🧼 Cleaning project..."
	flutter clean
	@echo "📦 Getting dependencies..."
	flutter pub get
	@echo "🛠️  Ensuring web platform is enabled..."
	flutter config --enable-web
	@echo "🚧 Building web project..."
	flutter build web --base-href=$(BASE_HREF) --release
	@echo "🚀 Preparing GitHub Pages deployment..."
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main
	@echo ""
	@echo "✅ Deployment finished"
	@echo "🌐 URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"