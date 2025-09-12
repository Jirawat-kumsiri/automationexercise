*** Settings ***
Documentation     Simple validation test to verify Robot Framework structure
Library           OperatingSystem
Library           Collections
Library           ../libraries/AutomationExerciseLibrary.py

*** Variables ***
${PROJECT_ROOT}    ${CURDIR}/..

*** Test Cases ***
Verify Project Structure
    [Documentation]    Verify that all required directories exist
    [Tags]             validation    structure
    Directory Should Exist    ${PROJECT_ROOT}/tests
    Directory Should Exist    ${PROJECT_ROOT}/resources
    Directory Should Exist    ${PROJECT_ROOT}/libraries
    Directory Should Exist    ${PROJECT_ROOT}/data
    Directory Should Exist    ${PROJECT_ROOT}/config
    Log    ✓ All required directories exist

Verify Essential Files
    [Documentation]    Verify that essential configuration files exist
    [Tags]             validation    files
    File Should Exist    ${PROJECT_ROOT}/requirements.txt
    File Should Exist    ${PROJECT_ROOT}/README.md
    File Should Exist    ${PROJECT_ROOT}/run_tests.sh
    File Should Exist    ${PROJECT_ROOT}/config/environments.yaml
    Log    ✓ All essential files exist

Verify Test Data Loading
    [Documentation]    Test custom library functions for data loading
    [Tags]             validation    data
    ${json_data}=    Load Test Data From Json    ${PROJECT_ROOT}/data/test_data.json
    Should Contain    ${json_data}    users
    Should Contain    ${json_data}    products
    Log    ✓ JSON data loading works
    
    ${csv_data}=    Load Test Data From Csv    ${PROJECT_ROOT}/data/test_users.csv
    ${length}=    Get Length    ${csv_data}
    Should Be True    ${length} > 0
    Log    ✓ CSV data loading works

Verify Email Generation
    [Documentation]    Test unique email generation
    [Tags]             validation    utility
    ${email1}=    Generate Unique Email    test@example.com
    ${email2}=    Generate Unique Email    test@example.com
    Should Not Be Equal    ${email1}    ${email2}
    Should Contain    ${email1}    @example.com
    Log    ✓ Unique email generation works

Verify Directory Creation
    [Documentation]    Test results directory creation
    [Tags]             validation    utility
    Create Results Directory    /tmp/test_results
    Directory Should Exist    /tmp/test_results
    Remove Directory    /tmp/test_results    recursive=True
    Log    ✓ Directory creation works