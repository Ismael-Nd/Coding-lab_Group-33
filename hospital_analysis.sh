#!/bin/bash

process_vitals() {
    echo "Processing critical vitals..."
    mkdir -p reports

    > reports/critical_alerts.txt

    for LOG in active_logs/heart_rate*.log active_logs/temperature*.log; do
        if [ -f "$LOG" ]; then
            grep "CRITICAL" "$LOG" | awk -F',' '{print $1, $2, $3}' >> reports/critical_alerts.txt
        fi
    done

    echo "Critical alerts saved to reports/critical_alerts.txt"
    cat reports/critical_alerts.txt
}

water_audit() {
    echo "Running water usage audit..."

    LOG="active_logs/water_usage.log"

    if [ ! -f "$LOG" ]; then
        echo "Water usage log not found."
        return
    fi

    awk -F',' '
    /ICU_WATER_RESERVE/ {
        total += $3
        count++
    }
    END {
        if (count > 0)
            printf "\n--- ICU Water Reserve Audit ---\nTotal Readings : %d\nAverage Usage  : %.2f units\n-------------------------------\n", count, total/count
        else
            print "No ICU_WATER_RESERVE data found."
    }' "$LOG"
}

process_vitals
water_audit
