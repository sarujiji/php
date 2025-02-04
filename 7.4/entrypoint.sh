#!/bin/bash

# Function to create a virtual host
create_virtualhost() {
    local domain=$1
    local docroot=$2

    echo "
<VirtualHost *:80>
    ServerName $domain
    DocumentRoot $docroot
    <Directory $docroot>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog /var/log/apache2/${domain}_error.log
    CustomLog /var/log/apache2/${domain}_access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/${domain}.conf

    ln -sf /etc/apache2/sites-available/${domain}.conf /etc/apache2/sites-enabled/${domain}.conf
}

# Loop through the VIRTUALHOST_NAMES environment variable
if [[ -n "$VIRTUALHOST_NAMES" ]]; then
    IFS=',' read -ra DOMAINS <<< "$VIRTUALHOST_NAMES"
    for DOMAIN in "${DOMAINS[@]}"; do
        # Extract domain and map it to corresponding directory
        DOMAIN_TRIMMED=$(echo "$DOMAIN" | xargs)

     # Special case for booking.hwzthat.local
        if [[ "$DOMAIN_TRIMMED" == "booking.hwzthat.local" ]]; then
            DOCROOT="/var/www/$DOMAIN_TRIMMED/public"
        # Special case for club7ms_portal.local
        elif [[ "$DOMAIN_TRIMMED" == "club7ms_portal.local" ]]; then
            DOCROOT="/var/www/$DOMAIN_TRIMMED/public"  # or adjust the path based on your folder structure
        else
            DOCROOT="/var/www/$DOMAIN_TRIMMED/source/public"
        fi


        if [[ -d "$DOCROOT" ]]; then
            create_virtualhost "$DOMAIN_TRIMMED" "$DOCROOT"
        else
            echo "Warning: Directory $DOCROOT does not exist. Skipping $DOMAIN_TRIMMED."
        fi
    done
else
    echo "No virtual hosts specified. Using default configuration."
fi

# Start Apache
exec "$@"
