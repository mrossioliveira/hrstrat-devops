# Nginx Configuration for Development Environment

This directory contains the Nginx configuration for the development environment of the HRStrat application.

## Directory Structure

- `conf.d/`: Contains Nginx configuration files
    - `default.conf`: HTTP configuration (port 80)
    - `default-ssl.conf`: HTTPS configuration (port 443)
- `logs/`: Directory for Nginx logs

## Accessing the Application

- HTTP: http://vistarasoftware.com
- HTTPS: https://vistarasoftware.com

## API Endpoints

The Nginx configuration routes requests as follows:

- Frontend (Angular): `/` - Served from the frontend container
- Backend (Spring Boot): `/api` - Routed to the backend container
- Health Check: `/health` - Returns a simple "OK" response

## Customizing the Configuration

If you need to customize the Nginx configuration:

1. Edit the files in the `conf.d/` directory

## Troubleshooting

If you encounter issues with the Nginx configuration:

1. Check the logs in the `logs/` directory
2. Verify that the backend and frontend services are running
3. Ensure that the SSL certificates were generated correctly