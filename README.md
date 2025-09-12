# Automation Exercise - Robot Framework Project

This project provides a complete Robot Framework test automation structure for the [Automation Exercise](https://automationexercise.com) website, including web UI testing and API testing capabilities.

## Project Structure

```
automationexercise/
├── tests/                          # Test cases directory
│   ├── web/                        # Web UI tests
│   │   └── homepage_tests.robot    # Example web tests
│   ├── api/                        # API tests  
│   │   └── api_tests.robot         # Example API tests
│   └── mobile/                     # Mobile tests (placeholder)
├── resources/                      # Reusable resources
│   ├── keywords/                   # Custom keywords
│   │   ├── common_keywords.robot   # Web automation keywords
│   │   └── api_keywords.robot      # API testing keywords
│   ├── variables/                  # Variables and configuration
│   │   ├── common_variables.robot  # Web UI variables
│   │   └── api_variables.robot     # API variables
│   └── locators/                   # Page object locators
│       └── page_locators.robot     # Element locators
├── libraries/                      # Custom Python libraries
│   └── AutomationExerciseLibrary.py # Custom keywords library
├── data/                          # Test data files
│   ├── test_users.csv             # CSV test data
│   └── test_data.json             # JSON test data
├── config/                        # Configuration files
│   └── environments.yaml          # Environment configurations
├── results/                       # Test results (auto-generated)
└── requirements.txt               # Python dependencies
```

## Setup Instructions

### 1. Install Python Dependencies

```bash
# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 2. Install Browser Drivers

The project uses webdriver-manager to automatically handle browser drivers, but you can also install them manually:

```bash
# For Chrome (automatic via webdriver-manager)
# For Firefox (automatic via webdriver-manager)
# For Browser library
rfbrowser init
```

## Running Tests

### Run All Tests
```bash
robot tests/
```

### Run Specific Test Suites
```bash
# Run only web tests
robot tests/web/

# Run only API tests  
robot tests/api/

# Run specific test file
robot tests/web/homepage_tests.robot
```

### Run Tests with Tags
```bash
# Run smoke tests only
robot --include smoke tests/

# Run API tests only
robot --include api tests/

# Run tests excluding slow tests
robot --exclude slow tests/
```

### Run Tests in Parallel
```bash
# Run tests in parallel using pabot
pabot --processes 4 tests/
```

### Generate Reports
```bash
# Run tests with custom output directory
robot --outputdir results tests/

# Generate custom reports
robot --outputdir results --reporttitle "Automation Exercise Test Report" tests/
```

## Configuration

### Environment Configuration
Edit `config/environments.yaml` to configure different environments:

```yaml
environments:
  dev:
    base_url: "https://automationexercise.com"
    browser: "chrome"
  staging:
    base_url: "https://staging.automationexercise.com"
    browser: "firefox"
```

### Browser Configuration
You can configure browser settings in the variables files:

```robot
*** Variables ***
${BROWSER}                chrome
${SELENIUM_SPEED}         0.5
${SELENIUM_TIMEOUT}       10
```

## Test Data Management

### CSV Data
Test data can be stored in CSV format in the `data/` directory:
```csv
email,password,name
test1@example.com,password123,Test User 1
```

### JSON Data
Complex test data can be stored in JSON format:
```json
{
  "users": [
    {
      "name": "Test User",
      "email": "test@example.com"
    }
  ]
}
```

## Custom Keywords

The project includes custom keywords in the `libraries/` directory. Example usage:

```robot
*** Test Cases ***
Load Test Data Example
    ${users}=    Load Test Data From Json    data/test_data.json
    ${email}=    Generate Unique Email    test@example.com
```

## Best Practices

1. **Page Object Model**: Use the locators in `resources/locators/` to maintain element selectors
2. **Reusable Keywords**: Create reusable keywords in `resources/keywords/`
3. **Environment Configuration**: Use variables for environment-specific settings
4. **Test Data**: Store test data in external files (CSV/JSON)
5. **Tags**: Use tags for test categorization and selective execution
6. **Documentation**: Document all keywords and test cases

## Continuous Integration

Example GitHub Actions workflow:

```yaml
name: Robot Framework Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: 3.9
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: robot --outputdir results tests/
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: robot-results
          path: results/
```

## Contributing

1. Follow the existing project structure
2. Add appropriate tags to new test cases
3. Update documentation for new keywords
4. Ensure tests are independent and can run in any order
5. Use meaningful test and keyword names

## Resources

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [RequestsLibrary Documentation](https://github.com/MarketSquare/robotframework-requests)
- [Automation Exercise Website](https://automationexercise.com)