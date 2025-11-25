# Med Event Model Workspace Setup
# Option A: Quick Start (Cloning this Repo): Use this if you want the standard setup immediately.
``` bash

#1. Clone the repo and all submodules in one go
git clone --recurse-submodules https://github.com/kmacman/med_event_model_workspace_setup
cd med_event_model_workspace_setup

# 2. Load UV (Cluster specific)
module add uv

# 3. Copy the compiled c++ tokenizer file into meds_etl/fastbpe

# FIX: Temporary fix for meds_etl (Main branch missing config)
# copy the following file into the meds_etl folder (this should be fixed as soon as a pr is merged): https://github.com/ajloza/meds_etl/blob/kmacman-pyproject-toml/pyproject.toml

# 4. Sync the environment - This reads pyproject.toml and installs all dependencies (including submodules)
uv sync

#5. Activate the environment
source .venv/bin/activate
```
> Note: You must have your git config user.email set up to access the private submodules.

# Option B: Building from Scratch (No Clone)
## Use this if you are starting a fresh project folder but need these tools.

## 1. Initialize Project
```Bash

mkdir my_new_project
cd my_new_project
module add uv
uv init
```
## 2. Add Standard Libraries
```Bash
uv add polars ipython jupyter regex numpy
```
## 3. Add Custom Libraries (Submodules)
### We use git submodules so we can track specific versions of the libraries.

```Bash

# Add the repositories
git submodule add https://github.com/ajloza/meds_etl
git submodule add https://github.com/ajloza/EventExpressions

# Copy the compiled C++ file into meds_etl/fastbpe

# FIX: Temporary fix for meds_etl (Main branch missing config)
# copy the following file into the meds_etl folder (this should be fixed as soon as a pr is merged): https://github.com/ajloza/meds_etl/blob/kmacman-pyproject-toml/pyproject.toml
```
## 4. Link Libraries to UV
### We use --editable so changes in the folder are immediately reflected in your code.

```Bash

uv add --editable ./EventExpressions
uv add --editable ./meds_etl
```
## How to Work & Update
### Imports:

```Python

from meds_etl.tokenizer import Tokenizer
from EventExpressions import *
```
### Updating the Libraries: If meds_etl or EventExpressions has a new update on GitHub:

```Bash

# 1. Pull the latest code for the library
git submodule update --remote meds_etl

# 2. Sync dependencies (only if the library added new requirements)
uv sync
```
