*** Settings ***
Documentation     Common keywords for web automation
Library           SeleniumLibrary
Resource          ../variables/common_variables.robot

*** Keywords ***
Setup Browser
    [Documentation]    Open browser and configure settings
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${SELENIUM_SPEED}
    Set Selenium Timeout    ${SELENIUM_TIMEOUT}

Navigate To Homepage
    [Documentation]    Navigate to the application homepage
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    ${HOMEPAGE_LOGO}

Verify Page Title
    [Documentation]    Verify the page title matches expected value
    [Arguments]    ${expected_title}
    ${actual_title}=    Get Title
    Should Be Equal    ${actual_title}    ${expected_title}

Verify Navigation Menu Items
    [Documentation]    Verify that main navigation menu items are present
    Wait Until Element Is Visible    ${NAV_HOME}
    Wait Until Element Is Visible    ${NAV_PRODUCTS}
    Wait Until Element Is Visible    ${NAV_CART}
    Wait Until Element Is Visible    ${NAV_SIGNUP_LOGIN}

Click Signup Login Link
    [Documentation]    Click on the Signup/Login navigation link
    Wait Until Element Is Visible    ${NAV_SIGNUP_LOGIN}
    Click Element    ${NAV_SIGNUP_LOGIN}
    Wait Until Page Contains Element    ${SIGNUP_FORM}

Enter Signup Information
    [Documentation]    Enter name and email in signup form
    [Arguments]    ${name}    ${email}
    Wait Until Element Is Visible    ${SIGNUP_NAME_INPUT}
    Input Text    ${SIGNUP_NAME_INPUT}    ${name}
    Input Text    ${SIGNUP_EMAIL_INPUT}    ${email}
    Click Button    ${SIGNUP_BUTTON}

Verify Signup Page Loaded
    [Documentation]    Verify that signup page has loaded correctly
    Wait Until Page Contains    ENTER ACCOUNT INFORMATION
    Page Should Contain Element    ${ACCOUNT_INFO_FORM}