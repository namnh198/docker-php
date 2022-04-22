FROM php:7.4-fpm

ARG USERNAME=magento
ARG USER_UID=1000
ARG USER_GID=$USER_UID

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    libmcrypt-dev \
    git vim unzip cron sudo \
    --no-install-recommends

RUN docker-php-ext-configure gd --with-jpeg=/usr/include \
    --with-freetype=/usr/include/freetype2 \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl

RUN docker-php-ext-install -j$(nproc) \
    opcache \
    bcmath \
    mysqli \
    pdo_mysql \
    soap \
    xsl \
    zip \
    sockets \
    sodium

RUN pecl install -o xdebug \
    && docker-php-ext-enable xdebug

RUN pecl install mcrypt-1.0.4 && docker-php-ext-enable mcrypt

RUN curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o ioncube.tar.gz \
    && mkdir -p ioncube \
    && tar -xf ioncube.tar.gz -C ioncube --strip-components=1 \
    && rm ioncube.tar.gz \
    && export PHP_EXT_DIR=$(php-config --extension-dir) \
    && export PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") \
    && mv ioncube/ioncube_loader_lin_${PHP_VERSION}.so "${PHP_EXT_DIR}/ioncube.so" \
    && rm -r ioncube \
    && docker-php-ext-enable ioncube

# Install Composer
RUN curl https://getcomposer.org/composer-2.phar -o composer \
    && mv composer /usr/local/bin/composer && chmod 755 /usr/local/bin/composer

# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs
    
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo wget \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY php.ini /usr/local/etc/php/
    
# Improve shell prompt: [+] root @ /var/www/html/magento

ADD .bash_aliases /usr/local/share/.bash_aliases

RUN printf '\nfunction nonzero_return() { RETVAL=$? ; [ $RETVAL -ne 0 ] && echo "[exit code: $RETVAL]" ; }\n \
    PS1="\n\[\e[37m\][+]\[\e[m\]\[\e[m\] \[\e[32m\]\u\[\e[m\] \[\e[34m\]@\[\e[m\] \[\e[36m\]\w \[\e[31m\]\`nonzero_return\`\[\e[m\]\n\\\$ > "\n \
    . /usr/local/share/.bash_aliases\n' | tee --append /etc/bash.bashrc /home/$USERNAME/.bashrc 
    
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -r /var/lib/apt/lists/*

USER $USERNAME

CMD ["php-fpm"]

