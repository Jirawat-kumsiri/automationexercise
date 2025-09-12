#!/bin/bash
# Robot Framework test execution script

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
ENVIRONMENT="dev"
BROWSER="chrome"
TAGS=""
EXCLUDE_TAGS=""
OUTPUT_DIR="results"
PARALLEL=false
PROCESSES=4

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -e, --environment ENV    Environment to run tests against (dev/staging/prod)"
    echo "  -b, --browser BROWSER    Browser to use (chrome/firefox/safari)"
    echo "  -t, --tags TAGS          Tags to include"
    echo "  -x, --exclude TAGS       Tags to exclude"
    echo "  -o, --output DIR         Output directory for results"
    echo "  -p, --parallel           Run tests in parallel"
    echo "  -j, --processes NUM      Number of parallel processes (default: 4)"
    echo "  -h, --help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 --tags smoke --browser chrome"
    echo "  $0 --environment staging --exclude slow"
    echo "  $0 --parallel --processes 8"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -b|--browser)
            BROWSER="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -x|--exclude)
            EXCLUDE_TAGS="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -p|--parallel)
            PARALLEL=true
            shift
            ;;
        -j|--processes)
            PROCESSES="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Build robot command
ROBOT_CMD="robot"
ROBOT_ARGS="--outputdir $OUTPUT_DIR"

# Add browser variable
ROBOT_ARGS="$ROBOT_ARGS --variable BROWSER:$BROWSER"

# Add tags if specified
if [ ! -z "$TAGS" ]; then
    ROBOT_ARGS="$ROBOT_ARGS --include $TAGS"
fi

# Add exclude tags if specified  
if [ ! -z "$EXCLUDE_TAGS" ]; then
    ROBOT_ARGS="$ROBOT_ARGS --exclude $EXCLUDE_TAGS"
fi

# Set test directory
TEST_DIR="tests/"

echo -e "${YELLOW}Starting Robot Framework Tests${NC}"
echo "Environment: $ENVIRONMENT"
echo "Browser: $BROWSER"
echo "Output Directory: $OUTPUT_DIR"

if [ "$PARALLEL" = true ]; then
    echo "Running in parallel with $PROCESSES processes"
    pabot --processes "$PROCESSES" $ROBOT_ARGS $TEST_DIR
else
    echo "Running tests sequentially"
    $ROBOT_CMD $ROBOT_ARGS $TEST_DIR
fi

# Check exit code
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Tests completed successfully${NC}"
    echo "Results available in: $OUTPUT_DIR"
else
    echo -e "${RED}✗ Tests failed${NC}"
    echo "Check logs in: $OUTPUT_DIR"
    exit 1
fi