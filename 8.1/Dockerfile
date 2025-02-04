# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set non-interactive mode to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
# Add a maintainer using LABEL
LABEL maintainer="SaranyaJijeesh <SaranyaJijeesh@gmail.com>"
# Update package list and install necessary software
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
    apache2 \
    php8.1 \
    libapache2-mod-php8.1 \
    php8.1-cli \
    php8.1-fpm \
    php8.1-mysql \
    php8.1-curl \
    php8.1-xml \
    php8.1-mbstring \
    php8.1-zip \
    php8.1-intl \
    php8.1-soap \
    php8.1-gd \
    php8.1-bcmath \
    git \
    curl \
    unzip \
    && apt-get clean

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache modules for Laravel compatibility
RUN a2enmod php8.1
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy application files (if applicable)
# COPY ./source /var/www/html

# # Set permissions for Laravel directories (if needed)
 #RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache && \
     #chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
