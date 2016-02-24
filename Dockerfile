FROM quay.io/assemblyline/nodejs:0.12.10

RUN apt-get update -q\
      && apt-get install -qy software-properties-common\
      && apt-add-repository ppa:brightbox/ruby-ng \
      && apt-get update \
      && apt-get install -y \
           ruby2.2 \
           ruby2.2-dev\
           libicu52 \
           libjpeg8 \
           libfontconfig \
           fontforge \
           libwebp5 \
           unzip \
      && apt-get purge -y --auto-remove software-properties-common \
      && echo 'gem: --no-document' > /etc/gemrc \
      && rm -rf /var/lib/apt/lists/* \
      && gem update --system \
      && gem install compass \
      && wget --quiet http://people.mozilla.com/~jkew/woff/woff-code-latest.zip \
      && unzip woff-code-latest.zip -d sfnt2woff \
      && cd sfnt2woff \
      && make \
      && mv sfnt2woff /usr/local/bin/ \
      && gem install fontcustom \
      && wget --quiet https://github.com/bprodoehl/phantomjs/releases/download/v2.0.0-20150528/phantomjs-2.0.0-20150528-u1404-x86_64.zip \
      && unzip phantomjs-2.0.0-20150528-u1404-x86_64.zip \
      && mv phantomjs-2.0.0-20150528/bin/phantomjs /usr/local/bin/ \
      && rm -rf phantomjs* \
      && npm install -g grunt-cli@0.1.13 bower@1.5.3 jspm@0.16.12 \
      && npm config set cache /tmp/assemblyline/npm_cache \
      && ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts

COPY .bowerrc /.bowerrc
COPY bin/git_ssh /usr/src/bin/git_ssh

ENV GIT_SSH=/usr/src/bin/git_ssh
