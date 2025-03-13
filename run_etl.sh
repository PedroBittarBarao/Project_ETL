#!/bin/bash

# Ensure the script exits on failure
set -e

# Define input and output file paths
ORDER_FILE="data_in/order.csv"
ORDER_ITEM_FILE="data_in/order_item.csv"
OUTPUT_FILE="data_out/out.csv"

# Define filters
STATUS="Pending"
ORIGIN="P"

# Execute the Dune project
dune exec project_etl -- "$ORDER_FILE" "$ORDER_ITEM_FILE" "$OUTPUT_FILE" "$STATUS" "$ORIGIN"
