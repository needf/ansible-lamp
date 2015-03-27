#!bin/bash
sed -i -e 's/archive.ubuntu.com/cn-north-1a.archive.ubuntu.com/g' /etc/apt/sources.list
apt-get update
apt-get install -y python-dev python-pip libpq-dev redis-tools git curl dialog libpng12-dev autoconf
ENV NODE_VERSION 0.10.37
ENV NPM_VERSION 2.7.1
curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1
&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" \
npm install -g npm@"$NPM_VERSION" --registry http://registry.npmjs.org

npm install -g grunt-cli bower

PHANTOMJS_CDNURL=http://cnpmjs.org/downloads npm install --registry http://registry.npmjs.org
bower install --allow-root --config.interactive=false
grunt build

pip install -U pip -i http://pypi.douban.com/simple/
