GlobalCollect: A Gem
======================

A relatively bare Ruby library that supplies access to the GlobalCollect XML payment API.

I've tried for utility over a particular pattern or paradigm (like MVC, which is I guess, what this most-closely resembles...maybe?) Also, this is hardly a complete client implementation; GC exposes 36 methods in their API, while only a fraction are covered here. However, these are the basics needed to integrate and begin using the Hosted MerchantLink service.

With what's here and a basic web app you should be able to use the Hosted MerchantLink service to go through the basic lifecycle of an order: create, authorize, settle, refund/cancel.

## Getting Started
* Get your GlobalCollect API credentials out, then

        gem install global_collect

* See examples/test_connection.rb, fill in your merchant id, and authentication scheme and then run the first example, which is a `TEST_CONNECTION` call to make sure everything is nominally OK.

## Breakdown
### Requests
Requests are the basic unit of communication with the GlobalCollect API. They're mostly the programmatic and XML glue that ties the action and arguments of the call together, generating XML to send to GlobalCollect. They can be found under lib/global_collect/requests/*.rb

Each API call that has been implemented has been implemented as a subclass (directly or indirectly) of
        GlobalCollect::Requests::Base
If an API call accepts multiple "models" in the XML request (PARAMS sub-nodes with nontrivial sub-nodes of their own), it is probably a subclass of
        GlobalCollect::Requests::Composite
and is constructed with Model-Builder pairs like this:
        GlobalCollect::Requests::DoRefund.new([payment_request_model, GlobalCollect::Builders::DoRefund::Payment])
_The models and builders are usually paired in their respective module hierarchies:_
        GlobalCollect::RequestModels::DoRefund::Payment
            vs.
        GlobalCollect::Builders::DoRefund::Payment
In the case where the arguments to the request constructor are models, the validation for the values in the models is encapsulated in the model itself.

If the call accepts a fixed set of non-nested arguments, it will probably be implemented as a subclass of
        GlobalCollect::Requests::Simple
and be constructed with the values of the arguments without and intermediary model. Validation for these members is defined in the request, in this case.

### Builders
`Builders` simply take hash-like objects (usually a RequestModel or just a hash for simpler calls) and construct the sub-nodes of the `PARAMS` XML node in the request. As mentioned above, `Builders` are paired with their `RequestModels` by name, simply replacing '`RequestModels`' with '`Builders`' in the module path.
    
### RequestModels
As mentioned above, `RequestModels` are a way of breaking up the multiple conceptual arguments to the API. They are paired to their Builders as mentioned above. They're really just a nice way to get a little sanity into this piece when the XML structures that are used as arguments to the API get a bit hairy. (In the sense that they form a kind of inheritance tree, depending on the payment type, or that they have multiple, large arguments, etc...) However, there has been a conscious effort to eschew this complexity when dealing with API calls that really don't have much relative conceptual complexity. (`GetOrderStatus` really only has one string as an argument, `ORDERID`, even though it is nested in an `ORDER` node.)

### Responses
#### The raw responses from the API are divided into five groups:
* Basic
    * No content besides `META`, `RESULT`, or `ERROR`
* Success Row (Single)
    * Basic + `ROW` node which contains a roughly fixed set of keys independent of input as well as an extra set of keys that vary based on input.
    * For instance, `CONVERT_AMOUNT` returns a fixed set of keys.
    * But, `INSERT_ORDERWITHPAYMENT` returns extra keys depending on payment type.
* Success Row (Multiple)
    * Basic + multiple `ROW` nodes, each containing a basic set of fixed keys
    * Currently, only `GET_ORDER_STATUS` (v1.0) has been verified to return one OR multiple rows if multiple efforts (for recurring payments) or multiple attempts on efforts have been made. (This was learned not from the API docs, but from a GC rep.)
* Complex
    * Basic + multiple subnodes of `RESULT` that do not follow the `ROW`/keys format.
    * For instance, `GET_ORDERSTATUS` (v2.0) could return multiple `STATUS` nodes.
    
#### The strategy for handling them is as follows:
The base response, `GlobalCollect::Responses::Base`, is augmented by mix-in modules suggested by the `suggested_response_mixins` method of the request. These mix-ins allow pretty, method-style access to the members.

`GlobalCollect::Requests::Simple` requests define the `suggested_response_mixins` directly in the implementation, whereas `GlobalCollect::Requests::Composite` delegate to their contained `RequestModels`. This follows the GC API's pattern of defining the response's nodes based on the type of payment product selected, version used, service used, etc for certain requests.

For responses that follow the singular "Success Row"-style, `GlobalCollect::Responses::SuccessRow` is included first and then augmented with extra modules if necessary.

For the other responses, there's no particular structure to the implementations.

However, if basic hash-style access to the Crack-parsed response is desired, you can easily do so like this:
        response = client.make_request(some_request)
        response.response_hash["XML"]["REQUEST"]["RESPONSE"]["META"]["REQUESTID"] == response.request_id
        # => true

### Validation
The GlobalCollect programmer's guide (see below for specific documentation notes) has specified the data formatting expected in requests, and as such, they appear in this gem in roughly the same data format as they appear there:
        FIELDNAME => [REQUIRED?, FORMAT_STRING]
However, in the cases where a field is required only when using a specific service or product, I have relaxed the requirements for the base model. For instance, see the difference between:
        GlobalCollect::RequestModels::InsertOrderWithPayment::CreditCardOnlinePayment
            vs
        GlobalCollect::RequestModels::InsertOrderWithPayment::HostedCreditCardOnlinePayment

In the Hosted version, the field definitions for `CARDNUMBER` and `EXPIRYDATE` have been changed from "R" (required) to "O" (optional), even though the programmer's guide has them marked as "R" with a superscript indicating they are not required in the particular case of HostedMerchantLink payments.

## Notes
### On testing:

Complete test coverage has not been a priority, given the simplistic nature of some of the components. For instance, the modules under `GlobalCollect::Responses` are for the most part the same mechanics (convert a string to an accessor) wrapped around slightly different metadata (lists of method names). I've omitted complete coverage of these methods, in favor of testing the mechanics here and there. Anything that does more than define trivial accessors, in those modules has been tested. A similar approach has been adopted everywhere else; test the moving parts everywhere, test the metadata-transformation stuff once.

I have also provided some sanitized, canned XML responses (in `spec/support/*_response.xml`) that have either been garnered from the Programmer's Guide PDF or from the wire logs produced during the integration testing period.

### On documentation:

All documentation references (like '§ WDL 5.26.1') in the source code refer to the "GlobalCollect WDL Programmers Guide -- 17 November 2009" document (section 5.26.1, in our previous parenthetical), which you'll have to get from GlobalCollect.

### On GC API naming conventions:

They have a curious and inconsistent underscoring convention that I'm not fond of. (API actions `INSERT_ORDERWITHPAYMENT` vs. `DO_POSTAL_REMINDER`, fields like `ORDERID` and `CURRENCYCODE`) As a result, I've added underscores between words that lacked it when defining reader methods and when naming classes and modules (`InsertOrderWithPayment`, `GetOrderStatus`, `#order_id`, `#currency_code`). However, to avoid confusion in what you're sending to GC, I have left the hash keys for models and requests the same as the names of the XML nodes whose content they represent. I may change this in the future to add the prettier hash keys as an option (strings => raw names, underscored symbols => pretty names).

### On GC API versions:

There are currently two API versions: 1.0 and 2.0. However, not all requests are implemented on GC's end in version 2.0. Notably, `GET_ORDERSTATUS` has a 2.0 call.

### On wire logging:
If you specify
        GlobalCollect.wire_log_file = "mylog.log"
the raw XML of all requests and responses will be logged to that file *unsanitized*. Be sure to keep these secure if you choose that option as they could contain addresses, emails, credit card numbers, etc. If no file is specified, logging will be done to STDOUT.

To assign your own logger to the gem, simply do:
        your_logger = Rails.logger
        GlobalCollect.wire_logger = your_logger
        client = GlobalCollect::ApiClient.new ...

## Contributing

Pull requests and issues (both on GitHub) are greatly appreciated. For patches, please include tests. Thanks!