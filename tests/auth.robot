*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/auth.resource
Resource    ../resources/keywords/api.resource


*** Test Cases ***
Register User
    [Documentation]    Test user registration functionality
    common.Open Browser To URL
    auth.Navigate To Login Page
    ${user}    common.Generate Profile
    auth.Register New User    ${user}
    auth.Verify Account Created
    auth.Verify Logged In As Username    ${user}
    auth.Delete Account

Login User with correct email and password
    [Documentation]    Test user login functionality with valid credentials
    common.Open Browser To URL
    auth.Navigate To Login Page
    ${user}    common.Generate Profile
    api.Create User    ${user}
    auth.Login User    ${user}
    auth.Verify Logged In As Username    ${user}
    auth.Delete Account
