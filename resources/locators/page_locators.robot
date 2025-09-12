*** Settings ***
Documentation     Page object locators for web elements
# This file contains locators organized by page for better maintainability

*** Variables ***
# Homepage Locators
&{HOMEPAGE}       logo=css:img[alt="Website for automation practice"]
...               nav_home=xpath://a[contains(text(),'Home')]
...               nav_products=xpath://a[contains(text(),'Products')]
...               nav_cart=xpath://a[contains(text(),'Cart')]
...               nav_signup=xpath://a[contains(text(),'Signup / Login')]
...               footer=css:footer

# Login/Signup Page Locators
&{LOGIN_PAGE}     signup_name=css:input[name="name"]
...               signup_email=css:input[data-qa="signup-email"]
...               signup_btn=css:button[data-qa="signup-button"]
...               login_email=css:input[data-qa="login-email"]
...               login_password=css:input[data-qa="login-password"]
...               login_btn=css:button[data-qa="login-button"]

# Products Page Locators
&{PRODUCTS_PAGE}  products_list=css:.features_items
...               product_item=css:.productinfo
...               add_to_cart=css:.add-to-cart
...               view_product=css:.choose a
...               search_box=css:input#search_product
...               search_btn=css:button#submit_search

# Cart Page Locators
&{CART_PAGE}      cart_table=css:#cart_info_table
...               proceed_checkout=css:.btn-default.check_out
...               remove_item=css:.cart_quantity_delete