#!/bin/bash

echo "===== Welcome to the Automated Deployment Script ====="

# Step 1: Collect User Inputs
read -p "Enter your Git repository URL: " GIT_REPO
read -p "Enter your Personal Access Token (PAT): " PAT
read -p "Enter the branch name (default is main): " BRANCH
BRANCH=${BRANCH:-main}  # if user doesn't enter, default to 'main'

echo "Now let's get your server details..."
read -p "Enter your remote server username: " SSH_USER
read -p "Enter your server IP address: " SERVER_IP
read -p "Enter path to your SSH private key file (e.g. ~/.ssh/id_rsa): " SSH_KEY
read -p "Enter your application port (inside the container): " APP_PORT

echo "All details collected successfully!"
echo "===== STEP 2: Clone or Update Repository ====="

# Extract repo name from URL (e.g. https://github.com/user/project.git → project)
REPO_NAME=$(basename -s .git "$GIT_REPO")

# Check if repo folder already exists
if [ -d "$REPO_NAME" ]; then
    echo " Repository already exists. Pulling latest changes..."
    cd "$REPO_NAME" || exit 1
    git pull origin "$BRANCH"
else
    echo " Cloning repository..."
    # Clone using PAT for authentication
    git clone https://${PAT}@${GIT_REPO#https://} --branch "$BRANCH"
    cd "$REPO_NAME" || exit 1
fi

# Verify clone was successful
if [ -d .git ]; then
    echo " Repository cloned successfully!"
else
    echo " Failed to clone repository. Please check your URL or PAT."
    exit 1
fi
