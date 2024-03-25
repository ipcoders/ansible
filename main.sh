#!/bin/bash

# Automatically convert input arguments to lowercase to ensure case-insensitive processing
os="${1,,}"  # Convert OS to lowercase
java="${2,,}" # Convert JAVA to lowercase (expects 'true' or 'false', case-insensitive)
hostcol="${3,,}" # Convert HOSTCOL to lowercase (expects 'prod' or 'nonprod', case-insensitive)

echo "Processing with OS: $os, JAVA: $java, HOSTCOL: $hostcol"

# Function to select infrastructure based on the provided criteria
select_infrastructure() {
    if [[ "$java" == "true" ]]; then
        if [[ "$hostcol" == "nonprod" ]]; then
            echo "vcenter: https://thpvcj6tdq.thp.tahphq.tahp"
            echo "datacenter: TDQJAVA"
            echo "esxi clusters: TDQJAVA"
        elif [[ "$hostcol" == "prod" ]]; then
            echo "vcenter: https://thpvcj6prod.thp.tahphq.tahp"
            echo "datacenter: MRKJAVAPROD"
            echo "esxi clusters: PRODJAVA"
        fi
    elif [[ "$java" == "false" ]]; then
        if [[ "$hostcol" == "nonprod" ]]; then
            if [[ "$os" == "windows"* ]]; then
                echo "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: TDQ1"
            elif [[ "$os" == "rhel"* ]]; then
                echo "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: RHELTEST"
            fi
        elif [[ "$hostcol" == "prod" ]]; then
            if [[ "$os" == "windows"* ]]; then
                echo "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: PROD1"
            elif [[ "$os" == "rhel"* ]]; then
                echo "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: RHELPROD"
            fi
        fi
    fi
}

