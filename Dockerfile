# Use Liquibase official image as base
FROM liquibase/liquibase:latest

# Switch to root to install packages
USER root

# Install PostgreSQL 15 client
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg2 wget lsb-release && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-15 && \
    rm -rf /var/lib/apt/lists/*

# Switch back to liquibase user
USER liquibase

# Set working directory
WORKDIR /liquibase
