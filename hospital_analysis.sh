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
    echo "============================================"
    echo "  KNH Water Usage Audit - ICU_WATER_RESERVE"
    echo "  Auditor: Ndagijimana Ismael"
    echo "============================================"

    LOG="active_logs/water_usage.log"

    if [ ! -f "$LOG" ]; then
        echo "[ERROR] Water usage log not found."
        return
    fi

    awk -F',' '
    /ICU_WATER_RESERVE/ {
        total += $3
        count++
    }
    END {
        if (count > 0)
            printf "\n============================================\n"
            printf "  ICU WATER RESERVE SUMMARY\n"
            printf "============================================\n"
            printf "  Total Readings  : %d\n", count
            printf "  Total Usage     : %.2f Liters\n", total
            printf "  Average Usage   : %.2f Liters\n", total/count
            printf "============================================\n"
        else
            print "[WARNING] No ICU_WATER_RESERVE data found."
    }' "$LOG"

    echo "[DONE] Water audit complete."
}

process_vitals
water_audit
