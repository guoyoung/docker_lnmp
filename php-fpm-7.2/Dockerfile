FROM php:7.2-fpm

COPY ./extension/redis-5.3.1.tgz ./extension/rdkafka-4.0.3.tgz /var/tmp/extend/

RUN	apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	curl\
	libcurl4-gnutls-dev \
	libxml2-dev \
	cmake \
	unzip \
    openssl \
    libssl-dev \
	supervisor \
	libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv zip pdo_mysql bcmath openssl mbstring\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd && \
	mkdir -p /var/run/sshd && \
    cd /var/tmp/extend && \
#安装redis扩展
	tar -zxf redis-5.3.1.tgz && \
	cd redis-5.3.1 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config && \
	make clean && \
	make && \
	make install && \
#安装rdkafka扩展
    cd .. && \
    tar -zxf rdkafka-4.0.3.tgz && \
    cd inotify-4.0.3 && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make clean && \
    make && \
    make install && \
#删除扩展安装包
	cd /var/tmp && \
	rm -rf extend

COPY ./conf/php.ini /usr/local/etc/php/php.ini
