# Salesforce Frameworks and Libs
It is a short overview of Salesforce useful frameworks and libs

### [Apex Test Data Factory](https://github.com/benahm/TestDataFactory/blob/master/docs/EXAMPLES.md)

**Description:** The great library can allow developers to avoid some extra code for record creating.

**Main features**
- Can create sample test data single/collection
- All required fields are populated
- Can be extended `extends TestDataFactory.DefaultValueProvider`

**License:** _Apache License 2.0_

>Please see the usage example in the DataFactory class.

***

### [Apex Query Builder](https://github.com/4an70m/apex-query-builder)

**Description:** The library can allow developers to construct secure query and make it more readable. 

**Main features**
- Security check
- Extract Fields
- Supports Field Set 

**License:** _MIT License_

>Please see the usage example in the Query class.

***

### [Apex REST Route](https://github.com/callawaycloud/apex-rest-route)

**Description:** It mostly oriented on custom REST API based on Apex. 

**Main features**
- Flexible REST APP
- Errors handler
- Easy to extend your app 

**License:** _MIT License_

>Please see `restRoute\controllers` and `restRoute\RestController` class. Also, you can find postman collection in the `artifacts` folder. 

***

### [Apex Unified Logging](https://github.com/rsoesemann/apex-unified-logging)

**Description:** It is Apex Unified Logging lib with additional functionality. Great lib to allow logging in Apex with possibility of configuration.

**Main features**
- No effect of transactions
- Real time logging
- Autofill context and method name

**License:** _MIT License_

>Please see `Logging` class. Also, you can find logging tab to overview the UI component. 

***

### [Force DI](https://github.com/apex-enterprise-patterns/force-di)

**Description:** The Great lib to implement dependency injection on Salesforce.

**Main features**
- Make your code cleaner
- Easy to modify
- Easy to reuse  
- Minimize risks when changes needed


**License:** _BSD-3-Clause License_

>You can find the implementation of DI in the `forceDI/withDI` folder. Please note that you should implement Binding (see `forceDI/withDI`). In the custom metadata record(`di_Binding.apex_Bindings`) you can find the place where the config file is configured.

***

[![Ascendix](https://ascendixtech.com/wp-content/uploads/2020/09/logo-scroll.svg)](https://ascendixtech.com/careers/)
