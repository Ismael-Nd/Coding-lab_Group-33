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
