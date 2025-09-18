*** Settings ***
Resource    ../locators/subscribtion_locator.resource
Resource    ../locators/common_locator.resource
Resource    ./common.resource

***** Keywords ***
Scroll To Footer
    [Documentation]    Scroll to the footer section of the home page
    SeleniumLibrary.Scroll Element Into View    ${subscribtion.footer}

Verify Subscription Text Visible
    [Documentation]    Verify that the subscription section is visible in the footer
    SeleniumLibrary.Wait Until Element Is Visible    ${subscribtion.txt_subscription}    timeout=10s
    SeleniumLibrary.Element Should Be Visible        ${subscribtion.txt_subscription}

Fill Subscription Email
    [Documentation]    Fill the subscription email input with a generated email
    [Arguments]    ${email}
    common.Find And Input Text    ${subscribtion.input_subscribe_email}    ${email}
    common.Find And Click Element    ${subscribtion.btn_subscribe}

Verify Subscription Success Message
    [Documentation]    Verify that the subscription success message is displayed
    SeleniumLibrary.Wait Until Element Is Visible    ${subscribtion.toast_success_subscribe}    timeout=10s
    SeleniumLibrary.Element Text Should Be    ${subscribtion.toast_success_subscribe}    You have been successfully subscribed!