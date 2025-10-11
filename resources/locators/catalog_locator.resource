*** Variables ***
${catalog.div_all_products}        xpath=//div[@class='features_items']
${catalog.txt_all_products}        xpath=//h2[normalize-space()='All Products']
${catalog.btn_first_product}       xpath=//div[@class='choose'][1]
${catalog.txt_first_product}       xpath=(//div[@class='productinfo text-center']/p)[1]
${catalog.txt_product_name}             xpath=//div[@class='productinfo text-center']/p
${catalog.div_product_details}     xpath=//div[@class='product-details']
${catalog.input_search}            id=search_product
${catalog.button_search}           id=submit_search
