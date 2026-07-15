#!/bin/bash
# Build and deploy GitHub Pages site
set -e

SITE_DIR="/vol1/1000/HD1/APP/hermes/awork/blog"
PUBLIC_DIR="$SITE_DIR/public"

cd "$SITE_DIR"

echo "=== Fetching latest theme ==="
git submodule update --remote themes/PaperMod 2>/dev/null || true

echo "=== Building Hugo site ==="
hugo --minify

echo "=== Committing and pushing ==="
cd "$PUBLIC_DIR"

# Initialize or update the gh-pages branch content
git init
git config user.name "Hugo Deploy"
git config user.email "admin@88531.cn"
git add -A
git commit -m "Deploy $(date '+%Y-%m-%d %H:%M')" || echo "Nothing to commit"
git remote add origin https://github.com/personal82555/personal82555.github.io.git

# Push to main branch (GitHub Pages will serve from /docs or root)
cd "$SITE_DIR"
git add -A
git commit -m "Update content $(date '+%Y-%m-%d %H:%M')" || echo "Nothing to commit"
git push origin main

echo "=== Deploy complete ==="
echo "Visit: https://personal82555.github.io/"