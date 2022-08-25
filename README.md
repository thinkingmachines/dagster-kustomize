# Dagster Pipeline Example

# Setup (using a container)

## Build and Run Dagster

``` bash
docker compose down  # if already running
docker compose build
docker compose up
```

**Done!** At this point, you should be able to successfully navigate to the [Dagit UI](https://localhost:3000) and launch the job

## Install Poetry (optional)
When using containerization, installing poetry locally is not necessary, but it is recommended; the venv it creates can be used for code completion, simple interactive debugging, and more

* Install [python 3.9](https://www.python.org/downloads/release/python-398/)
* Install [poetry](https://python-poetry.org/docs/)

# Alternative Setup (no container)
The alternative setup runs locally without any containerization

> **Note** It's recommended that the application is run using the [docker approach](#setup-using-a-container)
## Run Dagster Locally
Running locally is very similar to using the container

1. [Install poetry](#install-poetry-optional) (not optional in this case)
2. Export the [environment variable(s)](#configure-slack-optional)
3. Open a terminal in the project root and run the following commands

``` bash

# First command optional. creates `.venv` in the project root; very useful when using VSCode!
poetry config virtualenvs.in-project true
poetry install
# To use poetry (i.e. activate the virtualenv):
poetry shell
dagit -w workspace.yaml
```
