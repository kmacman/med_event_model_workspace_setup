Make a new folder for your project/workspace and setup an env

`module add uv`

`uv init` 

`uv venv`

For regular dependencies, just do uv add:

`uv add polars ipython jupyter regex numpy`

To add our libraries from git, use git submodules:

(You will need access from Andrew and will need to set your git config user.email in order to clone private repos)

`git submodule add https://github.com/ajloza/meds_etl #you will need to compile the c++ FastBPE file in meds_etl/fastbpe` 

`git submodule add https://github.com/ajloza/EventExpressions`


Then, you can add them as a local dependency:

`uv pip install -e ./EventExpressions`

`uv pip install -e ./meds_etl #This doesn't work yet for meds_etl on the main branch, you can copy the pyproject.toml file from the kmacman-pyproject-toml branch if you want or just wait until it is merged` 


Now, if you are in a notebook in the root directory, you could load the tokenizer using

`from meds_etl.tokenizer import Tokenizer`

`from EventExpressions import *`

Whenever there is an update to these repos, all you need to do is:

`git submodule update --remote meds_etl #or EventExpressions`

`uv sync #only needed if the dependencies of the libraries changed`


This way, you can still have your own repo for you to do version control of whatever you are working on in the root directory while having access to EventExpressions, meds_etl, etc, in a way that allows for easy updating whenever these libraries change.
