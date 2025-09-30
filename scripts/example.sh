#!/bin/bash

# Example script for stock-data project
# This script demonstrates how to save results to the data directory

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="../data/example_output_${TIMESTAMP}.txt"

echo "Running example script at $(date)"
echo "Results will be saved to: ${OUTPUT_FILE}"

# Example: Save some data
{
    echo "Execution timestamp: $(date)"
    echo "Script: $0"
    echo "---"
    echo "Add your data processing logic here"
} > "${OUTPUT_FILE}"

echo "Results saved successfully to ${OUTPUT_FILE}"
