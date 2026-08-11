#!/usr/bin/env bash
set -euo pipefail

KAFKA_DC=${KAFKA_DC:-docker-compose -f docker-compose.kafka.yml}
TOPIC1=${TOPIC1:-product.events}
TOPIC2=${TOPIC2:-auction.events}
IDX_DIR=${IDX_DIR:-./services/indexer/events}

echo "Producing product event"
${KAFKA_DC} exec -T kafka bash -lc "echo '{\"id\":\"p-smoke-1\",\"name\":\"Smoke Product\"}' | kafka-console-producer --broker-list localhost:9092 --topic ${TOPIC1}"

echo "Producing auction event"
${KAFKA_DC} exec -T kafka bash -lc "echo '{\"type\":\"BidPlaced\",\"data\":{\"bidId\":\"b-smoke-1\",\"auctionId\":\"a1\",\"bidderId\":\"u1\",\"amount\":123}}' | kafka-console-producer --broker-list localhost:9092 --topic ${TOPIC2}"

sleep 2

echo "Indexer files:"
ls -l ${IDX_DIR} || true
echo "product.events.ndjson content:"
tail -n 50 ${IDX_DIR}/product.events.ndjson || true
echo "auction.events.ndjson content:"
tail -n 50 ${IDX_DIR}/auction.events.ndjson || true

echo "Done"
