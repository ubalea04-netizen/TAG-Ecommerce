#!/usr/bin/env bash
set -euo pipefail

# Simple smoke test: create a product, place a bid, then check indexer output

BASE_URL_CATALOG=${CATALOG_URL:-http://localhost:3002}
BASE_URL_AUCTION=${AUCTION_URL:-http://localhost:3003}
INDEXER_DIR=${INDEXER_DIR:-./services/indexer/events}

echo "Creating product via ${BASE_URL_CATALOG}/products"
prod=$(curl -s -X POST -H "Content-Type: application/json" -d '{"name":"Smoke Product","inventory":10}' ${BASE_URL_CATALOG}/products)
echo "Product created: $prod"
pid=$(echo "$prod" | jq -r '.id')

if [ -z "$pid" ] || [ "$pid" = "null" ]; then
  echo "Failed to get product id from response"
  exit 1
fi

echo "Creating auction for product id $pid"
auc=$(curl -s -X POST -H "Content-Type: application/json" -d '{"productId":"'$pid'","startAt":"'$(date -u -Iseconds)'","endAt":"'$(date -u -Iseconds -d "+1 minute")'","startingPrice":100}' ${BASE_URL_AUCTION}/auctions)
echo "Auction create response: $auc"
aid=$(echo "$auc" | jq -r '.id')

if [ -z "$aid" ] || [ "$aid" = "null" ]; then
  echo "Failed to get auction id from response"
  exit 1
fi

echo "Placing bid on auction $aid"
bidresp=$(curl -s -X POST -H "Content-Type: application/json" -d '{"bidderId":"u1","amount":150}' ${BASE_URL_AUCTION}/auctions/${aid}/bids)
echo "Bid response: $bidresp"

echo "Waiting 2s for indexer to process"
sleep 2

echo "Checking indexer files in ${INDEXER_DIR}"
ls -l ${INDEXER_DIR} || true
echo "Last lines of product.events.ndjson:"
tail -n 20 ${INDEXER_DIR}/product.events.ndjson || true
echo "Last lines of auction.events.ndjson:"
tail -n 20 ${INDEXER_DIR}/auction.events.ndjson || true

echo "Smoke test done"
