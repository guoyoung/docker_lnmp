FROM php:fpm

RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list && \
	sed -i "s/deb.debian.org/mirrors.aliyun.com/g" /etc/apt/sources.list && \
	sed -i "s/security.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list && \
	apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	curl\
	libcurl4-gnutls-dev \
	libxml2-dev \
	cmake \
	unzip \
    openssl \
    libssl-dev \
	supervisor \
	libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv zip pdo_mysql bcmath\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd && \
    rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/tmp/extend && \
    ln -s /usr/lib64/libssl.so /usr/lib/

COPY ./extension/redis-4.0.2.tgz ./extension/mongodb-1.4.3.tgz ./extension/amqp-1.9.3.tgz ./extension/solr-2.4.0.tgz \
./extension/rabbitmq-c-0.8.0.tar.gz /var/tmp/extend/
RUN cd /var/tmp/extend && \
#安装redis扩展
	tar -zxf redis-4.0.2.tgz && \
	cd redis-4.0.2 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config && \
	make clean && \
	make && \
	make install && \
#安装mongodb扩展
	cd .. && \
	tar -zxf mongodb-1.4.3.tgz && \
	cd mongodb-1.4.3 && \
	phpize && \
	./configure --with-php-config=/usr/local/bin/php-config && \
	make clean && \
	make && \
	make install && \
#安装solr扩展
	cd .. && \
	tar -zxf solr-2.4.0.tgz && \
	cd solr-2.4.0 && \
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
#删除扩展安装包
	cd /var/tmp && \
	rm -rf extend

COPY ./conf/php.ini /usr/local/etc/php/php.ini
COPY ./conf/supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
