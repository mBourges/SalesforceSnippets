@isTest
private class UtilsTest {
  static testmethod void getSObjectKeyPrefix_Test() {
    String expected = Account.sObjectType.getDescribe().getKeyPrefix();
    
    Test.startTest();
    String actual = Utils.getSObjectKeyPrefix('Account');
    Test.stopTest();
    
    System.assertEquals(expected, actual);
  }
  
  static testmethod void getSobjectRecordTypes_Test() {
    List<SelectOption> expected = new List<SelectOption>();
    
    for(Schema.RecordTypeInfo recordType : SObjectType.Account.getRecordTypeInfos()) {
      if(!recordType.isMaster() && recordType.isAvailable()) {
        expected.add(new SelectOption(recordType.getRecordTypeId(), recordType.getName()));
      }
    }
    
    Test.startTest();
    List<SelectOption> actual = Utils.getSobjectRecordTypes('Account');
    Test.stopTest();
    
    System.assertEquals(expected, actual);
  }
}
