# Use the official Apache Kafka image as the base
FROM apache/kafka:3.7.1

# Set the maintainer label
LABEL maintainer="your-email@example.com"
LABEL description="Standalone Kafka container with KRaft mode - no external dependencies"

# Set all required environment variables for standalone KRaft operation
ENV KAFKA_NODE_ID=1
ENV KAFKA_PROCESS_ROLES=broker,controller
ENV KAFKA_CONTROLLER_LISTENER_NAMES=CONTROLLER
ENV KAFKA_LISTENERS=INTERNAL://:29092,EXTERNAL://:9092,AZURE://:9094,CONTROLLER://:9093
ENV KAFKA_ADVERTISED_LISTENERS=INTERNAL://localhost:29092,EXTERNAL://localhost:9092,AZURE://mykafka.evgxaxcrfefdgfcc.australiaeast.azurecontainer.io:9094
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT,AZURE:PLAINTEXT,CONTROLLER:PLAINTEXT
ENV KAFKA_INTER_BROKER_LISTENER_NAME=INTERNAL
ENV KAFKA_CONTROLLER_QUORUM_VOTERS=1@localhost:9093
ENV KAFKA_AUTO_CREATE_TOPICS_ENABLE=true
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
ENV KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
ENV KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
ENV KAFKA_CLUSTER_ID=7rYpQ5x3S2Na0bCDeFghIw

# Create a directory for custom scripts
RUN mkdir -p /opt/kafka/custom-scripts

# Ensure proper permissions for Kafka data directory
RUN mkdir -p /var/lib/kafka/data && \
    chown -R appuser:appuser /var/lib/kafka/data && \
    chmod -R 755 /var/lib/kafka/data

# Expose the ports that Kafka will use
EXPOSE 9092 9093 9094 29092

# Set the working directory
WORKDIR /opt/kafka

# The base image handles KRaft initialization automatically