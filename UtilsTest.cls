@isTest
private class UtilsTest {
  static testmethod void getSObjectKeyPrefix_Test() {
    String expected = Account.sObjectType.getDescribe().getKeyPrefix();
    
    Test.startTest();
    String actual = Utils.getSObjectKeyPrefix('Account');
    Test.stopTest();
    
    System.assertEquals(expected, actual);
  }
}
