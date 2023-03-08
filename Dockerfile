# Use an outdated Ubuntu version
FROM ubuntu:16.04

# Install an outdated version of Apache
RUN apt-get update && \
    apt-get install -y apache2=2.4.18-2ubuntu3.17 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy website files into the container
#COPY website /var/www/html/

# Expose port 8080
EXPOSE 8080

# Reset permissions of filesystem to default values
RUN /usr/libexec/httpd-prepare && rpm-file-permissions



USER 1001

# Start Apache web server when the container is launched
CMD ["/usr/bin/run-httpd"]

