# IsFieldUpdateable
##API

Signature: isFieldUpdateable(String objectApiName, String fieldName)
 
Return Value: Boolean

Examples:
- isFieldUpdateable('Account', 'Type')
- isFieldUpdateable('Issue__c', 'Description__c')

## Purpose

This snippet determines whether an sObject's field is updateable by the object and field API name.
It helps testing CRUD and FLS Enforcement.

You could use Schema.sObjectType.Account.\<sObjectApiName>.\<FieldApiName>.isUpdateable() (e.g.: Schema.sObjectType.Account.fields.Type.isUpdateable()) but this method is static and cannot be changed at runtime. This snippet can help create more dynamic and reuseable code.

## Example

Let create an object called Issue(Issue__c) with a Title(Title__c) and a Status(Status__c).
The status can be 'Open', 'Hold' or 'Closed'
Now, we create a visualforce page and its controller to update the status. Here is the first version.
```html
<apex:page standardcontroller="Issue__c" extensions="IssueUpdateExtension">
  <apex:pageBlock title="Issue">
    <apex:outputField value="{!Issue__c.Title__}" />
    <apex:form>
      <apex:selectList value="{!newStatus}">
        <apex:selectOption itemValue="Open" itemLabel="Open" />
        <apex:selectOption itemValue="Hold" itemLabel="Hold" />
        <apex:selectOption itemValue="Closed" itemLabel="Closed" />
      </apex:selectList>
      <apex:commandButton action="{!updateStatus}" value="Update" />
    </apex:form>
  </apex:pageBlock>
</apex:page>
```

```java
public with sharing class ContactUpdateExtension {
  public String newStatus {get; set;}
  private Issue__c issue;
  
  public ContactUpdateExtension(ApexPages.StandardController ctr) {
    String issueId = ctr.getRecord().Id
    issue = [SELECT Status__c FROM Issue__c WHERE Id= :issueId];
  }
  
  public PageReference updateStatus() {
    c.Status__c = statusToSet;
    update c;
    
    return null;
  }
}
```

Ok, our users can now change the status. Now, let's think for a minute: 
> What happen if the user do not have edit permission on the Status field but still can access the page?

Fields that are assigned values from a VisualForce page using the apex:inputField tag are automatically checked for the appropriate CRUD/FLS access. 
If a user does not have the correct access, VisualForce will render apex:inputField elements as read-only.

Unfortunately, our visualforce is not using an apex:inputField tag. FLS will not be handled by salesforce automatically.
Salesforce will through a nasty exception (nasty for user point for view).

Let's rewrite our code to be more user friendly.

```html
<apex:page standardcontroller="Issue__c" extensions="IssueUpdateExtension">
  <apex:pageMessages />
  <apex:pageBlock title="Issue">
    <apex:outputField value="{!Issue__c.Title__}" />
    <apex:form>
      <apex:selectList value="{!newStatus}">
        <apex:selectOption itemValue="Open" itemLabel="Open" />
        <apex:selectOption itemValue="Hold" itemLabel="Hold" />
        <apex:selectOption itemValue="Closed" itemLabel="Closed" />
      </apex:selectList>
      <apex:commandButton action="{!updateStatus}" value="Update" />
    </apex:form>
  </apex:pageBlock>
</apex:page>
```

```java
public with sharing class ContactUpdateExtension {
  public String newStatus {get; set;}
  private Issue__c issue;
  
  public ContactUpdateExtension(ApexPages.StandardController ctr) {
    String issueId = ctr.getRecord().Id
    issue = [SELECT Status__c FROM Issue__c WHERE Id= :issueId];
  }
  
  public PageReference updateStatus() {
    if (Utils.isFieldUpdateable('Issue__c', 'Status__c')) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Insufficient access to update status'));

      return null;
    }
    
    c.Status__c = statusToSet;
    update c;
    
    return null;
  }
}
```

Now, our user will be notified of the error with a nice human readable error.

## Notes & Reference
You could update this snippet and make an isFieldAccessible method using the the isAccessible method. See DescribeFieldResult Class reference for more details.

[More on Testing CRUD and FLS_Enforcement](https://developer.salesforce.com/page/Testing_CRUD_and_FLS_Enforcement)

[DescribeFieldResult Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_fields_describe.htm)
