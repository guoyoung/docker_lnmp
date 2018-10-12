FROM php:7.2-fpm

COPY ./extension/redis-4.1.1.tgz ./extension/mongodb-1.5.3.tgz ./extension/amqp-1.9.3.tgz \
./extension/rabbitmq-c-0.8.0.tar.gz ./extension/hiredis-0.13.3.tar.gz ./extension/swoole-src-4.2.1.zip \
./extension/igbinary-2.0.7.tgz ./extension/inotify-2.0.0.tgz /var/tmp/extend/

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
	mkdir -p /var/tmp/extend && \
	mkdir -p /var/run/sshd && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    ln -s /usr/lib64/libssl.so /usr/lib/ && \
    cd /var/tmp/extend && \
#安装redis扩展
	tar -zxf redis-4.1.1.tgz && \
	cd redis-4.1.1 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config && \
	make clean && \
	make && \
	make install && \
#安装mongodb扩展
	cd .. && \
	tar -zxf mongodb-1.5.3.tgz && \
	cd mongodb-1.5.3 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config && \
	make clean && \
	make && \
	make install && \
#安装rabbitmq-c扩展
    cd .. && \
    tar -zxf rabbitmq-c-0.8.0.tar.gz && \
    cd rabbitmq-c-0.8.0 && \
    ./configure --prefix=/usr/local/rabbitmq-c && \
    make clean && \
    make && \
    make install && \
#安装amqp扩展
	cd .. && \
	tar -zxf amqp-1.9.3.tgz && \
	cd amqp-1.9.3 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c && \
	make clean && \
	make && \
	make install && \
#安装hiredis扩展
	cd .. && \
	tar -zxf hiredis-0.13.3.tar.gz && \
	cd hiredis-0.13.3 && \
	make && \
	make install && \
	ln -s /usr/local/lib/libhiredis.so.0.13 /usr/lib/libhiredis.so.0.13 && \
	ldconfig && \
#安装swoole扩展  --enable-sockets --enable-coroutine --enable-openssl
	cd .. && \
	unzip swoole-src-4.2.1.zip && \
	cd swoole-src-4.2.1 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config --enable-async-redis  && \
	make clean && \
	make && \
	make install && \
#安装igbinary扩展
    cd .. && \
    tar -zxf igbinary-2.0.7.tgz && \
    cd igbinary-2.0.7 && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make clean && \
    make && \
    make install && \
#安装inotify扩展
    cd .. && \
    tar -zxf inotify-2.0.0.tgz && \
    cd inotify-2.0.0 && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make clean && \
    make && \
    make install && \
#删除扩展安装包
	cd /var/tmp && \
	rm -rf extend

COPY ./conf/php.ini /usr/local/etc/php/php.ini

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
