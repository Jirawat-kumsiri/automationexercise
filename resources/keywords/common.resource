*** Settings ***
Library         DateTime
Library         SeleniumLibrary
Library         FakerLibrary
Library         Collections
Library         String
Variables       ../../config/environments.yaml
Resource        ../locators/common_locator.resource
Resource        ../locators/auth_locator.resource
Resource        ../locators/catalog_locator.resource
Resource        ../locators/subscribtion_locator.resource
Resource        ./auth.resource


*** Keywords ***
Open Browser To URL
    [Documentation]    Open browser to the specified URL with given browser type
    [Arguments]    ${url}=${environments['default']['url']}    ${browser}=${environments['default']['browser']}
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Add Location Strategy    data-qa    Find By TestId
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed    0.2s

Find By TestId
    [Documentation]    Custom locator strategy to find elements by data-qa attribute
    [Arguments]    ${browser}    ${criteria}    ${tag}=None    ${constraints}=None
    Set Test Variable    ${browser}
    Set Test Variable    ${tag}
    Set Test Variable    ${constraints}
    ${elements}    SeleniumLibrary.Execute Javascript
    ...    return document.querySelectorAll(`[data-qa="${criteria}"]`);
    RETURN    ${elements}

Find And Click Element
    [Documentation]    Find an element by locator and click it, handling click interception if necessary
    [Arguments]    ${locator}    ${max_attemps}=3
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    ${status}    ${err_msg}    Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${locator}

    IF    '${status}' == 'FAIL'
        ${intercept}    Evaluate    'ElementClickInterceptedException' in $err_msg
        IF    ${intercept}
            common.Handle Click Intercepted    ${locator}    ${max_attemps}
        END
    END

Handle Click Intercepted
    [Documentation]    Handle click interception by scrolling and retrying click action
    [Arguments]    ${locator}    ${max_attempts}=3
    SeleniumLibrary.Scroll Element Into View    ${locator}
    FOR    ${index}    IN RANGE    ${max_attempts}
        SeleniumLibrary.Execute Javascript    window.scrollBy(0, 100);
        ${status}    ${err_msg}    Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${locator}
        IF    '${status}' == 'PASS'    RETURN
    END
    Fail    Click action could not be completed after ${max_attempts} attempts.

Find And Input Text
    [Documentation]    Find an element by locator and input the specified text
    [Arguments]    ${locator}    ${text}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    SeleniumLibrary.Input Text    ${locator}    ${text}

Find And Select From List By Value
    [Documentation]    Find a select element by locator and select an option by its value
    [Arguments]    ${locator}    ${value}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=10s
    SeleniumLibrary.Select From List By Value    ${locator}    ${value}

Generate Profile
    [Documentation]    Generate a user profile with FakerLibrary and enrich it with additional data
    ${gender}    Evaluate    random.choice(["M","F"])    modules=random
    ${profile}    FakerLibrary.Simple Profile    sex=${gender}
    ${first_name}    ${last_name}    String.Split String    ${profile['name']}    separator=${SPACE}    max_split=1
    ${country}    FakerLibrary.Country
    Collections.Set To Dictionary    dictionary=${profile}
    ...    password=${environments['default']['password']}
    ...    first_name=${first_name}
    ...    last_name=${last_name}
    ...    country=${country}
    ...    state=${environments['default']['state']}
    ...    city=${environments['default']['city']}
    ...    zipcode=${environments['default']['zipcode']}
    ...    mobile_number=${environments['default']['mobile_number']}

    IF    '${gender}' == 'M'
        Collections.Set To Dictionary    dictionary=${profile}    title_type=1    title=Mr
    ELSE
        Collections.Set To Dictionary    dictionary=${profile}    title_type=2    title=Mrs
    END
    RETURN    ${profile}

Get Day Month Year From Date
    [Documentation]    Extract day, month, and year from a given date. datetime.date(2025, 3, 12)
    [Arguments]    ${date}
    ${year}    Evaluate    str(${date.year})
    ${month}    Evaluate    str(${date.month})
    ${day}    Evaluate    str(${date.day})
    RETURN    ${day}    ${month}    ${year}

Navigate To Products Page
    [Documentation]    Navigate to the products page from the home page
    common.Find And Click Element    ${common.link_products}
    SeleniumLibrary.Page Should Contain Element    ${catalog.txt_all_products}    timeout=10s

Navigate To Login Page
    [Documentation]    Navigate to the login page from the home page
    common.Find And Click Element    ${common.link_login}
    auth.Verify Login Page Displayed

Scroll To Footer
    [Documentation]    Scroll to the footer section of the home page
    SeleniumLibrary.Scroll Element Into View    ${common.footer}
