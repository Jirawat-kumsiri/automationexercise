*** Variables ***
# API Base Configuration
${API_BASE_URL}           https://automationexercise.com

# API Endpoints
${PRODUCTS_ENDPOINT}      /api/productsList
${SEARCH_ENDPOINT}        /api/searchProduct
${USER_ENDPOINT}          /api/getUserDetailByEmail
${BRANDS_ENDPOINT}        /api/brandsList

# Test Data
${TEST_EMAIL}             test@example.com
${TEST_SEARCH_TERM}       tshirt
${INVALID_EMAIL}          invalid-email

# Expected Response Codes
${SUCCESS_CODE}           200
${BAD_REQUEST_CODE}       400
${NOT_FOUND_CODE}         404

# Common Headers
&{API_HEADERS}            Content-Type=application/json
...                       Accept=application/json