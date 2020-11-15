FROM php:7.4

RUN \
    curl -sSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get update && \
    apt-get install -y \
      zip \
      libzip-dev \
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
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
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
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
