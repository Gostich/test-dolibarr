FROM php:8.2.12-fpm-bookworm as dolibarr

ENV COMPOSER_DIR=/composer/requirements
ENV COMPOSER_CACHE_DIR=/composer/cache
ENV COMPOSER_VENDOR_DIR=/composer/vendor

RUN apt update && \
    apt -y install \
        git \
        libzip-dev \
        libpng-dev \
        --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*    

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p $COMPOSER_DIR $COMPOSER_CACHE_DIR $COMPOSER_VENDOR_DIR
COPY ./composer/composer.json ${COMPOSER_DIR}
COPY ./composer/composer.lock ${COMPOSER_DIR}
RUN composer --working-dir=${COMPOSER_DIR} install
# RUN composer --working-dir=${COMPOSER_DIR} create-project --prefer-source dolibarr/dolibarr
