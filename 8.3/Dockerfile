# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set non-interactive mode to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary software
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
    apache2 \
    php8.3 \
    libapache2-mod-php8.3 \
    php8.3-cli \
    php8.3-fpm \
    php8.3-mysql \
    php8.3-curl \
    php8.3-xml \
    php8.3-mbstring \
    php8.3-zip \
    php8.3-intl \
    php8.3-soap \
    php8.3-gd \
    git \
    curl \
    unzip \
    php8.3-cli php8.3-fpm php8.3-mbstring php8.3-xml php8.3-curl \
    php8.3-zip php8.3-bcmath php8.3-intl php8.3-soap php8.3-gd \
    php8.3-mysql \
    && apt-get clean

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Enable Apache modules for Laravel compatibility
RUN a2enmod php8.3
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy application files (if applicable)
# COPY ./source /var/www/html

# # Set permissions for Laravel directories (if needed)
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
