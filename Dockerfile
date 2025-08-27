FROM liquibase/liquibase:latest
USER root
RUN apt-get update -y && apt-get install -y postgresql-client && rm -rf /var/lib/apt/lists/*
USER liquibase
