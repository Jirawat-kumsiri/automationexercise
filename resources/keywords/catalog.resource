*** Settings ***
Resource        ../locators/catalog_locator.resource
Resource        ../locators/common_locator.resource
Resource        ./common.resource

*** Keywords ***
Verify All Products Visible
    [Documentation]    Verify that all products are visible on the products page
    SeleniumLibrary.Wait Until Element Is Visible    ${catalog.div_all_products}    timeout=10s
    SeleniumLibrary.Element Should Be Visible    ${catalog.div_all_products}

Get First Product Name
    [Documentation]
    ${product_name}    SeleniumLibrary.Get Text    ${catalog.txt_first_product}
    RETURN    ${product_name}

Click On First Product View Button
    [Documentation]    Click on the 'View Product' button of the first product
    common.Find And Click Element    ${catalog.btn_first_product}

Verify Product Detail Page Displayed
    [Documentation]    Verify that the product detail page is displayed
    SeleniumLibrary.Wait Until Element Is Visible    ${catalog.div_product_details}    timeout=10s
    SeleniumLibrary.Element Should Be Visible    ${catalog.div_product_details}

Verify Product Detail Page
    [Documentation]    Validate core product info is visible on the detail page.
    [Arguments]    ${expected_name}
    Page Should Contain    ${expected_name}
    # Category line, price, availability, condition, brand (all are rendered as label:value lines)
    Page Should Contain    Category:
    Page Should Contain    Rs.
    Page Should Contain    Availability:
    Page Should Contain    Condition:
    Page Should Contain    Brand:
