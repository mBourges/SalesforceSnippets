# GetSobjectKeyPrefix
##API

Signature: getSObjectKeyPrefix(String objectApiName)
 
Return Value: Boolean

Examples:
- getSObjectKeyPrefix('Account')
- getSObjectKeyPrefix('Issue__c')

## Purpose

This snippet retrives an sObject's prefix by its apiName.
It helps writing code that can be packaged and deploy on a different org.

key prefix = the sObject's 3 letters internal identifier like 'a0N'.

You could use \<sObject>.sObjectType.getDescribe().getKeyPrefix() (e.g.: Account.sObjectType.getDescribe().getKeyPrefix()) but this method is static and cannot be changed at runtime. This snippet can help create more dynamic code.

## Example

Let say we have an __Issue__ object with an ApiName **Issue__c**.
The object prefix in sandbox is **'a0N'**.
Our developer created a visuaforce page with a cancel button that should redirect to the object tab.
He writes the following code:
```java
public String generateCancelURL() {
  String hostname = System.URL.getSalesforceBaseUrl().toExternalForm();
  String objectPrefix = 'a0N';
  
  return hostname + '/' + objectPrefix;
}
```
All tests passed on sandbox, great! Now, our developer tries to deploy on production.
Unfortunately, for what ever reasons (e.g.: object was deleted and recreated), Salesforce changed the prefix to 'a1N'.
This code cannot be deployed as tests now fail.

Using this snippet, our developer can now avoid this error.
```java
public String generateCancelURL() {
  String hostname = System.URL.getSalesforceBaseUrl().toExternalForm();
  String objectPrefix = NPDB_utils.getSObjectKeyPrefix('Issue__c');
  
  return hostname + '/' + objectPrefix;
}
```
