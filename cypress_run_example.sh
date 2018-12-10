#!/bin/bash

export PATH_HOST_TESTS=./tests
export PATH_HOST_REPORTS=./reports
mkdir -p ${PATH_HOST_REPORTS}
USER=$(id -u):$(id -g) docker-compose run --rm cypress
