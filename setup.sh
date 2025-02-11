#!/bin/bash

# Define the main directory
AZURENOVA_PATH=~/AzureNova

echo "🚀 Initializing AzureNova setup..."
mkdir -p $AZURENOVA_PATH

# Define the folder structure
FOLDERS=(
    "archives"
    "core"
    "digital_soul"
    "brains"
    "llm_integration"
    "swift_app"
    "replication"
    "config"
    "logs"
    "scripts"
)

# Create folders
for folder in "${FOLDERS[@]}"; do
    mkdir -p "$AZURENOVA_PATH/$folder"
done

echo "✅ Folder structure created successfully!"

# Copy useful files from the old Swift app
SWIFT_OLD="$AZURENOVA_PATH/archives/padronique2_swift_app_copy"
SWIFT_NEW="$AZURENOVA_PATH/swift_app"

if [ -d "$SWIFT_OLD" ]; then
    echo "📂 Migrating essential files from Swift app..."
    cp -r $SWIFT_OLD/* $SWIFT_NEW/
    echo "✅ Swift app files copied!"
else
    echo "⚠️ No previous Swift app found. Skipping migration."
fi

# Create a config file for API keys
CONFIG_FILE="$AZURENOVA_PATH/config/api_keys.env"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "🛠 Setting up API key configuration..."
    echo "OPENAI_API_KEY=your_api_key_here" > $CONFIG_FILE
    echo "⚠️ Remember to update your API key in: $CONFIG_FILE"
fi

# Initialize Git repo and push changes
cd $AZURENOVA_PATH
git init
git add .
git commit -m "Initial AzureNova setup"
git remote add origin https://github.com/Actualvom/AzureNova-Setup.git
git branch -M main
git push -u origin main

echo "🚀 AzureNova is fully set up! 🎉"
