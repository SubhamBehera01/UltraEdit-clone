#!/bin/bash

# 1. Show current git status and branch
echo "📦 Current Git Status:"
git status

echo -e "\n🌿 Current Branch:"
git rev-parse --abbrev-ref HEAD

# 2. Pull latest changes for the current branch
echo -e "\n🔄 Pulling latest changes..."
git pull origin "$(git rev-parse --abbrev-ref HEAD)"

# 3. Show all remote branches
echo -e "\n🌐 Available Remote Branches:"
git fetch --all
git branch -r

# 4. Prompt for branch name to checkout
read -p $'\n👉 Enter the branch name you want to checkout (e.g., feature/login): ' branch

# 5. Check out the selected branch
git checkout "$branch" || git checkout -b "$branch" origin/"$branch"

# 6. Pull latest code on that branch
echo -e "\n📥 Pulling latest code from origin/$branch..."
git pull origin "$branch"

# 7. Restart gunicorn
echo -e "\n🚀 Restarting Gunicorn..."
sudo systemctl restart gunicorn

# 8. Clear Django cache
echo -e "\n🧹 Clearing Django cache..."
python3 manage.py clear_cache

echo -e "\n✅ Done."
