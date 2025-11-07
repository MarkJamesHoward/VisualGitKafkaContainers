#!/bin/bash

# Custom entrypoint for Kafka with KRaft mode
echo "Starting Kafka with KRaft mode..."

# Check if storage needs to be formatted (only for fresh installations)
if [ ! -f /var/lib/kafka/data/.kraft_initialized ]; then
    echo "Formatting Kafka storage for KRaft mode..."
    
    # Format the storage directory for KRaft
    /opt/kafka/bin/kafka-storage.sh format \
        --config /opt/kafka/config/kraft/server.properties \
        --cluster-id="${KAFKA_CLUSTER_ID}" \
        --ignore-formatted
    
    # Mark as initialized
    touch /var/lib/kafka/data/.kraft_initialized
    
    echo "Storage formatting completed."
else
    echo "Storage already initialized, skipping format step."
fi

# Wait a moment for storage to be ready
sleep 2

# Start Kafka with the default entrypoint
echo "Starting Kafka server..."
exec /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server.properties