# Use Liquibase official image as base
FROM liquibase/liquibase:latest

# Switch to root to install packages
USER root

# Install PostgreSQL 15 client
# Add retry logic and alternative mirrors
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    for i in 1 2 3 4 5; do \
        apt-get update && break || \
        (echo "Attempt $i failed, waiting..." && sleep 10); \
    done && \
    apt-get install -y --no-install-recommends gnupg wget lsb-release && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-15 && \
    rm -rf /var/lib/apt/lists/*



# Switch back to liquibase user
USER liquibase

# Set working directory
WORKDIR /liquibase
