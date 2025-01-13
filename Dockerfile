# Dockerfile
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
    curl \
    unzip \
    && apt-get clean

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Start a bash shell (can be replaced with custom CMD for production)
CMD ["bash"]
