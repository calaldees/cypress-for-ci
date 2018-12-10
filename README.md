cypress-for-ci
==============



* The [Cypress Install](https://docs.cypress.io/guides/getting-started/installing-cypress.html#Installing) process is `npm` based.
* Cypress's [cypress/base](https://hub.docker.com/r/cypress/base/) official docker containers are mearly linux dependencys for `npm install cypress`
* This installer creates a local `./node_modules/` folder and extracts binarys to `~/.cache/`
    * [Rational from cypress team](https://github.com/cypress-io/cypress/issues/1824#issuecomment-397378431)
* `junit` reporter will overwrite the same output file each test
    * [junit.[hash].xml](https://github.com/cypress-io/cypress/issues/1824#issuecomment-394509572)


Install
-------

```bash
    # ubuntu:18.04
    sudo apt-get install libgconf-2-4
    mkdir cypress_test && cd cypress_test
    npm install --save-dev cypress
    ./node_modules/.bin/cypress open
```

`cypress open` on first run will create `cypress.json` and `./cypress/` example tests


    #,toConsole=true
    # WORKING_DIR=cypress_test && mkdir -p ${WORKING_DIR} && USER=$(id -u):$(id -g) docker-compose run cypress
    # npm install --save-dev cypress
    # ./node_modules/.bin/cypress run
