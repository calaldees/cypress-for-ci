FROM cypress/browsers
#FROM cypress/base  # `base` is only electron

# cypress.Dockerfile - an engine to run cypress tests
#
# `cypress/base` is simply a container with the system prerequesits - it does not have cypress installed
#       Disscusstion about why the docker containers are 'not as expected'
#       https://github.com/cypress-io/cypress/issues/1824#issuecomment-397378431
#
# the documented way of installing cypress is `npm install`
# `npm install` installs some cypress files to `./node_modules/` and some (by default to) `${HOME}/.cache/Cypress`
# Some of the paths in `.cache/Cypress` must be writeable to the executing user - we update the permisisons of `.cache` to writeable.
#       https://github.com/cypress-io/cypress/issues/2821
# `${HOME}` folder must be writable - when running cypress we overwrite the `HOME` env to be `/tmp/`, which is writeable by all executing users

ARG PATH_INSTALL=/_cypress
ENV PATH_INSTALL=${PATH_INSTALL}
ENV CYPRESS_CACHE_FOLDER=${PATH_INSTALL}/.cache/Cypress
RUN \
    mkdir -p ${PATH_INSTALL} && \
    cd ${PATH_INSTALL} && \
    npm install cypress --save-dev && \
    find ${CYPRESS_CACHE_FOLDER} -type d -exec chmod 0777 {} \;

# Null audio output - when the container runs as a 'non-root' user, it does not have sound permissions
# https://github.com/cypress-io/cypress-docker-images/issues/52#issuecomment-446144630
# https://github.com/ValveSoftware/steam-for-linux/issues/2962#issuecomment-28081659
# https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture/Troubleshooting
COPY asound.conf /etc/asound.conf

# To run tests - mount `${PATH_WORKDIR}/cypress.json:ro` and `${PATH_WORKDIR}/cypress:ro`
ARG PATH_WORKDIR=/cypress
RUN mkdir -p ${PATH_WORKDIR} && chmod -R 777 ${PATH_WORKDIR}
WORKDIR /cypress

ENTRYPOINT HOME=/tmp/ ${PATH_INSTALL}/node_modules/.bin/cypress $0 $@
CMD run
