#!/bin/bash

# Stop execution immediately if any command fails
set -e 

echo "🚀 Starting Workspace Setup..."

# --- STEP 1: LOAD UV ---
# Check if the 'module' command exists (Cluster specific)
if type module &> /dev/null; then
    echo "🔹 Loading UV module..."
    module add uv
else
    echo "⚠️  'module' command not found. Assuming 'uv' is already in PATH."
fi

# --- STEP 2: DOWNLOAD PATCHES ---
echo "⬇️  Downloading patched files..."

# Ensure the directory exists first to prevent errors
mkdir -p meds_etl/fastbpe

# Download the C++ compiled binary
wget -q --show-progress https://github.com/kmacman/med_event_model_workspace_setup/raw/refs/heads/main/FIX/fastFuncs_linux.so -O meds_etl/fastbpe/fastFuncs_linux.so
# Make it executable just in case
chmod +x meds_etl/fastbpe/fastFuncs_linux.so

# Download the missing pyproject.toml
wget -q https://raw.githubusercontent.com/kmacman/med_event_model_workspace_setup/refs/heads/main/FIX/pyproject.toml -O meds_etl/pyproject.toml

echo "✅ Patches applied."

# --- STEP 3: SYNC ENVIRONMENT ---
echo "📦 Installing dependencies with UV..."
uv sync

# --- STEP 4: FINISH ---
echo ""
echo "🎉 Setup Complete!"
echo "---------------------------------------------------"
echo "⚠️  IMPORTANT: Run this command to start working:"
echo ""
echo "    source .venv/bin/activate"
echo ""
echo "---------------------------------------------------"
