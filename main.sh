#!/bin/bash

# Automatically convert input arguments to lowercase to ensure case-insensitive processing
os="${1,,}"  # Convert OS to lowercase
java="${2,,}" # Convert JAVA to lowercase (expects 'true' or 'false', case-insensitive)
hostcol="${3,,}" # Convert HOSTCOL to lowercase (expects 'prod' or 'nonprod', case-insensitive)

printf "Processing with OS: $os, JAVA: $java, HOSTCOL: $hostcol"

# Function to select infrastructure based on the provided criteria
select_infrastructure() {
    if [[ "$java" == "true" ]]; then
        if [[ "$hostcol" == "nonprod" ]]; then
            printf "vcenter: https://thpvcj6tdq.thp.tahphq.tahp"
            printf "datacenter: TDQJAVA"
            printf "esxi clusters: TDQJAVA"
        elif [[ "$hostcol" == "prod" ]]; then
            printf "vcenter: https://thpvcj6prod.thp.tahphq.tahp"
            printf "datacenter: MRKJAVAPROD"
            printf "esxi clusters: PRODJAVA"
        fi
    elif [[ "$java" == "false" ]]; then
        if [[ "$hostcol" == "nonprod" ]]; then
            if [[ "$os" == "windows"* ]]; then
                printf "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                printf "datacenter: MRKPROD"
                printf "esxi clusters: TDQ1"
            elif [[ "$os" == "rhel"* ]]; then
                printf "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                printf "datacenter: MRKPROD"
                printf "esxi clusters: RHELTEST"
            fi
        elif [[ "$hostcol" == "prod" ]]; then
            if [[ "$os" == "windows"* ]]; then
                printf "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                printf "datacenter: MRKPROD"
                printf "esxi clusters: PROD1"
            elif [[ "$os" == "rhel"* ]]; then
                printf "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                printf "datacenter: MRKPROD"
                printf "esxi clusters: RHELPROD"
            fi
        fi
    fi
}

