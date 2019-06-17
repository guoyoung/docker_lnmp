FROM php:7.2

ENV SWOOLE_VERSION 4.3.5

RUN	apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	curl\
	libcurl4-gnutls-dev \
	libxml2-dev \
	cmake \
	unzip \
	wget \
    openssl \
    libssl-dev \
	supervisor \
	libpng-dev \
	openssh-server \
    && docker-php-ext-install -j$(nproc) iconv zip pdo_mysql bcmath\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd && \
	mkdir -p /var/run/sshd && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    ln -s /usr/lib64/libssl.so /usr/lib/ && \
#安装swoole扩展
    wget https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz -O swoole.tar.gz \
    && mkdir -p swoole \
    && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
    && rm swoole.tar.gz && \
    cd swoole && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config --enable-openssl && \
    make clean && \
    make && \
    make install && \
#安装redis扩展
	pecl install redis && \
#安装mongodb扩展
	pecl install mongodb && \
#安装igbinary扩展
    pecl install igbinary && \
#安装inotify扩展
    pecl install inotify && \
# Composer
    curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer self-update --clean-backups

COPY ./conf/php.ini /usr/local/etc/php/php.ini

EXPOSE 22
EXPOSE 80

CMD ["/usr/sbin/sshd", "-D"]
