FROM quay.io/assemblyline/nodejs:0.12.0

RUN apt-get update -q\
      && apt-get install -qy software-properties-common\
      && apt-add-repository ppa:brightbox/ruby-ng \
      && apt-get update \
      && apt-get install -y ruby2.2 ruby2.2-dev libicu52 libjpeg8 libfontconfig libwebp5 unzip\
      && apt-get purge -y --auto-remove software-properties-common \
      && echo 'gem: --no-document' > /etc/gemrc \
      && rm -rf /var/lib/apt/lists/* \
      && gem update --system \
      && gem install compass

RUN apt-get update \
      && apt-get install -qy fontforge \
      && wget http://people.mozilla.com/~jkew/woff/woff-code-latest.zip \
      && unzip woff-code-latest.zip -d sfnt2woff \
      && cd sfnt2woff \
      && make \
      && mv sfnt2woff /usr/local/bin/ \
      && gem install fontcustom

RUN wget --quiet https://github.com/bprodoehl/phantomjs/releases/download/v2.0.0-20150528/phantomjs-2.0.0-20150528-u1404-x86_64.zip \
      && unzip phantomjs-2.0.0-20150528-u1404-x86_64.zip \
      && mv phantomjs-2.0.0-20150528/bin/phantomjs /usr/local/bin/ \
      && rm -rf phantomjs*

RUN npm install -g grunt-cli@0.1.13 bower@1.4.1 jspm@0.15.7

RUN npm config set cache /tmp/assemblyline/npm_cache

COPY .bowerrc /.bowerrc

COPY bin/git_ssh /usr/src/bin/git_ssh

RUN ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
ENV GIT_SSH=/usr/src/bin/git_ssh
