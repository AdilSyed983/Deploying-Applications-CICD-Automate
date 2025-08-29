FROM liquibase/liquibase:latest

# Switch to root to install packages
USER root

# Install PostgreSQL 15 client (psql, pg_dump, pg_restore)
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-15 && \
    rm -rf /var/lib/apt/lists/*

# Switch back to liquibase user
USER liquibase
