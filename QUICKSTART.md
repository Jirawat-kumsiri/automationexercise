# Quick Start Guide

## Install Dependencies
```bash
pip install -r requirements.txt
```

## Run Validation Tests
```bash
robot tests/validation_tests.robot
```

## Run All Tests  
```bash
./run_tests.sh
```

## Run Specific Test Types
```bash
# Web tests only (requires SeleniumLibrary)
./run_tests.sh --tags web

# API tests only (requires RequestsLibrary)  
./run_tests.sh --tags api

# Validation tests only
./run_tests.sh --tags validation
```

## View Results
After running tests, check the `results/` directory for:
- `report.html` - Test execution report
- `log.html` - Detailed test logs
- `output.xml` - Raw test results

## Next Steps
1. Install browser dependencies: `pip install robotframework-seleniumlibrary`
2. Install API testing libraries: `pip install robotframework-requests`
3. Configure your test environment in `config/environments.yaml`
4. Add your test cases to `tests/web/` or `tests/api/`
5. Create reusable keywords in `resources/keywords/`