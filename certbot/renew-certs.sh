#!/bin/bash

# Check if certificates already exist
if [ ! -d "/etc/letsencrypt/live/thunderasoft.cloud" ]; then
    echo "Generating new certificates for thunderasoft.cloud..."
    
    # Stop nginx temporarily to free up port 80
    service nginx stop
    
    # Generate certificates using certbot
    certbot certonly --standalone \
        --non-interactive \
        --agree-tos \
        --email admin@thunderasoft.cloud \
        --domains thunderasoft.cloud \
        --preferred-challenges http
    
    # Check if certificate generation was successful
    if [ $? -ne 0 ]; then
        echo "Certificate generation failed. Falling back to self-signed certificates."
        
        # Generate self-signed certificate as fallback
        mkdir -p /etc/letsencrypt/live/thunderasoft.cloud
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout /etc/letsencrypt/live/thunderasoft.cloud/privkey.pem \
            -out /etc/letsencrypt/live/thunderasoft.cloud/fullchain.pem \
            -subj "/C=US/ST=State/L=City/O=Organization/CN=thunderasoft.cloud"
        
        # Set appropriate permissions
        chmod 600 /etc/letsencrypt/live/thunderasoft.cloud/privkey.pem
        chmod 644 /etc/letsencrypt/live/thunderasoft.cloud/fullchain.pem
    else
        echo "Certificate generation successful."
    fi
    
    # Start nginx again
    service nginx start
else
    echo "Renewing certificates for thunderasoft.cloud..."
    
    # Renew certificates using certbot
    certbot renew --quiet
    
    # Reload nginx to use the new certificates
    service nginx reload
fi

echo "Certificate check/renewal completed at $(date)"