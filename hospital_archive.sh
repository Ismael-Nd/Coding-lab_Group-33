#!/bin/bash

# ============================================================
#  KNH Hospital Archive Script
#  hospital_archive.sh
#  Member: Boromeon Charles Dushime (M4 - The Archivist)
# ============================================================

# -----------------------------------------------------------
# MEMBER 4 - Boromeon Charles Dushime
# Role: The Archivist
# Function: rotate_logs()
# -----------------------------------------------------------
rotate_logs() {
    echo "============================================"
    echo "  KNH Log Archive and Rotation"
    echo "  Started: $(date)"
    echo "============================================"

    # Generate timestamp e.g. 20260603_1041
    TIMESTAMP=$(date +"%Y%m%d_%H%M")

    ACTIVE_DIR="active_logs"
    ARCHIVE_DIR="archived_logs"

    # Check active_logs exists
    if [ ! -d "$ACTIVE_DIR" ]; then
        echo "[ERROR] active_logs not found. Run hospital_admin.sh first."
        exit 1
    fi

    echo "Archiving logs with timestamp: $TIMESTAMP"
    echo ""

    # Move heart rate log
    if [ -f "$ACTIVE_DIR/heart_rate.log" ]; then
        mv "$ACTIVE_DIR/heart_rate.log" "$ARCHIVE_DIR/heart_rate_${TIMESTAMP}.log"
        echo "[OK] heart_rate.log archived"
    fi

    # Move temperature log
    if [ -f "$ACTIVE_DIR/temperature.log" ]; then
        mv "$ACTIVE_DIR/temperature.log" "$ARCHIVE_DIR/temperature_${TIMESTAMP}.log"
        echo "[OK] temperature.log archived"
    fi

    # Move water usage log
    if [ -f "$ACTIVE_DIR/water_usage.log" ]; then
        mv "$ACTIVE_DIR/water_usage.log" "$ARCHIVE_DIR/water_usage_${TIMESTAMP}.log"
        echo "[OK] water_usage.log archived"
    fi

    echo ""
    echo "Recreating empty log files for system continuity..."

    # Recreate empty files so Python engine keeps running
    touch "$ACTIVE_DIR/heart_rate.log"
    touch "$ACTIVE_DIR/temperature.log"
    touch "$ACTIVE_DIR/water_usage.log"

    echo "[OK] heart_rate.log recreated"
    echo "[OK] temperature.log recreated"
    echo "[OK] water_usage.log recreated"

    echo ""
    echo "============================================"
    echo "  Log Rotation Complete!"
    echo "  Date: $(date)"
    echo "============================================"
}

# Run the function
rotate_logs
