#!/bin/bash

# use (like `cypress run`)
# ./cypress_run_example.sh --browser chrome

export PATH_HOST_TESTS=./tests
export PATH_HOST_REPORTS=./reports
mkdir -p ${PATH_HOST_REPORTS}
USER=$(id -u):$(id -g) docker-compose run --rm cypress $@
