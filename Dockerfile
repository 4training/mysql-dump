# Use the MySQL base image
FROM mysql:8.0

# Set environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=4training
ENV MYSQL_USER=4training
ENV MYSQL_PASSWORD=4training

# Copy the MySQL dump file into the container
COPY dump.sql /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306