*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/auth.resource

*** Test Cases ***
Register User
    [Documentation]    Test user registration functionality
    common.Open Browser To URL
    common.Find And Click Element    xpath=//a[@href='/login']
    ${user}    common.Generate Profile
    auth.Register New User    ${user}
    auth.Verify Account Created
    auth.Verify Logged In As Username    ${user}
    auth.Delete Account
