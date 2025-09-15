*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    Collections
Library    String
Library    DateTime

Variables    ../../config/environments.yaml

*** Keywords ***
Open Browser To URL
    [Arguments]    ${url}=${environments['default']['url']}    ${browser}=${environments['default']['browser']}
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed    0.2s

Find And Click Element
    [Arguments]    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    SeleniumLibrary.Click Element    ${locator}

Find And Input Text
    [Arguments]    ${locator}    ${text}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    SeleniumLibrary.Input Text    ${locator}    ${text}

Find And Select From List By Value
    [Arguments]    ${locator}    ${value}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    SeleniumLibrary.Select From List By Value    ${locator}    ${value}

Generate Profile
    ${gender}    Evaluate    random.choice(["M","F"])    modules=random
    ${profile}    FakerLibrary.Simple Profile    sex=${gender}
    ${first_name}    ${last_name}    String.Split String    ${profile['name']}    separator=${SPACE}
    ${country}    FakerLibrary.Country
    Collections.Set To Dictionary    dictionary=${profile}    
    ...    password=${environments['default']['password']}
    ...    first_name=${first_name}
    ...    last_name=${last_name}
    ...    country=${country}

    IF    '${gender}' == 'M'
        Collections.Set To Dictionary    dictionary=${profile}    title_type=1
    ELSE
        Collections.Set To Dictionary    dictionary=${profile}    title_type=2
    END
    RETURN    ${profile}

Get Day Month Year From Date
    [Documentation]    Extract day, month, and year from a given date. datetime.date(2025, 3, 12)
    [Arguments]    ${date}
    ${year}    Evaluate    str(${date.year})
    ${month}   Evaluate    str(${date.month})
    ${day}     Evaluate    str(${date.day})
    RETURN    ${day}    ${month}    ${year}
