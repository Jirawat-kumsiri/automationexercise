*** Settings ***
Documentation     API testing example for Automation Exercise backend
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../resources/keywords/api_keywords.robot
Resource          ../resources/variables/api_variables.robot
Test Setup        Setup API Session
Test Teardown     Delete All Sessions

*** Test Cases ***
Get All Products API
    [Documentation]    Test GET /api/productsList endpoint
    [Tags]             api    products    smoke
    ${response}=       Get All Products
    Verify Response Status    ${response}    200
    Verify Products List Response    ${response}

Search Product API
    [Documentation]    Test POST /api/searchProduct endpoint
    [Tags]             api    products    search
    ${search_data}=    Create Dictionary    search_product=tshirt
    ${response}=       Search Products    ${search_data}
    Verify Response Status    ${response}    200
    Verify Search Results    ${response}    tshirt

Get User Account Info API
    [Documentation]    Test GET /api/getUserDetailByEmail endpoint
    [Tags]             api    user    account
    ${email}=          Set Variable    test@example.com
    ${response}=       Get User By Email    ${email}
    Log Response       ${response}