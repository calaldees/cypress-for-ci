cypress-for-ci
==============


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
