#!/bin/bash

# Set variables
PRIVATE_KEY="0x_your_private_key_here"

# Prompt for private key if not provided
if [ -z "$PRIVATE_KEY" ]; then
  read -p "Enter your private key (include 0x): " PRIVATE_KEY
fi

export PRIVATE_KEY=$PRIVATE_KEY

echo "Starting Ocean Node setup..."

# Function for option 1: Running Ocean Node in Docker
run_docker() {
  echo "Running Ocean Node in Docker..."
  # Check if the script exists
  if [ -f "scripts/ocean-node-quickstart.sh" ]; then
    chmod +x scripts/ocean-node-quickstart.sh
    ./scripts/ocean-node-quickstart.sh
  else
    echo "Error: 'scripts/ocean-node-quickstart.sh' not found. Please ensure the script exists or modify the setup process."
  fi
}

# Function for option 2: Running Ocean Node with PM2
run_pm2() {
  echo "Installing PM2..."
  npm install -g pm2

  echo "Setting up environment variables..."
  npm run envSetup || export PRIVATE_KEY=$PRIVATE_KEY

  echo "Starting Ocean Node with PM2..."
  pm2 start npm --name "ocean-node" -- run start
  echo "Ocean Node started with PM2."

  echo "PM2 commands:"
  echo "  pm2 list                 # View running processes"
  echo "  pm2 logs ocean-node       # View logs"
  echo "  pm2 restart ocean-node    # Restart the node"
  echo "  pm2 stop ocean-node       # Stop the node"
  echo "  pm2 delete ocean-node     # Delete the process"
}

# Function for option 3: Running Ocean Node with NPM
run_npm() {
  echo "Checking Node.js version..."
  nvm use || echo "Ensure you're using the correct Node version."

  echo "Installing dependencies..."
  npm install

  echo "Building project..."
  npm run build

  echo "Starting Typesense database with Docker..."
  docker-compose -f typesense-compose.yml up -d

  echo "Setting up environment variables..."
  ./src/helpers/scripts/setupNodeEnv.sh || export PRIVATE_KEY=$PRIVATE_KEY
  source .env

  echo "Starting Ocean Node..."
  npm run start
}

# Menu to choose an option
echo "Choose an option to run the Ocean Node:"
echo "1. Run in Docker"
echo "2. Run with PM2"
echo "3. Run with NPM"

read -p "Enter your choice (1/2/3): " choice

case $choice in
  1) run_docker ;;
  2) run_pm2 ;;
  3) run_npm ;;
  *) echo "Invalid choice. Exiting..." ;;
esac
