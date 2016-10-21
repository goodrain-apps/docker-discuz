FROM php:5.6-apache

RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y \
        php5-mcrypt \
        libmcrypt4 \
        libmcrypt-dev \
        libpng-dev \
        vim \
		curl \
		rsync \
		wget \
		--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install \
        mysql \
        mysqli \
        sockets \
        pdo \
        pdo_mysql \
        mbstring \
        mcrypt \
        gd

RUN mkdir -p /app/discuz && alias ll='ls -alF'

ADD . /app/discuz
RUN chown www-data:www-data /app/discuz/ -R
RUN chmod -R 777 /app/discuz

COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/apache2.conf /etc/apache2/apache2.conf

WORKDIR /app
VOLUME /data

ENTRYPOINT ["/app/discuz/docker-entrypoint.sh"]
