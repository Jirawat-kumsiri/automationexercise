*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/auth.resource
Resource    ../resources/keywords/api.resource

Test Setup    Run Keywords    common.Open Browser To URL    
...                    AND    common.Navigate To Login Page

*** Test Cases ***
Register User
    [Documentation]    Test user registration functionality
    ${user}    common.Generate Profile
    auth.Signup New User    ${user['name']}    ${user['mail']}
    auth.Fill Registration Form And Submit    ${user}
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

Logout User
    [Documentation]    Test user logout functionality
    ${user}    common.Generate Profile
    api.Create User    ${user}
    auth.Login User    ${user}
    auth.Verify Logged In As Username    ${user}
    auth.Click Logout
    auth.Verify Login Page Displayed
    [Teardown]    api.Delete User    ${user}

Register User with existing email
    [Documentation]    Test user registration with an already registered email
    ${user}    common.Generate Profile
    api.Create User    ${user}
    auth.Signup New User    ${user['name']}    ${user['mail']}
    auth.Verify Registration Failed Due To Existing Email
    [Teardown]    api.Delete User    ${user}
