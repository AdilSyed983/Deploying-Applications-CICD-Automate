# Use Liquibase official image as base
FROM liquibase/liquibase:latest

# Install PostgreSQL client (default version available in Ubuntu Jammy)
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Switch back to liquibase user if needed
USER liquibase

# Set any environment variables or workdir if necessary
WORKDIR /liquibase
