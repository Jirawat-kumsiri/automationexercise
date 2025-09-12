*** Settings ***
Documentation     API keywords for testing REST endpoints
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../variables/api_variables.robot

*** Keywords ***
Setup API Session
    [Documentation]    Create session for API testing
    Create Session    automation_exercise    ${API_BASE_URL}    verify=False

Get All Products
    [Documentation]    Get list of all products
    ${response}=    GET On Session    automation_exercise    /api/productsList
    RETURN    ${response}

Search Products
    [Documentation]    Search for products using POST request
    [Arguments]    ${search_data}
    ${response}=    POST On Session    automation_exercise    /api/searchProduct    data=${search_data}
    RETURN    ${response}

Get User By Email
    [Documentation]    Get user details by email
    [Arguments]    ${email}
    ${params}=    Create Dictionary    email=${email}
    ${response}=    GET On Session    automation_exercise    /api/getUserDetailByEmail    params=${params}
    RETURN    ${response}

Verify Response Status
    [Documentation]    Verify HTTP response status code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}

Verify Products List Response
    [Documentation]    Verify products list API response structure
    [Arguments]    ${response}
    ${json_response}=    Convert String To Json    ${response.content}
    Dictionary Should Contain Key    ${json_response}    responseCode
    Dictionary Should Contain Key    ${json_response}    products

Verify Search Results
    [Documentation]    Verify search results contain expected product
    [Arguments]    ${response}    ${search_term}
    ${json_response}=    Convert String To Json    ${response.content}
    ${products}=    Get Value From Json    ${json_response}    $.products
    Length Should Be Greater Than    ${products}    0

Log Response
    [Documentation]    Log API response for debugging
    [Arguments]    ${response}
    Log    Status Code: ${response.status_code}
    Log    Response Body: ${response.content}