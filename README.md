## Note

**We need to create a AWS IAM user first so we can have a SES SECRET_ACCESS_KEY and ACCESS_KEY_ID**

At the moment of creation, when we are setting the users permissions, we must _Attach an existing policy directly_. Policy must be **AmazonSESFullAccess**

## (really tiny) Description

The `lambda_handler` method recieves an `event` parameter. 

This parameter has this format:

    {
      "name-input": "Matías Pacheco",
      "email-input": "matipacheco@gmail.com",
      "description-input": "Holiii, quiero trabajar con uds!"
    } 
