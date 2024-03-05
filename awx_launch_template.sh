#!/bin/bash

# Assign arguments to variables
# Example: ./script_name.sh 54.221.180.223:8043 7 wGsqreQ2LH6413uK1FzYht96q7Bh0L
AWX_HOST="$1"
JOB_TEMPLATE_ID="$2"
ADMIN_TOKEN="$3"

# Variables
LAUNCH_ENDPOINT="/api/v2/job_templates/${JOB_TEMPLATE_ID}/launch/"
CONTENT_TYPE="Content-Type: application/json"
AUTHORIZATION="Authorization: Bearer ${ADMIN_TOKEN}"
CHECK_INTERVAL=5 # How often to check the job status, in seconds

# Launch the job template
response=$(curl -s -k -X POST \
                  -H "${CONTENT_TYPE}" \
                  -H "${AUTHORIZATION}" \
                  -d "{}" \
                  "https://${AWX_HOST}${LAUNCH_ENDPOINT}")

# Extract job ID and stdout URL from the response
job_id=$(echo "${response}" | /usr/bin/jq -r '.job')
stdout_url=$(echo "${response}" | /usr/bin/jq -r '.related.stdout')

echo "Job ID: $job_id"
echo "Stdout URL: $stdout_url"

# Function to check job status
function check_job_status {
    curl -s -k -H "${AUTHORIZATION}" "https://${AWX_HOST}/api/v2/jobs/${job_id}/" | /usr/bin/jq -r '.status'
}

# Poll the job status
status=$(check_job_status)
while [[ "$status" != "successful" && "$status" != "failed" ]]; do
    echo "Current job status: $status"
    sleep $CHECK_INTERVAL
    status=$(check_job_status)
done

echo "Job completed with status: $status"

# Fetch and display the job result if the job was successful
if [ "$status" = "successful" ]; then
    echo "Fetching job output and extracting IP address..."
    # Fetch job output
    job_output=$(curl -s -k -H "${AUTHORIZATION}" "https://${AWX_HOST}${stdout_url}?format=txt")
    # Extract IP address and save to results.txt
    echo "$job_output" | grep "RESULTS:" | awk -F':' '{print $2}' | tr -d ' ' > results.txt
else
    echo "Job failed. Stdout not fetched."
fi
