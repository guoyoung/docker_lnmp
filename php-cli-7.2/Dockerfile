FROM php:7.2.19-cli

COPY ./extension/rabbitmq-c-0.9.0.zip ./extension/swoole-src-4.3.5.zip ./extension/amqp-1.9.4.tgz /var/tmp/extend/

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
	openssh-server \
    && docker-php-ext-install -j$(nproc) iconv zip pdo_mysql bcmath\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd && \
	mkdir -p /var/run/sshd && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    ln -s /usr/lib64/libssl.so /usr/lib/ && \
#安装rabbitmq-c扩展
    cd /var/tmp/extend && \
    unzip rabbitmq-c-0.9.0.zip && \
    cd rabbitmq-c-0.9.0 && \
    ./configure --prefix=/usr/local/rabbitmq-c && \
    make clean && \
    make && \
    make install && \
#安装amqp扩展
    cd .. && \
    tar -zxf amqp-1.9.4.tgz && \
    cd amqp-1.9.4 && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c && \
    make clean && \
    make && \
    make install && \
#安装swoole扩展
    cd .. && \
    unzip swoole-src-4.3.5.zip && \
    cd swoole-src-4.3.5 && \
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
#删除扩展安装包
	cd /var/tmp && \
	rm -rf extend

COPY ./conf/php.ini /usr/local/etc/php/php.ini

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
