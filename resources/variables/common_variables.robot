*** Variables ***
# Browser Configuration
${BROWSER}                chrome
${SELENIUM_SPEED}         0.5
${SELENIUM_TIMEOUT}       10

# Application URLs
${BASE_URL}               https://automationexercise.com

# Homepage Elements
${HOMEPAGE_LOGO}          css:img[alt="Website for automation practice"]
${NAV_HOME}               xpath://a[contains(text(),'Home')]
${NAV_PRODUCTS}           xpath://a[contains(text(),'Products')]
${NAV_CART}               xpath://a[contains(text(),'Cart')]
${NAV_SIGNUP_LOGIN}       xpath://a[contains(text(),'Signup / Login')]

# Signup/Login Page Elements
${SIGNUP_FORM}            css:.signup-form
${SIGNUP_NAME_INPUT}      css:input[name="name"]
${SIGNUP_EMAIL_INPUT}     css:input[data-qa="signup-email"]
${SIGNUP_BUTTON}          css:button[data-qa="signup-button"]
${ACCOUNT_INFO_FORM}      css:.login-form

# Login Elements
${LOGIN_EMAIL_INPUT}      css:input[data-qa="login-email"]
${LOGIN_PASSWORD_INPUT}   css:input[data-qa="login-password"]
${LOGIN_BUTTON}           css:button[data-qa="login-button"]

# Products Page Elements
${PRODUCTS_LIST}          css:.features_items
${PRODUCT_ITEM}           css:.productinfo
${ADD_TO_CART_BTN}        css:.add-to-cart

# Cart Page Elements
${CART_TABLE}             css:#cart_info_table
${PROCEED_TO_CHECKOUT}    css:.btn-default.check_out