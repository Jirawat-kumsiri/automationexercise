*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/subscribtion.resource

Test Setup    Run Keywords    common.Open Browser To URL 
Test Teardown    SeleniumLibrary.Close All Browsers

*** Test Cases ***
Verify Subscription in home page
    [Documentation]    Verify that the subscription form is present on the home page
    ${user}    common.Generate Profile
    common.Scroll To Footer
    subscribtion.Verify Subscription Text Visible
    subscribtion.Fill Subscription Email    email=${user['mail']}
    subscribtion.Verify Subscription Success Message
