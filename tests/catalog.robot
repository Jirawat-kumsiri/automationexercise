*** Settings ***
Resource    ../resources/keywords/common.resource
Resource    ../resources/keywords/catalog.resource
Resource    ../resources/keywords/api.resource

Test Setup    Run Keywords    common.Open Browser To URL

*** Test Cases ***
Verify All Products and product detail page
    [Documentation]    Test to verify that all products are visible and product detail page is working
    common.Navigate To Products Page
    catalog.Verify All Products Visible
    ${product_name}    catalog.Get First Product Name
    catalog.Click On First Product View Button
    catalog.Verify Product Detail Page Displayed
    catalog.Verify Product Detail Page    ${product_name}
