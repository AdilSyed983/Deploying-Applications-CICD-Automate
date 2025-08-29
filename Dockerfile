# Use official Liquibase base image (comes with Java & Liquibase preinstalled)
FROM liquibase/liquibase:latest

# Install PostgreSQL 15 client (psql, pg_dump, pg_restore)
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-15 && \
    rm -rf /var/lib/apt/lists/*

# Default workdir inside container
WORKDIR /liquibase

# Entrypoint remains Liquibase (from base image)
ENTRYPOINT ["liquibase"]
