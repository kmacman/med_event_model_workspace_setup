#!/bin/bash
set -e

echo "🔄 Checking for updates..."

# 1. Update the Main Repository (The workspace itself)
echo "   - Pulling workspace changes..."
git pull

# 2. Update Submodules to their latest remote versions
#    (This ignores the specific commit pinned in the repo and grabs the latest 'main')
echo "   - Updating libraries (meds_etl, EventExpressions)..."
git submodule update --remote --merge

# 3. RE-APPLY PATCHES
#    (We do this again because a git update might overwrite files or the binary might have changed)
echo "   - Re-applying patches..."
# Re-download binary (just in case)
wget -q -N https://github.com/kmacman/med_event_model_workspace_setup/raw/refs/heads/main/FIX/fastFuncs_linux.so -O meds_etl/fastbpe/fastFuncs_linux.so
chmod +x meds_etl/fastbpe/fastFuncs_linux.so

# Re-download pyproject.toml if upstream hasn't fixed it yet
# (Using -N to only download if newer, though overwriting is safer here to ensure consistency)
wget -q https://raw.githubusercontent.com/kmacman/med_event_model_workspace_setup/refs/heads/main/FIX/pyproject.toml -O meds_etl/pyproject.toml

# 4. Sync UV
#    (In case the new library versions added new dependencies)
echo "📦 Syncing environment dependencies..."
uv sync

echo "✅ Update Complete!"
