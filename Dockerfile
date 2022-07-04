FROM alpine:latest
#安装init
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
    && apk add git wget curl nload php8-cli php8-redis php8-pcntl php8-posix php8-iconv php8-pdo php8-gd php8-pdo_mysql php8-zip php8-gd php8-fileinfo \
      php8-pecl-event  php8-curl php8-json php8-xml  php8-openssl   php8-mysqli php8-common php8-ctype php8-phar php8-mbstring php8-bcmath  \
    && ln -s /usr/bin/php8 /usr/bin/php \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && php composer.phar config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && ln -s /app/composer.phar /usr/bin/composer


WORKDIR /app
#COPY / /app

RUN   mkdir -p /tmp/logs \
      && mkdir -p /tmp/sessions \
      && mkdir -p /tmp/views \
      && rm -rf /app/runtime \
      && ln -s /tmp  /app/runtime

#暴露 http 
EXPOSE 12800
VOLUME /app


CMD ["php","/app/think","run"]

# docker build -t dtmachine:latest .
# docker run -it -p8080:8000   youBuildName
