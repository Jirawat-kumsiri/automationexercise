*** Settings ***
Resource    ./common.resource
Resource    ../locators/auth_locator.resource


*** Keywords ***
Register New User
    [Documentation]    Register a new user with generated profile data
    [Arguments]    ${user}
    common.Find And Input Text    ${auth.input_signup_name}    ${user['name']}
    common.Find And Input Text    ${auth.input_signup_email}    ${user['mail']}
    common.Find And Click Element    ${auth.button_signup}
    SeleniumLibrary.Wait Until Element Is Visible    ${auth.div_login_form}    timeout=10s
    ${gender_type_locator}    String.Replace String    ${auth.input_gender}    {{title_type}}    ${user['title_type']}
    common.Find And Click Element    ${gender_type_locator}
    common.Find And Input Text    ${auth.input_password}    ${user['password']}
    ${day}    ${month}    ${year}    common.Get Day Month Year From Date    ${user['birthdate']}
    common.Find And Select From List By Value    ${auth.select_days}    ${day}
    common.Find And Select From List By Value    ${auth.select_months}    ${month}
    common.Find And Select From List By Value    ${auth.select_years}    ${year}
    common.Find And Input Text    ${auth.input_first_name}    ${user['first_name']}
    common.Find And Input Text    ${auth.input_last_name}    ${user['last_name']}
    common.Find And Input Text    ${auth.input_address}    ${user['address']}
    common.Find And Select From List By Value    ${auth.select_country}    ${environments['default']['country']}
    common.Find And Input Text    ${auth.input_state}    ${environments['default']['state']}
    common.Find And Input Text    ${auth.input_city}    ${environments['default']['city']}
    common.Find And Input Text    ${auth.input_zipcode}    ${environments['default']['zipcode']}
    common.Find And Input Text    ${auth.input_mobile}    ${environments['default']['mobile_number']}
    common.Find And Click Element    ${auth.button_create}

Verify Account Created
    SeleniumLibrary.Wait Until Element Is Visible    ${auth.txt_account_created}    timeout=10s
    SeleniumLibrary.Element Should Be Visible    ${auth.txt_account_created}
    common.Find And Click Element    ${auth.link_continue_button}

Verify Logged In As Username
    [Arguments]    ${user}
    SeleniumLibrary.Wait Until Element Is Visible    ${auth.link_logged_in_user}    timeout=10s
    ${logged_in_text}    SeleniumLibrary.Get Text    ${auth.link_logged_in_user}
    Should Contain    ${logged_in_text}    ${user['name']}

Delete Account
    common.Find And Click Element    ${auth.link_delete_account}
    SeleniumLibrary.Wait Until Element Is Visible    ${auth.txt_account_deleted}    timeout=10s
    SeleniumLibrary.Element Should Be Visible    ${auth.txt_account_deleted}

Login User
    [Arguments]    ${user}
    common.Find And Input Text    ${auth.input_login_email}       ${user['mail']}
    common.Find And Input Text    ${auth.input_login_password}    ${user['password']}
    common.Find And Click Element    ${auth.button_login}

Navigate To Login Page
    common.Find And Click Element    xpath=//a[@href='/login']

Verify Login Failed
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//p[contains(text(),'Your email or password is incorrect!')]    timeout=10s
    SeleniumLibrary.Element Should Be Visible    xpath=//p[contains(text(),'Your email or password is incorrect!')]
