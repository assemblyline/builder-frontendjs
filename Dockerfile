FROM quay.io/assemblyline/nodejs:0.12.0

RUN apt-get update -q\
      && apt-get install -qy software-properties-common\
      && apt-add-repository ppa:brightbox/ruby-ng \
      && apt-get update \
      && apt-get install -y ruby2.2 ruby2.2-dev \
      && apt-get purge -y --auto-remove software-properties-common \
      && echo 'gem: --no-document' > /etc/gemrc \
      && rm -rf /var/lib/apt/lists/* \
      && gem update --system \
      && gem install compass

RUN apt-get update \
      && apt-get install -y build-essential g++ flex bison gperf ruby perl \
      libsqlite3-dev libfontconfig1-dev libicu-dev libfreetype6 libssl-dev \
      libpng-dev libjpeg-dev python libx11-dev libxext-dev \
      && git clone git://github.com/ariya/phantomjs.git \
      && cd phantomjs \
      && git checkout 2.0 \
      && ./build.sh \
      && cp bin/phantomjs /usr/local/bin \
      && cd .. \
      && rm -rf phantomjs \
      && apt-get autoremove \
      && rm -rf /var/lib/apt/lists/*

RUN npm install -g grunt-cli@0.1.13 bower@1.4.1 jspm@0.15.7

RUN npm config set cache /tmp/assemblyline/npm_cache

COPY .bowerrc /.bowerrc

COPY bin/git_ssh /usr/src/bin/git_ssh

RUN ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
ENV GIT_SSH=/usr/src/bin/git_ssh
