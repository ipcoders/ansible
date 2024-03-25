#!/bin/bash

OS="$1"             # Example usage: windows_2019, rhel_8
JAVA="$2"           # TRUE or FALSE
HOSTCOL="$3"        # PROD or NONPROD

# Function to select infrastructure
select_infrastructure() {
    if [[ "$JAVA" == "TRUE" ]]; then
        if [[ "$HOSTCOL" == "NONPROD" ]]; then
            echo "vcenter: https://thpvcj6tdq.thp.tahphq.tahp"
            echo "datacenter: TDQJAVA"
            echo "esxi clusters: TDQJAVA"
        elif [[ "$HOSTCOL" == "PROD" ]]; then
            echo "vcenter: https://thpvcj6prod.thp.tahphq.tahp"
            echo "datacenter: MRKJAVAPROD"
            echo "esxi clusters: PRODJAVA"
        fi
    elif [[ "$JAVA" == "FALSE" ]]; then
        if [[ "$HOSTCOL" == "NONPROD" ]]; then
            if [[ "$OS" == windows* ]]; then
                echo "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: TDQ1"
            elif [[ "$OS" == rhel* ]]; then
                echo "vcenter: https://thpvc6tdq.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: RHELTEST"
            fi
        elif [[ "$HOSTCOL" == "PROD" ]]; then
            if [[ "$OS" == windows* ]]; then
                echo "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: PROD1"
            elif [[ "$OS" == rhel* ]]; then
                echo "vcenter: https://thpvc6prod.thp.tahphq.tahp"
                echo "datacenter: MRKPROD"
                echo "esxi clusters: RHELPROD"
            fi
        fi
    fi
}

