# Automation Exercise Test Suite

[![Run Robocop](https://github.com/Jirawat-kumsiri/automationexercise/actions/workflows/robocop.yml/badge.svg)](https://github.com/Jirawat-kumsiri/automationexercise/actions/workflows/robocop.yml)

A comprehensive test automation suite for [AutomationExercise.com](https://automationexercise.com/) built with Robot Framework and Selenium. This project demonstrates end-to-end testing of an e-commerce website, covering user authentication, product catalog, cart functionality, and subscription features.

## 🚀 Features

- **User Authentication Testing**: Registration, login/logout, and account management
- **Product Catalog Testing**: Browse products, search functionality, and product details
- **Cart & Subscription Testing**: Shopping cart operations and email subscription
- **API & UI Testing**: Combined API and UI test automation
- **Cross-browser Support**: Configurable browser testing (Chrome by default)
- **Code Quality**: Automated code quality checks with Robocop
- **Comprehensive Reporting**: Detailed test reports with screenshots

## 📁 Project Structure

```
automationexercise/
├── config/
│   └── environments.yaml          # Environment configuration
├── resources/
│   ├── keywords/                  # Reusable Robot Framework keywords
│   │   ├── api.resource          # API testing keywords
│   │   ├── auth.resource         # Authentication keywords
│   │   ├── catalog.resource      # Product catalog keywords
│   │   ├── common.resource       # Common utility keywords
│   │   └── subscribtion.resource # Subscription keywords
│   └── locators/                 # Element locators
│       ├── auth_locator.resource
│       ├── catalog_locator.resource
│       ├── common_locator.resource
│       └── subscribtion_locator.resource
├── tests/                        # Test suites
│   ├── auth.robot               # Authentication tests
│   ├── cart.robot               # Cart functionality tests
│   ├── catalog.robot            # Product catalog tests
│   └── home.robot               # Home page tests
├── pyproject.toml               # Project dependencies
├── robocop.toml                 # Code quality configuration
└── README.md                    # Project documentation
```

## 🛠️ Prerequisites

- Python 3.10 or higher
- Chrome browser (default configuration)
- ChromeDriver (automatically managed by SeleniumLibrary)

## 📦 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Jirawat-kumsiri/automationexercise.git
   cd automationexercise
   ```

2. **Install dependencies using uv (recommended):**
   ```bash
   pip install uv
   uv sync
   ```

   Or using pip:
   ```bash
   pip install -r requirements.txt
   ```

## 🏃‍♂️ Running Tests

### Run All Tests
```bash
robot tests/
```

### Run Specific Test Suite
```bash
robot tests/auth.robot
robot tests/catalog.robot
robot tests/cart.robot
robot tests/home.robot
```
## 📊 Test Reports

After running tests, you'll find the following reports in the project root:
- `report.html` - Detailed test execution report
- `log.html` - Comprehensive test log
- `output.xml` - Raw test results in XML format
- Screenshots for failed tests (if any)

### Robocop Configuration (`robocop.toml`)
The project includes comprehensive code quality checks using Robocop, ensuring:
- Proper test case naming conventions
- Correct code formatting and indentation
- Consistent keyword usage
- Best practices compliance

## 🔧 Development

### Code Quality
Run Robocop to check code quality:
```bash
uv run robocop check tests/ resources/
```
## 📈 Continuous Integration

The project includes GitHub Actions workflow for:
- Automated code quality checks with Robocop
- Continuous integration on code changes
- Pull request validation

---

**Happy Testing! 🎯**
