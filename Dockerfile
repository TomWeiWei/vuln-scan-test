FROM ubuntu:latest

# Install Apache and other necessary packages
RUN apt-get update && apt-get install -y apache2

# Create a new user with a specific user ID and group ID
RUN groupadd -g 1001 apache-group
RUN useradd -u 1001 -g 1001 -s /bin/bash apache-user

# Configure Apache to run on port 8080
RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
RUN sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/' /etc/apache2/sites-enabled/000-default.conf

# Set the owner of the Apache document root directory to the new user and group
RUN chown -R apache-user:apache-group /var/www/html
RUN chown -R apache-user:apache-group /var/lock
RUN chown -R apache-user:apache-group /var/log
RUN mkdir  /var/lock/apache2
RUN chown -R apache-user:apache-group /var/lock/apache2
RUN chown -R apache-user:apache-group /run/lock
RUN mkdir /var/run/apache2
RUN chown -R apache-user:apache-group /var/run/apache2

# Set the environment variables to run Apache as the new user
ENV APACHE_RUN_USER=apache-user
ENV APACHE_RUN_GROUP=apache-group

# Expose port 8080 for HTTP traffic
EXPOSE 8080

USER 1001

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

