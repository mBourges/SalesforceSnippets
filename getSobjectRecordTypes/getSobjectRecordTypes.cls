public static List<SelectOption> getSobjectRecordTypes(String sObjectName) {
  List<Schema.RecordTypeInfo> recordTypes = getRecordTypeDescription(sObjectName);
  
  return createOptionList(recordTypes);
}

private static List<Schema.RecordTypeInfo> getRecordTypeDescription(String sObjectName) {
  SObjectType objectSchema = Schema.getGlobalDescribe().get(sObjectName);
  Schema.DescribeSObjectResult objectDescription = objectSchema.getDescribe();
  
  return objectDescription.getRecordTypeInfos();
}

private static List<SelectOption> createOptionList(List<Schema.RecordTypeInfo> recordTypes) {
  List<SelectOption> options = new List<SelectOption>();
    
  for(Schema.RecordTypeInfo recordType : recordTypes) {
    if(!recordType .isMaster() && recordType .isAvailable()) {
      options.add(new SelectOption(recordType .getRecordTypeId(), recordType .getName()));
    }
  }
    
  return options;
}
