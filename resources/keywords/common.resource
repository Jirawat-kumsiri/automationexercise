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
    [Arguments]    ${url}=${environments['default']['url']}    ${browser}=${environments['default']['browser']}
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed    0.2s

Find And Click Element
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
    [Arguments]    ${locator}    ${max_attempts}=3
    SeleniumLibrary.Scroll Element Into View    ${locator}
    FOR    ${index}    IN RANGE    ${max_attempts}
        SeleniumLibrary.Execute Javascript    window.scrollBy(0, 100);
        ${status}    ${err_msg}    Run Keyword And Ignore Error    SeleniumLibrary.Click Element    ${locator}
        IF    '${status}' == 'PASS'
            RETURN
        END
    END
    Fail    Click action could not be completed after ${max_attempts} attempts.

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
    common.Find And Click Element    ${common.link_products}
    SeleniumLibrary.Page Should Contain Element    ${catalog.txt_all_products}    timeout=10s

Navigate To Login Page
    common.Find And Click Element    ${common.link_login}
    auth.Verify Login Page Displayed

Scroll To Footer
    [Documentation]    Scroll to the footer section of the home page
    SeleniumLibrary.Scroll Element Into View    ${common.footer}
