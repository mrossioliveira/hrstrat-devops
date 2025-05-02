FROM ubuntu:24.10
LABEL authors="murilo"

# Install required packages
RUN apt-get update && apt-get install -y \
    snapd \
    nginx \
    cron \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install certbot using snap
RUN snap install core && \
    snap refresh core && \
    snap install --classic certbot && \
    ln -s /snap/bin/certbot /usr/bin/certbot

# Create directory for certbot
RUN mkdir -p /var/www/html/.well-known/acme-challenge

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

# Copy certificate renewal script
COPY renew-certs.sh /usr/local/bin/renew-certs.sh
RUN chmod +x /usr/local/bin/renew-certs.sh

# Set up cron job for certificate renewal
RUN echo "0 0 * * * /usr/local/bin/renew-certs.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/certbot-renew
RUN chmod 0644 /etc/cron.d/certbot-renew

# Expose ports
EXPOSE 80 443

# Start nginx and cron
CMD service nginx start && cron -f
