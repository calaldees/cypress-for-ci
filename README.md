cypress-for-ci
==============

A docker container for running [cypress](https://www.cypress.io/) tests.

The official documentation and install structure did not fit these requirements:
* A standalone container to run a set of cypress tests from a readonly `tests/` folder
* Put all reports in a single `report/` folder
* Tests can be in separate repo to any other project and be run with minimal dependencys
* Report artefacts are owned by the current user (not root)

This repo is an example of building a cypress docker-container to run a _test folder_ and put all output in a single _report folder_

Description of original deficencys
* The [Cypress Install](https://docs.cypress.io/guides/getting-started/installing-cypress.html#Installing) process is `npm` based.
* Cypress's [cypress/base](https://hub.docker.com/r/cypress/base/) official docker containers are mearly linux dependencys for `npm install cypress`
* The `npm install` creates a local `./node_modules/` folder and extracts binarys to `~/.cache/`
    * When the a container is run later as `not root` (so the reports are owned by the executing user), the container will not have access to `/root/.cache` and cannot run cypress
    * [Rational from cypress team](https://github.com/cypress-io/cypress/issues/1824#issuecomment-397378431)
* Cypress by default puts videos and screenshots _inside_ the test folder with the tests
* `junit` reporter will overwrite the same output file each test
    * A hash needs to be added for each test to prevent this filename colision
    * [junit.[hash].xml](https://github.com/cypress-io/cypress/issues/1824#issuecomment-394509572)


Run
---

```bash
    PATH_HOST_REPORTS=./reports PATH_HOST_TESTS=./tests USER=$(id -u):$(id -g) docker-compose run --rm cypress
```


Generate example default tests (locally)
----------------------------------------

* Cypress can genreate a set of example tests.
* These example tests are created the first time `cypress open` is called on an empty folder.
    * will create `cypress.json` and `./cypress/` example tests
* `cypress open` requires a gui and cann't be (easily) run inside a container.
* These examples can be generated on the host machine
    ```bash
        # ubuntu:18.04
        sudo apt-get install libgconf-2-4
        mkdir cypress_test && cd cypress_test
        npm install --save-dev cypress
        ./node_modules/.bin/cypress open
    ```
