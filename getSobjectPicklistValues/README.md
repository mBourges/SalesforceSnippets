# GetSobjectPicklistValues
##API

Signature: getSobjectPicklistValues(String objectApiName, String fieldName)
 
Return Value: List<SelectOption>

Examples:
- getSobjectPicklistValues('Account', 'Type')
- getSobjectPicklistValues('Issue__c', 'Description__c')

## Purpose

This snippet retrieves an sObject's field is picklist values by the object and field API names.

You could use Schema.sObjectType.Account.\<sObjectApiName>.\<FieldApiName>.isUpdateable() (e.g.: Schema.sObjectType.Account.fields.Type.isUpdateable()) but this method is static and cannot be changed at runtime. This snippet can help create more dynamic and reuseable code.

## Example

## Notes & Reference
This method do not take in consideration the record type (as apex do not provide any methods for that). It also cannot be used with dependent picklists.

Use it for record type independant picklist.
