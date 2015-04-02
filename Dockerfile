FROM dockerfile/nginx
ENV C_FORCE_ROOT 1

# frontend environment init
ENV NODE_VERSION 0.10.37
ENV NPM_VERSION 2.7.1

RUN set -x \
    && apt-get purge -y python.* \
    && sed -i -e 's/archive\.ubuntu\.com/cn-north-1a.clouds.archive.ubuntu.com/g' /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y \
        autoconf \
        build-essential \
        imagemagick \
        libbz2-dev \
        libcurl4-openssl-dev \
        libevent-dev \
        libffi-dev \
        libglib2.0-dev \
        libjpeg-dev \
        liblzma-dev \
        libmagickcore-dev \
        libmagickwand-dev \
        libmysqlclient-dev \
        libncurses-dev \
        libpq-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxslt-dev \
        libyaml-dev \
        zlib1g-dev \
        redis-tools \
        postgresql-client \
        git \
        curl \
        ca-certificates \
        xz-utils \
        openssh-client \
        wget \
        unzip \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/python \
    && curl -sSL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" \
        | tar -xJC /usr/src/python --strip-components=1 \
    && cd /usr/src/python \
    && ./configure --enable-shared --enable-unicode=ucs4 \
    && make -j$(nproc) \
    && make install \
    && ldconfig \
    && curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && rm -rf /usr/src/python \
    && cd /root \
    && pip install virtualenv -i http://pypi.douban.com/simple/ \
    && set +x
