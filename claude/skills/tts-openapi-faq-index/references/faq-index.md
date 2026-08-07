# TTS OpenAPI FAQ Index

Use this reference to route common TikTok Shop OpenAPI questions. It is intentionally an index, not a full FAQ body.

## Categories

| Category | Question count | Typical topics |
| --- | ---: | --- |
| App management and authorization | 12 | custom app management, OAuth redirect URL, seller authorization, region restrictions, unlinking apps |
| Token, open_id, timestamp, and signature | 6 | open_id semantics, token refresh, timestamp requirements, invalid signature |
| Order, payment, and fulfillment APIs | 13 | payment_info, order line structures, package IDs, order status, fulfillment |
| Product APIs and catalog data | 30 | product creation, SKU, category rules, attributes, GTIN, images, warehouse and stock |
| Logistics, package, and shipping APIs | 14 | shipping providers, split/combine packages, package freeze, pickup/dropoff, labels |
| Reverse order and inventory impact | 2 | reverse orders and inventory side effects |
| Webhook, notifications, and reliability | 4 | webhook setup, notifications, timeouts, rate limiting |
| Sandbox and testing | 23 | sandbox shops, test accounts, test orders, Seller Center test-account issues |
| Other OpenAPI FAQs | 9 | miscellaneous developer questions |

## FAQ Titles

### App management and authorization

- How to rename the Custom App we have created?
- How can remove the app which is no longer needed?
- What could be the reason for "No permission" when sellers authorize the App?
- What is the redirect url used for?
- Why is the authorization page can't be access from the Mainland China?
- How to unlink a shop for an app?
- Can a shop connect and subscribe multiple applications?
- Why doesn't it take effect after changed the redirect URL?
- "message":"auth state is inactive; detail:Your seller account is yet to finish the onboarding review or your account is not allowed to authorize this APP due to our region restriction."
- error code 105004
- When the seller authorizes, why prompts "No authorization permission for your account region"?
- Is there any way to set multiple Redirect urls for an application?

### Token, open_id, timestamp, and signature

- When "/api/v2/token/get" is called, what is the length of the "open_id" field returned by the api?
- When "/api/v2/token/get" is called, will the open_id length returned by different sellers in be the same?
- What time zone is used for the timestamp of the Open API? What is the accuracy to which digit?
- What is the current logic for refresh token and access token?
- What is the general reason for the error "signature is invalid" in the API call?
- What points should us pay attention to when generating signatures for API calls?

### Order, payment, and fulfillment APIs

- About payment info
- How to fulfillment the order?
- What are the "item_list" and "order_line_list" returned in the order API?
- The buyer's private data returned from the order details api is displayed by "\*" instead. How can I cancel the shielding of data?
- How to identify the order cancelled by the buyer?
- Which order status are included in the order api?
- Is there an API and field indicating whether the order is to be combine or split?
- When the order status is updated to AWAITING_SHIPMENT Pending shipment status, how can I get the package_id?
- Why is the Get Order Detail API not return seller_sku?
- Does the Get Order List API only input one order status and does not support inputting multiple orders? For example, I want to query status 111 and 112
- What is the difference between product_id, sku_id, and seller_sku?
- How to fulfillment the order?
- In the sandbox environment (TikTok Dev Shop), how can the order status be modified to move the order to the next status?

### Product APIs and catalog data

- What does the "state" in the authorization link mean?
- Why did the modification of product SKU attributes not take effect?
- When creating a global product, why is the product weight limited to 20kg and the Create Global Product interface reports an error "product package weight is invalid"?
- Do the length, width, and height fields of the Create Product API and Edit Product API support decimals?
- Is there a fixed maximum of 3 levels of classification for product categories? Or is it necessarily 3 levels? Or are there a few flexible levels of categories with a maximum of a few levels?
- Can include product attributes in the Get Product List API?
- Upload File API response error: upload file type is invalid
- What is the purpose of the qc_reasons field returned by the Get Product Detail API?
- The Create Product API can create products, but I can't find an interface to create many products. Do we have some kind of feed product XML or upload products via template files and can TTS support this feature?
- Is it possible to change the price if the status of the product is in draft?
- If I edit a live product and add a new SKU, will the new SKU fail to be audited and affect the existing SKU? Does the product status change directly to Failed?
- Error create product and edit product API, "size chart image is nil"
- The same category id, store id is different, call /api/products/attributes this API, to get the data is the same?
- How to get warehouse_id when updating inventory using Update Stock API?
- Should we consider product freeze state as product deactivated state and how can we move the product to freeze state?
- "message":"seller create product over limit"？
- Create product API return error: seller tax number invalid?
- When creating a product API to upload an image, an error is reported: desc image invalid?
- Create a global product with the error contains non-English content?
- What is the reason for the API error "product name is invalid"?
- What is the reason for the API error "seller is inactivated"?
- The description field of the Create Product API, which tags can be used?
- Pass a GTIN code for each product, or each variant needs to pass a GTIN code?
- Whether the GTIN codes of different variants of the same product can be the same？
- Whether the GTIN codes of different products can be the same？
- Now there are four identification codes, GTIN/EAN/UPC/ISBN, if it is to pass, no matter which one can be passed Right?
- Is the data obtained by calling the "/api/products/attributes" API for the same country, same category_id and different stores the same?
- The "is_mandatory" field of the "Get Category Rule" API returns true, indicating whether "product_certifications. id" field of the Create Product API must be entered?
- Where do I get the delivery_service_ids to be passed in the Create Product API?
- What is the meaning of the order_status returned by the Get Order Detail API "PARTIALLY_SHIPPING"?

### Logistics, package, and shipping APIs

- Why is the product stock automatically updated to 0 when a merchant selects "out of stock" as the reason for cancellation?
- Is the shipping_provider_id obtained by different developers calling Get Shipping Provider the same?
- When can an order be split?
- When can an order be combined?
- How is the "Confirm Order Split" interface unpacked and restored?
- Does the Search Pre Combine Pkg API return all available combined orders for the store every time?
- Ship Package API, Get Package Detail API error: package freeze
- Why the Get Package Pickup Config API "is_pick_up" and "is_drop_off" both return true?
- Will two sellers get a different response from the shipping provider? That is, can two sellers get different allowed shipping providers? Or is the list the same for all sellers?
- Can Verify Order Split and Confirm Order Split not be called if the order does not need to be shipped with split packages. If not, how do I get the package_id in the Ship Package?
- Can you use the Get Package Detail & Get Package Shipping Document API to get the waybill number and manifest for normal orders, split orders and combined orders?
- Do you have an interface to get the tracking_number of different sub-orders after splitting the order, currently I only see that the order detail interface has the tracking_number of the order dimension.
- If a TikTok Shop Order is split into two packages, can you cancel one of the packages instead of the whole order?
- How do we go about voiding a tiktok carrier label?

### Reverse order and inventory impact

- What's the impact of reverse orders on inventory?
- Can we use multiple "reverse_order_status" on single API call from Path: /api/reverse/reverse_order/list?

### Webhook, notifications, and reliability

- How to get real-time notification of order changes?
- How to set up webhook?
- How to troubleshoot webhook issues?
- 为什么我 1 QPS 也触发了429限流错误？

### Sandbox and testing

- Does the current online developer account support several countries in Southeast Asian countries? At present, the sandbox environment is only available in the UK and Indonesia. Is it possible that the Philippines, Thailand, Malaysia and other regions do not support it?
- Why can't merchants access the sandbox seller portal? They don't have access rights
- How can I create a test order?
- How to delete the sandbox shop?
- How authorized sandbox shop to our self-developed system?
- I already created a service. How come I still can't create a test account?
- I am an ISV partner type. After creating the test account, Seller Center is asking me to provide business information for onboarding. Should I provide real information?
- I am an ISV partner type. I've already created a Sandbox but I'm seeing the notification 'Your account requires additional information. Please submit information in Seller Center'. When I am in Seller Center, it asks me to provide my company information again.
- How do I test order settlement, revenue sharing, and other functions?
- Why is Seller Center asking me to verify tax information?
- I'm using the link in Partner Center to login to my Seller Center test account. Why do I keep getting ‘Something went wrong' error?
- When I login to Seller Center from Sandbox, it asks me to provide a phone number, what should I do?
- When I login to Seller Center from Sandbox, why do I see a 'No bank account linked' notice?
- Can I use my personal TikTok account as a Test Official TikTok Account?
- Can I use my personal TikTok account as a Buyer test Account?
- What kinds of services can I authorize with Seller Center test accounts?
- What kinds of products can I publish for testing purposes?
- After I've published a product, how do I find it in the TikTok app?
- How do I test the finance APIs?
- How does MCN bind 0 fan TT accounts?
- After MCN send the Creator binding invitation, where does the Creator confirm the message?
- 可以创建跨境Full Function Account沙箱店铺吗？
- 错误码36009003是什么含义？怎么解决？

### Other OpenAPI FAQs

- The API "/api/token/refreshtoken" reports an error "code":36004001,"message":"rt has expired". what are the possible reasons?
- Can different shop combine packages?
- Why does the warehouse of TikTok Shop display "RESTRICTED"?
- API request often times out.
- Does the non-cross border store support switching currency, for example, the current store is a UK store and the currency is GBP, does it support changing the store currency to USD?
- I am a Seller Developer partner type. I'm seeing the notification 'Your account requires additional information. Please submit information in Seller Center'. When I am in Seller Center, it asks me to provide my company information again.
- When I try to purchase a product I get the error 'Transaction couldn't be processed. Please contact customer support for details'. What should I do?
- How long does it take for tracking information reflect on an order?
- 可以给已经建好在用的应用增加市场吗?

## Use Rules

- Return category and nearest FAQ title first.
- Use this index to route and summarize; verify current endpoint behavior with official Partner Center docs or MCP tools.
- If the FAQ path, official docs, and MCP/tool checks do not resolve the issue, direct the developer to TTSPC / TikTok Shop Partner Center `Contact Us` to submit a support ticket.
- For a support ticket, ask the developer to include App Key, API name, complete request and response payloads, error codes, timestamps, shop or region context, and screenshots when available.
- Do not expose internal document URLs or local export paths.
