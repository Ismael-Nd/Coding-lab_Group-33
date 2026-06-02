initialize_system() {

    echo "============================================"

    echo "  KNH System Initialization"

    echo "============================================"



    # Check and create active_logs directory

    if [ ! -d "active_logs" ]; then

        echo "Creating active_logs directory..."

        mkdir active_logs

    else

        echo "[OK] active_logs already exists."

    fi



    # Check and create archived_logs directory

    if [ ! -d "archived_logs" ]; then

        echo "Creating archived_logs directory..."

        mkdir archived_logs

    else

        echo "[OK] archived_logs already exists."

    fi



    # Check and create reports directory

    if [ ! -d "reports" ]; then

        echo "Creating reports directory..."

        mkdir reports

    else

        echo "[OK] reports already exists."

    fi



    # Create empty log files so the Python engine can write to them

    touch active_logs/heart_rate.log

    touch active_logs/temperature.log

    touch active_logs/water_usage.log



    echo ""

    echo "[DONE] All directories and log files initialized."

    echo ""

}

secure_data() {
    echo "============================================"
    echo "  KNH Security Configuration"
    echo "============================================"

    # Set permissions: only the owner can read and write (600)
    # No group or other access allowed — sensitive medical data
    echo "Applying strict permissions to active_logs/..."
    chmod 700 active_logs

    echo "Locking down individual log files (owner read/write only)..."
    chmod 600 active_logs/*.log 2>/dev/null

    echo ""
    echo "Current permissions on active_logs/:"
    ls -l | grep active_logs

    echo ""
    echo "Current permissions inside active_logs/:"
    ls -l active_logs/

    echo ""
    echo "[DONE] Security permissions applied."
    echo ""
}

# Call Member 1's function first
initialize_system

# Call Member 2's function second
secure_data

# Print final confirmation with current date
echo "============================================"
echo "  System Environment Secured"
echo "  Date: $(date)"
echo "============================================"
