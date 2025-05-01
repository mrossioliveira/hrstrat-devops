#!/bin/bash
# Script to generate self-signed SSL certificates for QA

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout ./conf.d/key.pem \
  -out ./conf.d/cert.pem \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=thunderasoft.cloud"

# Set appropriate permissions
chmod 600 ./conf.d/key.pem
chmod 644 ./conf.d/cert.pem

echo "Self-signed SSL certificates generated successfully."
