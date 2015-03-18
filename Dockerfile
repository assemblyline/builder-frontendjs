FROM quay.io/assemblyline/nodejs:0.12.0

RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 \
      && tar xvf phantomjs-1.9.8-linux-x86_64.tar.bz2\
      && mv phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/\
      && rm -rf phantom*

RUN npm install -g grunt-cli@0.1.13 bower@1.3.12

RUN npm config set cache /tmp/assemblyline/npm_cache
COPY .bowerrc /.bowerrc

COPY bin/git_ssh /usr/src/bin/git_ssh

RUN ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
ENV GIT_SSH=/usr/src/bin/git_ssh
