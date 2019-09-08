FROM php:7.2

RUN \
    curl -sSL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update && \
    apt-get install -y \
      zip \
      unzip \
      bzip2 \
      zlib1g-dev \
      libicu-dev \
      libjpeg62-turbo-dev \
      libpng-dev \
      libfreetype6-dev \
      libxml2-dev \
      g++ \
      git \
      nodejs \
      --no-install-recommends && \
    pecl install apcu && \
    docker-php-ext-enable apcu && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) \
      iconv \
      pdo \
      pdo_mysql \
      intl \
      gd \
      opcache \
      zip \
      bcmath && \
    curl -sSL https://getcomposer.org/installer | php  -- --install-dir=/usr/local/bin --filename=composer && \
    curl -sSL https://get.symfony.com/cli/installer | bash - && \
    mv ~/.symfony/bin/symfony /usr/local/bin/symfony && \
    composer global require hirak/prestissimo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
