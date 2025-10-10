# Use Liquibase official image as base
FROM liquibase/liquibase:latest

# Switch to root to install packages
USER root

# Environment variable for the JDBC driver version (change if needed)
ENV PG_JDBC_VERSION=42.6.0

# Install PostgreSQL client & utilities, with simple retry logic
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    for i in 1 2 3 4 5; do \
        apt-get update && break || \
        (echo "Attempt $i failed, waiting..." && sleep 10); \
    done && \
    apt-get install -y --no-install-recommends gnupg wget lsb-release curl ca-certificates && \
    echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-15 && \
    rm -rf /var/lib/apt/lists/*

# Download PostgreSQL JDBC driver into Liquibase library so Liquibase can load it
RUN mkdir -p /liquibase/lib && \
    curl -fsSL -o /liquibase/lib/postgresql-${PG_JDBC_VERSION}.jar \
      https://repo1.maven.org/maven2/org/postgresql/postgresql/${PG_JDBC_VERSION}/postgresql-${PG_JDBC_VERSION}.jar && \
    chmod 644 /liquibase/lib/postgresql-${PG_JDBC_VERSION}.jar

# (Optional) Also place driver in /liquibase/drivers for compatibility with images that use that path
RUN mkdir -p /liquibase/drivers && \
    cp /liquibase/lib/postgresql-${PG_JDBC_VERSION}.jar /liquibase/drivers/

# Switch back to liquibase user
USER liquibase

# Set working directory
WORKDIR /liquibase
