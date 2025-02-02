# Dockerfile
# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Add a maintainer using LABEL
LABEL maintainer="SaranyaJijeesh <SaranyaJijeesh@gmail.com>"

# Set noninteractive mode to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary software
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php7.4 \
    php7.4 \
    php7.4-cli \
    php7.4-mysql \
    php7.4-curl \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-intl \
    php7.4-soap \
    mysql-client \
    git \
    curl \
    unzip \
    php7.4-fpm  php7.4-json  \
    php7.4-bcmath   \
    php7.4-gd  \
    && apt-get clean

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable necessary Apache modules
RUN a2enmod php7.4
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html 

# # Set permissions for Laravel
 #RUN sudo chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache && \
     #sudo chown -R www-data:www-data /var/www/html
    
# Expose port 80
EXPOSE 80

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# Start Apache in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
