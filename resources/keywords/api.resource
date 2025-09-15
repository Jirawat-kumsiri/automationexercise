*** Settings ***
Library      RequestsLibrary

Variables    ../../config/environments.yaml
Resource    common.resource

*** Keywords ***
Create User
    [Arguments]   ${user}
    ${day}    ${month}    ${year}   common.Get Day Month Year From Date    ${user['birthdate']}
    &{data}   Create Dictionary   
    ...    name=${user['name']}   
    ...    email=${user['mail']}   
    ...    password=${user['password']}
    ...    title=${user['title']}   
    ...    birth_date=${day}   
    ...    birth_month=${month}   
    ...    birth_year=${year}   
    ...    firstname=${user['first_name']}   
    ...    lastname=${user['last_name']}   
    ...    address1=${user['address']}  
    ...    address2=test
    ...    company=test
    ...    country=${user['country']}   
    ...    zipcode=${user['zipcode']}   
    ...    state=${user['state']}   
    ...    city=${user['city']}   
    ...    mobile_number=${user['mobile_number']}
    &{headers}   Create Dictionary   Content-Type=application/x-www-form-urlencoded
    ${response}      RequestsLibrary.Post   url=${environments['default']['url']}api/createAccount   data=${data}    headers=${headers}
    Should Be Equal As Integers    ${response.json()['responseCode']}    201    msg=Failed to create user
    Should Be Equal As Strings    ${response.json()['message']}    User created!    msg=User creation message mismatch

Get User By Email
    [Arguments]   ${user}
    &{params}   Create Dictionary   email=${user['mail']}
    ${response}      RequestsLibrary.GET   url=${environments['default']['url']}api/getUserDetailByEmail   params=${params}
    Should Be Equal As Integers    ${response.json()['responseCode']}    200    msg=Failed to get user details
    [Return]    ${response.json()['user']}

Update User
    [Arguments]   ${user}   ${updates}
    &{data}   Create Dictionary   
    ...    email=${user['mail']}   
    ...    password=${user['password']}
    ...    ${updates}
    &{headers}   Create Dictionary   Content-Type=application/x-www-form-urlencoded
    ${response}      RequestsLibrary.PUT   url=${environments['default']['url']}api/updateAccount   data=${data}    headers=${headers}
    Should Be Equal As Integers    ${response.json()['responseCode']}    200    msg=Failed to update user
    Should Be Equal As Strings    ${response.json()['message']}    User updated!    msg=User update message mismatch

Delete User
    [Arguments]   ${user}
    &{data}   Create Dictionary   
    ...    email=${user['mail']}   
    ...    password=${user['password']}
    &{headers}   Create Dictionary   Content-Type=application/x-www-form-urlencoded
    ${response}      RequestsLibrary.DELETE   url=${environments['default']['url']}api/deleteAccount   data=${data}    headers=${headers}
    Should Be Equal As Integers    ${response.json()['responseCode']}    200    msg=Failed to delete user
    Should Be Equal As Strings    ${response.json()['message']}    Account deleted!    msg=User deletion message mismatch
