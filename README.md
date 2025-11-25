# Med Event Model Workspace Setup
# Option A: Quick Start (Cloning this Repo): Use this if you want the standard setup immediately.
``` bash
git clone --recurse-submodules https://github.com/kmacman/med_event_model_workspace_setup
cd med_event_model_workspace_setup
bash setup.sh
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
wget https://github.com/kmacman/med_event_model_workspace_setup/raw/refs/heads/main/FIX/fastFuncs_linux.so -O meds_etl/fastbpe/fastFuncs_linux.so

# FIX: Temporary fix for meds_etl (Main branch missing config)
# copy the following file into the meds_etl folder (this should be fixed as soon as a pr is merged):
wget https://raw.githubusercontent.com/kmacman/med_event_model_workspace_setup/refs/heads/main/FIX/pyproject.toml -O meds_etl/pyproject.toml
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
bash update.sh
```
