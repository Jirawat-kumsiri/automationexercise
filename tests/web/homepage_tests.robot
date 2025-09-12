*** Settings ***
Documentation     Example web automation test using Automation Exercise website
Library           SeleniumLibrary
Resource          ../resources/keywords/common_keywords.robot
Resource          ../resources/variables/common_variables.robot
Test Setup        Setup Browser
Test Teardown     Close Browser

*** Test Cases ***
Verify Homepage Title
    [Documentation]    Verify that the homepage loads and has correct title
    [Tags]             smoke    homepage
    Navigate To Homepage
    Verify Page Title    Automation Exercise

Verify Navigation Menu
    [Documentation]    Verify that main navigation elements are present
    [Tags]             smoke    navigation
    Navigate To Homepage
    Verify Navigation Menu Items

Register New User
    [Documentation]    Test user registration functionality
    [Tags]             registration    user-management
    Navigate To Homepage
    Click Signup Login Link
    Enter Signup Information    Test User    test@example.com
    Verify Signup Page Loaded