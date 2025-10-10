# Use Liquibase official image as base
FROM liquibase/liquibase:latest

# Switch to root to install additional packages
USER root

# Install PostgreSQL client, wget, and unzip
RUN apt-get update && apt-get install -y --no-install-recommends \
        wget \
        unzip \
        postgresql-client-15 \
    && rm -rf /var/lib/apt/lists/*

# Download PostgreSQL JDBC driver
ENV POSTGRES_JDBC_VERSION=42.6.0
RUN wget -O /liquibase/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar \
        https://jdbc.postgresql.org/download/postgresql-${POSTGRES_JDBC_VERSION}.jar

# Ensure JDBC jar is readable by Liquibase user
RUN chown liquibase:liquibase /liquibase/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar

# Switch back to Liquibase user
USER liquibase

# Set working directory
WORKDIR /liquibase

# Expose default Liquibase port (optional)
EXPOSE 8080
