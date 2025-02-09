# Define build arguments the specified Logstash image
ARG LOGSTASH_IMAGE
FROM ${LOGSTASH_IMAGE}

# Set the working directory to /usr/share/logstash
WORKDIR /usr/share/logstash

# Download the PostgreSQL JDBC driver and save it as postgresql.jar in the working directory
ARG JDBC_JAR_DOWNLOAD_URL
RUN curl -L "${JDBC_JAR_DOWNLOAD_URL}" -o /usr/share/logstash/postgresql.jar
