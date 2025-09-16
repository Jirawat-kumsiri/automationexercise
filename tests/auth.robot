*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/auth.resource
Resource    ../resources/keywords/api.resource

Test Setup    Run Keywords    common.Open Browser To URL    
...                    AND    auth.Navigate To Login Page

*** Test Cases ***
Register User
    [Documentation]    Test user registration functionality
    ${user}    common.Generate Profile
    auth.Register New User    ${user}
    auth.Verify Account Created
    auth.Verify Logged In As Username    ${user}
    auth.Delete Account

Login User with correct email and password
    [Documentation]    Test user login functionality with valid credentials
    ${user}    common.Generate Profile
    api.Create User    ${user}
    auth.Login User    ${user}
    auth.Verify Logged In As Username    ${user}
    auth.Delete Account

Login User with incorrect email and password
    [Documentation]    Test user login functionality with invalid credentials
    ${invalid_user}    Create Dictionary    mail=invalid_email@test.com    password=wrongpassword
    auth.Login User    ${invalid_user}
    auth.Verify Login Failed
